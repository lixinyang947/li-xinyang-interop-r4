
# Li Xinyang FHIR-Native Interoperability and Data-Quality Framework — FHIR R4 Draft IG
## Overview
## Online Documentation

Public documentation site:

https://lixinyang947.github.io/li-xinyang-interop-r4/

## Release

Latest version:

v0.1.0

GitHub Release:

https://github.com/lixinyang947/li-xinyang-interop-r4/releases/tag/v0.1.0

This repository presents the FHIR R4 implementation of the FHIR-Native Clinical Data Interoperability and Data-Quality Framework developed by Xinyang Li.

The framework transforms a methodological interoperability approach into machine-consumable HL7 FHIR R4 artifacts, including executable StructureDefinitions, ImplementationGuide resources, ConceptMaps, StructureMaps, terminology resources, and validation specifications.

This repository represents a draft technical specification and reference implementation package.
**Version:** 0.1.0  
**Date:** 2026-07-21  
**FHIR version:** R4 / 4.0.1  
**Status:** Draft and experimental  
**Methodology author:** Xinyang Li
---

## Original Methodological Contribution

This repository formalizes a FHIR-native clinical data interoperability methodology into executable HL7 FHIR R4 artifacts.

The framework addresses cross-institutional clinical data interoperability through six technical components:

1. Canonical FHIR R4 Data Model
2. Two-Phase Mapping Pipeline
3. Terminology Reconciliation Framework
4. Validation and Data Quality Pipeline
5. Provenance and Lineage Tracking
6. Federated Query Workflow

The methodology separates structural transformation from semantic reconciliation using HL7 FHIR StructureMap and ConceptMap artifacts.

---

## Technical Architecture

Clinical Data Sources:

HL7 v2 / C-CDA / Existing FHIR Systems

---

## FHIR Artifacts Included

| Artifact Type | Quantity |
|---|---:|
| ImplementationGuide | 1 |
| StructureDefinition | 55 |
| FHIR Profiles | 35 |
| Extension Definitions | 11 |
| ConceptMaps | 11 |
| StructureMaps | 12 |
| CodeSystems | 7 |
| ValueSets | 7 |

---

## Validation Status

FHIR Version:

FHIR R4 (4.0.1)

Current Release:

v0.1.0

Validation Status:

- StructureDefinition generation completed
- FHIR package assembled
- Artifact consistency checks completed
- Offline validation completed

Current maturity:

Draft / Experimental Technical Specification

---

## Repository Structure

---

## Citation

Xinyang Li.

FHIR-Native Clinical Data Interoperability Framework.

FHIR R4 Implementation Guide v0.1.0.

GitHub Release, 2026.

Repository:

https://github.com/lixinyang947/li-xinyang-interop-r4
This package translates the two supplied methodology narratives into machine-consumable FHIR R4 artifacts. It is a technical specification and concept-of-concept package, not evidence of a completed production deployment.

## Included artifacts

- 35 strict-at-core FHIR R4 resource profiles.
- 11 registered extensions for source identity, mapping provenance, validation stages, quality metrics, and tamper-evident lineage.
- 9 normalized source logical models for representative HL7 v2 segments and C-CDA entries.
- 7 CodeSystems, 7 ValueSets, 11 ConceptMaps, and 12 StructureMaps, with 12 readable FHIR Mapping Language `.map` sources.
- 1 generated ImplementationGuide, 1 CapabilityStatement, 2 draft OperationDefinitions, and 2 SearchParameters.
- 17 standalone synthetic examples and 1 canonical exchange Bundle.
- Artifact inventory, methodology-to-artifact traceability matrix, validation reports, and a FHIR NPM package.

The assembled package contains 116 JSON resources, including 55 StructureDefinitions with generated snapshots.

## Repository layout

```text
input/fsh/                 FSH source for profiles, extensions, terminology, and examples
input/resources/           Hand-authored ConceptMap, StructureMap, CapabilityStatement, and other JSON
input/maps/                Human-readable FHIR Mapping Language source
input/pagecontent/         Implementation Guide narrative pages
fsh-generated/resources/   SUSHI-generated and assembled FHIR JSON
source_documents/          Supplied methodology PDFs and SHA-256 checksums
scripts/                   Build, assembly, integrity-check, and offline-validation scripts
dist/                      FHIR NPM package directory and distributable `.tgz`
```

## Reproducible build

Prerequisites: Node.js 20 or later, npm, and Python 3.10 or later.

```bash
npm ci
npm run build
```

The build pipeline runs, in order:

1. SUSHI 3.20.0 compilation with snapshot generation;
2. assembly of generated and hand-authored artifacts into the ImplementationGuide;
3. creation of the FHIR NPM package and inventory;
4. deterministic package-integrity checks;
5. offline R4 validation of all non-StructureDefinition JSON resources.

Individual stages:

```bash
npm run build:fsh
npm run assemble
npm run check
npm run validate:offline
```

## Validation scope

The final local build completed with no SUSHI errors, no deterministic-check errors or warnings, and no fatal/error/warning findings in the offline validation of 61 non-StructureDefinition resources. The remaining SUSHI messages are three dependency-fetch warnings for optional auto-provided packages that were unavailable in the build environment. See `VALIDATION_REPORT.md` and `OFFLINE_FHIR_VALIDATION_REPORT.md` for scope and limitations.

The package has not been run through the official HL7 Java validator and does not replace a live terminology-server pass, licensed terminology review, institution-specific conformance testing, security testing, clinical-safety review, or production acceptance testing.

## Publication boundaries

- The canonical base is `https://example.org/fhir/li-xinyang-interop-r4`; replace it with a controlled, durable domain before publication.
- NDC→RxNorm, ICD-9-CM→ICD-10-CM, and local-code crosswalks are intentionally empty governance templates. No licensed or institution-specific mappings are fabricated.
- HL7 v2 and C-CDA StructureMaps begin from normalized logical inputs after transport parsing and document/segment extraction.
- TF-IDF matching, live `$validate-code`, Merkle-tree storage, and federated-query runtime components are method and interface contracts, not completed services.
- All examples are synthetic and all performance figures remain targets or concept-of-concept values.

See `METHODOLOGY_ASSUMPTIONS.md` for the complete assumptions register.
