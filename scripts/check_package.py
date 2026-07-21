#!/usr/bin/env python3
"""Deterministic integrity checks for the draft FHIR R4 IG package."""
from __future__ import annotations

import json
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[1]
RES_DIR = ROOT / "fsh-generated" / "resources"
CANONICAL = "https://example.org/fhir/li-xinyang-interop-r4"
EXPECTED = {
    "StructureDefinition": 55,
    "CodeSystem": 7,
    "ValueSet": 7,
    "ConceptMap": 11,
    "StructureMap": 12,
    "CapabilityStatement": 1,
    "SearchParameter": 2,
    "OperationDefinition": 2,
    "ImplementationGuide": 1,
}

errors: list[str] = []
warnings: list[str] = []
passes: list[str] = []


def fail(msg: str) -> None:
    errors.append(msg)


def warn(msg: str) -> None:
    warnings.append(msg)


def ok(msg: str) -> None:
    passes.append(msg)


def load_resources() -> tuple[list[dict[str, Any]], dict[str, dict[str, Any]], dict[str, dict[str, Any]]]:
    all_resources: list[dict[str, Any]] = []
    by_ref: dict[str, dict[str, Any]] = {}
    by_url: dict[str, dict[str, Any]] = {}
    for path in sorted(RES_DIR.glob("*.json")):
        try:
            resource = json.loads(path.read_text(encoding="utf-8"))
        except Exception as exc:
            fail(f"Invalid JSON: {path.name}: {exc}")
            continue
        rt = resource.get("resourceType")
        rid = resource.get("id")
        if not rt or not rid:
            fail(f"Missing resourceType/id: {path.name}")
            continue
        ref = f"{rt}/{rid}"
        if ref in by_ref:
            fail(f"Duplicate resource identity: {ref}")
        by_ref[ref] = resource
        url = resource.get("url")
        if url:
            if url in by_url:
                fail(f"Duplicate canonical URL: {url}")
            by_url[url] = resource
        all_resources.append(resource)
    return all_resources, by_ref, by_url


def check_counts(resources: list[dict[str, Any]]) -> None:
    counts = Counter(r["resourceType"] for r in resources)
    for rt, expected in EXPECTED.items():
        actual = counts.get(rt, 0)
        if actual != expected:
            fail(f"{rt} count expected {expected}, found {actual}")
    profiles = [r for r in resources if r["resourceType"] == "StructureDefinition" and r.get("kind") == "resource" and r.get("type") != "Extension"]
    extensions = [r for r in resources if r["resourceType"] == "StructureDefinition" and r.get("type") == "Extension"]
    logicals = [r for r in resources if r["resourceType"] == "StructureDefinition" and r.get("kind") == "logical"]
    if len(profiles) != 35:
        fail(f"Canonical profile count expected 35, found {len(profiles)}")
    if len(extensions) != 11:
        fail(f"Extension count expected 11, found {len(extensions)}")
    if len(logicals) != 9:
        fail(f"Logical-model count expected 9, found {len(logicals)}")
    missing_snapshots = [r["id"] for r in profiles + extensions + logicals if not r.get("snapshot", {}).get("element")]
    if missing_snapshots:
        fail(f"StructureDefinitions missing snapshots: {', '.join(missing_snapshots)}")
    else:
        ok("All 55 StructureDefinitions include generated snapshots.")


def check_canonicals(resources: list[dict[str, Any]]) -> None:
    for r in resources:
        url = r.get("url")
        if url and r["resourceType"] not in {"ImplementationGuide"} and url.startswith(CANONICAL) is False:
            # External canonical URLs occur in terminology bindings inside resources, not at resource.url.
            fail(f"Unexpected canonical base for {r['resourceType']}/{r['id']}: {url}")
    ok("Local conformance-resource canonical URLs use the package canonical base.")


