#!/usr/bin/env node
/**
 * Offline JSON validation for assembled FHIR R4 resources.
 *
 * Uses the package's generated snapshots and a bundled R4 core package. Instances
 * are validated against their declared meta.profile; conformance resources are
 * validated against their R4 base resource StructureDefinition.
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { bundledProfilesPath } from '@records-fhir/bundled-profiles';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const resourcesDir = path.join(root, 'fsh-generated', 'resources');
const packageRoot = path.join(root, 'dist', 'fhir-packages');
const jsonReportPath = path.join(root, 'OFFLINE_FHIR_VALIDATION_REPORT.json');
const mdReportPath = path.join(root, 'OFFLINE_FHIR_VALIDATION_REPORT.md');

// The validator's terminology loader reads a single FHIR package-cache root.
// Build a lightweight cache from symlinks so both local CodeSystems/ValueSets and
// the bundled R4 core package resolve without copying large dependency trees.
const validatorCache = path.join(root, '.validator-cache');
fs.rmSync(validatorCache, { recursive: true, force: true });
fs.mkdirSync(validatorCache, { recursive: true });
for (const [name, target] of [
  ['li-xinyang-interop-r4#0.1.0', path.join(packageRoot, 'li-xinyang-interop-r4#0.1.0')],
  ['hl7.fhir.r4.core#4.0.1', path.join(bundledProfilesPath, 'hl7.fhir.r4.core#4.0.1')],
]) {
  // The terminology loader ignores top-level symlink Dirents. Create a real
  // package directory and symlink only its package/ payload.
  const packageDir = path.join(validatorCache, name);
  fs.mkdirSync(packageDir, { recursive: true });
  fs.symlinkSync(path.join(target, 'package'), path.join(packageDir, 'package'), 'dir');
}
process.env.FHIR_PACKAGE_CACHE_PATH = validatorCache;

const {
  recordsValidator,
  setProfileSource,
  createFilesystemProfileSource,
} = await import('@records-fhir/validator');

setProfileSource(createFilesystemProfileSource({
  packageDirs: [bundledProfilesPath, packageRoot],
}));

const files = fs.readdirSync(resourcesDir)
  .filter((name) => name.endsWith('.json'))
  .sort();

const results = [];
const totals = { resources: 0, fatal: 0, error: 0, warning: 0, information: 0, info: 0, totalIssues: 0 };

for (const file of files) {
  const fullPath = path.join(resourcesDir, file);
  const resource = JSON.parse(fs.readFileSync(fullPath, 'utf8'));
  if (!resource?.resourceType) continue;
  // StructureDefinitions are compiled and snapshot-tested by SUSHI. A second
  // pass adds hundreds of non-actionable publisher-build-extension warnings,
  // so this report focuses on the remaining executable/conformance resources.
  if (resource.resourceType === 'StructureDefinition') continue;

  const declaredProfiles = Array.isArray(resource?.meta?.profile) ? resource.meta.profile : [];
  const profileUrl = declaredProfiles[0]
    ?? `http://hl7.org/fhir/StructureDefinition/${resource.resourceType}`;

  let issues;
  try {
    issues = await recordsValidator.validate(resource, profileUrl, 'R4');
  } catch (error) {
    issues = [{
      severity: 'fatal',
      code: 'validator-exception',
      path: '',
      message: error instanceof Error ? error.message : String(error),
    }];
  }

  const counts = { fatal: 0, error: 0, warning: 0, information: 0, info: 0, total: issues.length };
  for (const issue of issues) {
    const severity = issue.severity ?? 'information';
    if (!(severity in counts)) counts.information += 1;
    else counts[severity] += 1;
  }

  totals.resources += 1;
  totals.fatal += counts.fatal;
  totals.error += counts.error;
  totals.warning += counts.warning;
  totals.information += counts.information;
  totals.info += counts.info;
  totals.totalIssues += counts.total;

  results.push({
    file,
    resourceType: resource.resourceType,
    id: resource.id ?? null,
    profileUrl,
    counts,
    issues: issues.map((issue) => ({
      severity: issue.severity ?? 'information',
      code: issue.code ?? null,
      path: issue.path ?? null,
      message: issue.message ?? issue.humanReadable ?? null,
      ruleId: issue.ruleId ?? null,
      validationMethod: issue.validationMethod ?? null,
    })),
  });
}

const report = {
  package: 'li-xinyang-interop-r4',
  version: '0.1.0',
  fhirVersion: '4.0.1',
  validator: '@records-fhir/validator 0.4.2',
  generatedAt: new Date().toISOString(),
  scope: 'All assembled non-StructureDefinition JSON resources. Instances use the first declared meta.profile; conformance resources use the R4 base resource profile. StructureDefinitions are covered by the SUSHI snapshot build and deterministic package checks.',
  totals,
  results,
};
fs.writeFileSync(jsonReportPath, `${JSON.stringify(report, null, 2)}\n`);

const problemResults = results.filter((r) => r.counts.fatal || r.counts.error || r.counts.warning);
const md = [
  '# Offline FHIR R4 JSON Validation Report',
  '',
  '**Package:** `li-xinyang-interop-r4#0.1.0`  ',
  '**FHIR version:** R4 / 4.0.1  ',
  '**Validator:** `@records-fhir/validator` 0.4.2 with bundled R4 core profiles and local generated snapshots  ',
  `**Non-StructureDefinition resources checked:** ${totals.resources}`,
  '',
  '## Summary',
  '',
  `- Fatal: **${totals.fatal}**`,
  `- Error: **${totals.error}**`,
  `- Warning: **${totals.warning}**`,
  `- Informational: **${totals.information + totals.info}**`,
  `- Total issues: **${totals.totalIssues}**`,
  '',
  '## Error and warning detail',
  '',
];
if (problemResults.length === 0) {
  md.push('- No fatal, error, or warning findings.');
} else {
  for (const result of problemResults) {
    md.push(`### \`${result.resourceType}/${result.id ?? '(no id)'}\``);
    md.push('');
    md.push(`Profile: \`${result.profileUrl}\``);
    md.push('');
    for (const issue of result.issues.filter((i) => ['fatal', 'error', 'warning'].includes(i.severity))) {
      md.push(`- **${issue.severity.toUpperCase()}** \`${issue.code ?? 'unknown'}\` at \`${issue.path ?? ''}\`: ${issue.message ?? ''}`);
    }
    md.push('');
  }
}
md.push('## Scope and limitations');
md.push('');
md.push('This offline pass validates non-StructureDefinition JSON resources against R4 base definitions or declared local profiles, including JSON structure, FHIRPath invariants, local terminology, and selected reference behavior. The 55 StructureDefinitions are compiled separately by SUSHI with generated snapshots and deterministic snapshot checks. Neither pass replaces the official HL7 Java validator, a live terminology server, licensed crosswalk validation, clinical-safety review, or institution-specific acceptance testing. Informational findings—such as recommendations for narrative text or version metadata—are retained in the JSON report.');
fs.writeFileSync(mdReportPath, `${md.join('\n')}\n`);

console.log(`Validated ${totals.resources} resources: ${totals.fatal} fatal, ${totals.error} error, ${totals.warning} warning, ${totals.information + totals.info} informational.`);
process.exit(totals.fatal || totals.error ? 1 : 0);