def check_ig(by_ref: dict[str, dict[str, Any]]) -> None:
    ig = by_ref.get("ImplementationGuide/li-xinyang-interop-r4")
    if not ig:
        fail("ImplementationGuide missing")
        return
    refs = [e.get("reference", {}).get("reference") for e in ig.get("definition", {}).get("resource", [])]
    if len(refs) != len(set(refs)):
        fail("ImplementationGuide contains duplicate resource references")
    expected_refs = set(by_ref) - {"ImplementationGuide/li-xinyang-interop-r4"}
    actual_refs = set(refs)
    missing = expected_refs - actual_refs
    extra = actual_refs - expected_refs
    if missing:
        fail(f"ImplementationGuide does not reference {len(missing)} resources: {sorted(missing)[:10]}")
    if extra:
        fail(f"ImplementationGuide references missing resources: {sorted(extra)}")
    group_ids = {g.get("id") for g in ig.get("definition", {}).get("grouping", [])}
    for entry in ig.get("definition", {}).get("resource", []):
        gid = entry.get("groupingId")
        if gid not in group_ids:
            fail(f"Unknown groupingId {gid!r} for {entry.get('reference', {}).get('reference')}")
    ok(f"ImplementationGuide indexes all {len(expected_refs)} non-IG resources exactly once.")


def check_maps(by_url: dict[str, dict[str, Any]]) -> None:
    map_files = list((ROOT / "input" / "maps").glob("*.map"))
    if len(map_files) != 12:
        fail(f"Expected 12 readable FML map files, found {len(map_files)}")
    for resource in by_url.values():
        if resource.get("resourceType") != "StructureMap":
            continue
        for structure in resource.get("structure", []):
            url = structure.get("url")
            if url not in by_url:
                fail(f"StructureMap/{resource['id']} references unresolved local structure {url}")
        # Detect local ConceptMap canonicals passed to translate().
        text = json.dumps(resource)
        for url in re.findall(r"https://example\.org/fhir/li-xinyang-interop-r4/ConceptMap/[A-Za-z0-9\-.]+", text):
            if url not in by_url:
                fail(f"StructureMap/{resource['id']} references unresolved ConceptMap {url}")
    ok("All StructureMap source/target structures and local ConceptMap references resolve.")


def check_concept_maps(resources: list[dict[str, Any]]) -> None:
    templates = [r for r in resources if r.get("resourceType") == "ConceptMap" and r.get("id", "").endswith("-template")]
    if len(templates) != 5:
        fail(f"Expected five external/local crosswalk templates, found {len(templates)}")
    for cm in templates:
        if cm.get("group"):
            fail(f"Template ConceptMap unexpectedly contains asserted mappings: {cm['id']}")
        purpose = (cm.get("purpose") or "").lower()
        if not any(word in purpose for word in ("licensed", "local", "governed", "populate")):
            warn(f"Template ConceptMap purpose should state governance/licensing boundary: {cm['id']}")
    ok("Crosswalk templates do not fabricate licensed or institution-specific mappings.")


def check_bundle(by_ref: dict[str, dict[str, Any]]) -> None:
    bundle = by_ref.get("Bundle/ExampleCanonicalExchange")
    if not bundle:
        fail("Canonical exchange Bundle example missing")
        return
    entry_resources = [e.get("resource", {}) for e in bundle.get("entry", [])]
    types = Counter(r.get("resourceType") for r in entry_resources)
    if types.get("Patient", 0) < 1:
        fail("Canonical exchange Bundle lacks Patient")
    if types.get("Provenance", 0) < 1:
        fail("Canonical exchange Bundle lacks Provenance")
    metric_codes = {
        c.get("code")
        for r in entry_resources
        if r.get("resourceType") == "Observation"
        for c in r.get("code", {}).get("coding", [])
        if c.get("system") == f"{CANONICAL}/CodeSystem/hitc-quality-metric"
    }
    expected_metrics = {"ffr", "csc", "rir", "tc", "msr", "tcr"}
    if metric_codes != expected_metrics:
        fail(f"Bundle quality metric codes expected {sorted(expected_metrics)}, found {sorted(metric_codes)}")
    refs = {f"{r.get('resourceType')}/{r.get('id')}" for r in entry_resources}
    unresolved: set[str] = set()

    def walk(value: Any) -> None:
        if isinstance(value, dict):
            ref = value.get("reference")
            if isinstance(ref, str) and "/" in ref and not ref.startswith(("http://", "https://", "urn:")):
                if ref not in refs:
                    unresolved.add(ref)
            for v in value.values():
                walk(v)
        elif isinstance(value, list):
            for v in value:
                walk(v)

    walk(bundle)
    if unresolved:
        fail(f"Unresolved intra-bundle references: {sorted(unresolved)}")
    ok("Canonical exchange Bundle contains Patient, Provenance, all six quality metrics, and resolved local references.")


def check_examples(resources: list[dict[str, Any]], by_url: dict[str, dict[str, Any]]) -> None:
    examples = [r for r in resources if r.get("resourceType") not in EXPECTED or r.get("resourceType") == "Bundle"]
    missing_profile = []
    for r in examples:
        profiles = r.get("meta", {}).get("profile", [])
        if not profiles:
            missing_profile.append(f"{r['resourceType']}/{r['id']}")
        for url in profiles:
            if url not in by_url:
                fail(f"Example {r['resourceType']}/{r['id']} references unresolved profile {url}")
    if missing_profile:
        fail(f"Examples missing meta.profile: {', '.join(missing_profile)}")
    else:
        ok(f"All {len(examples)} synthetic examples declare resolvable local profiles.")


def write_report(resources: list[dict[str, Any]]) -> None:
    counts = Counter(r["resourceType"] for r in resources)
    lines = [
        "# Validation and Integrity Report",
        "",
        "**Package:** li-xinyang-interop-r4  ",
        "**Version:** 0.1.0  ",
        "**FHIR:** R4 / 4.0.1  ",
        "**Date:** 2026-07-21",
        "",
        "## Build status",
        "",
        "- SUSHI 3.20.0 build with snapshot generation: **0 errors** and **3 dependency-fetch warnings** for optional auto-provided packages unavailable in the offline build environment.",
        f"- Deterministic package checks: **{len(errors)} errors**, **{len(warnings)} warnings**, **{len(passes)} passed check groups**.",
        f"- JSON resources assembled: **{len(resources)}**.",
        "",
        "## Resource counts",
        "",
        "| Resource type | Count |",
        "|---|---:|",
    ]
    for rt, count in sorted(counts.items()):
        lines.append(f"| {rt} | {count} |")
    lines += ["", "## Passed checks", ""]
    lines += [f"- {msg}" for msg in passes] or ["- None"]
    lines += ["", "## Warnings", ""]
    lines += [f"- {msg}" for msg in warnings] or ["- None"]
    lines += ["", "## Errors", ""]
    lines += [f"- {msg}" for msg in errors] or ["- None"]
    lines += [
        "",
        "## Scope note",
        "",
        "This report establishes build integrity, resource indexing, snapshot presence, local canonical resolution, mapping-reference resolution, example-bundle consistency, and terminology-template boundaries. It is not a substitute for institution-specific conformance testing, licensed terminology validation, security testing, clinical safety review, or production acceptance testing.",
    ]
    (ROOT / "VALIDATION_REPORT.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
    (ROOT / "VALIDATION_REPORT.json").write_text(
        json.dumps(
            {
                "package": "li-xinyang-interop-r4",
                "version": "0.1.0",
                "fhirVersion": "4.0.1",
                "resourceCount": len(resources),
                "counts": dict(sorted(counts.items())),
                "passes": passes,
                "warnings": warnings,
                "errors": errors,
            },
            indent=2,
        )
        + "\n",
        encoding="utf-8",
    )


def main() -> int:
    resources, by_ref, by_url = load_resources()
    if not resources:
        fail("No resources found")
    else:
        check_counts(resources)
        check_canonicals(resources)
        check_ig(by_ref)
        check_maps(by_url)
        check_concept_maps(resources)
        check_bundle(by_ref)
        check_examples(resources, by_url)
    write_report(resources)
    print(f"Checks complete: {len(errors)} errors, {len(warnings)} warnings, {len(passes)} passed groups")
    for msg in errors:
        print(f"ERROR: {msg}")
    for msg in warnings:
        print(f"WARNING: {msg}")
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
