#!/usr/bin/env python3
"""Assemble generated and hand-authored FHIR R4 artifacts into a reproducible IG package."""
from __future__ import annotations

import csv
import hashlib
import json
import os
import shutil
import tarfile
from collections import Counter
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[1]
GENERATED = ROOT / "fsh-generated" / "resources"
INPUT_RESOURCES = ROOT / "input" / "resources"
DIST = ROOT / "dist"
FHIR_PACKAGE_ROOT = DIST / "fhir-packages" / "li-xinyang-interop-r4#0.1.0"
FHIR_PACKAGE = FHIR_PACKAGE_ROOT / "package"
CANONICAL = "https://example.org/fhir/li-xinyang-interop-r4"
VERSION = "0.1.0"

GROUPS = [
    ("profiles", "Canonical Profiles", "Strict-at-core constrained FHIR R4 clinical and administrative resource profiles."),
    ("extensions", "Registered Extensions", "Extensions for source identity, mapping provenance, validation stages, quality metrics, and tamper-evident lineage."),
    ("logical-models", "Source Logical Models", "Normalized logical input models for representative HL7 v2 segments and C-CDA entries."),
    ("terminology", "Terminology and Concept Mapping", "CodeSystems, ValueSets, and ConceptMaps used by the terminology bridge."),
    ("structure-maps", "Structural Mapping", "FHIR StructureMap resources for Phase 1 structural transformation."),
    ("operations", "API and Conformance Contracts", "CapabilityStatement, SearchParameter, and OperationDefinition artifacts."),
    ("examples", "Synthetic Examples", "Synthetic examples demonstrating profiles, inline quality observations, exchange bundles, and provenance."),
]
GROUP_ORDER = {g[0]: i for i, g in enumerate(GROUPS)}


def read_json(path: Path) -> dict[str, Any]:
    with path.open(encoding="utf-8") as f:
        return json.load(f)


def write_json(path: Path, value: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8", newline="\n") as f:
        json.dump(value, f, ensure_ascii=False, indent=2)
        f.write("\n")


def reference_for(resource: dict[str, Any]) -> str:
    return f"{resource['resourceType']}/{resource['id']}"


def title_for(resource: dict[str, Any]) -> str:
    """Return a human-readable title without confusing repeating FHIR name fields with canonical names."""
    title = resource.get("title")
    if isinstance(title, str) and title.strip():
        return title
    name = resource.get("name")
    if isinstance(name, str) and name.strip():
        return name
    rid = resource.get("id")
    if isinstance(rid, str) and rid.strip():
        return rid
    return reference_for(resource)


def group_for(resource: dict[str, Any]) -> str:
    rt = resource.get("resourceType")
    if rt == "StructureDefinition":
        if resource.get("kind") == "logical":
            return "logical-models"
        if resource.get("type") == "Extension":
            return "extensions"
        return "profiles"
    if rt in {"CodeSystem", "ValueSet", "ConceptMap"}:
        return "terminology"
    if rt == "StructureMap":
        return "structure-maps"
    if rt in {"CapabilityStatement", "SearchParameter", "OperationDefinition"}:
        return "operations"
    return "examples"


def infer_kind(resource: dict[str, Any]) -> str | None:
    rt = resource.get("resourceType")
    if rt == "StructureDefinition":
        if resource.get("kind") == "logical":
            return "logical"
        if resource.get("type") == "Extension":
            return "extension"
        return "profile"
    if rt == "CapabilityStatement":
        return "capability"
    if rt in {"CodeSystem", "ValueSet", "ConceptMap", "StructureMap", "SearchParameter", "OperationDefinition", "ImplementationGuide"}:
        return rt.lower()
    return "instance"


def copy_manual_resources() -> None:
    GENERATED.mkdir(parents=True, exist_ok=True)
    for path in sorted(INPUT_RESOURCES.glob("*.json")):
        shutil.copy2(path, GENERATED / path.name)


def refresh_embedded_bundle_examples() -> None:
    """Keep the canonical exchange Bundle synchronized with standalone synthetic examples."""
    bundle_path = GENERATED / "Bundle-ExampleCanonicalExchange.json"
    if not bundle_path.exists():
        return
    bundle = read_json(bundle_path)
    for entry in bundle.get("entry", []):
        embedded = entry.get("resource", {})
        rt = embedded.get("resourceType")
        rid = embedded.get("id")
        if not rt or not rid or rt == "Bundle":
            continue
        standalone = GENERATED / f"{rt}-{rid}.json"
        if standalone.exists():
            entry["resource"] = read_json(standalone)
    write_json(bundle_path, bundle)


def patch_implementation_guide() -> None:
    ig_path = GENERATED / "ImplementationGuide-li-xinyang-interop-r4.json"
    ig = read_json(ig_path)

    resources: dict[str, dict[str, Any]] = {}
    for path in sorted(GENERATED.glob("*.json")):
        resource = read_json(path)
        if resource.get("resourceType") == "ImplementationGuide":
            continue
        resources[reference_for(resource)] = resource

    definition = ig.setdefault("definition", {})
    definition.pop("parameter", None)
    definition["grouping"] = [
        {"id": gid, "name": name, "description": description}
        for gid, name, description in GROUPS
    ]

    entries: list[dict[str, Any]] = []
    for ref, resource in resources.items():
        entry: dict[str, Any] = {
            "reference": {"reference": ref},
            "name": title_for(resource),
            "groupingId": group_for(resource),
        }
        description = resource.get("description")
        if description:
            entry["description"] = description

        meta_profiles = resource.get("meta", {}).get("profile", [])
        if group_for(resource) == "examples":
            if meta_profiles:
                entry["exampleCanonical"] = meta_profiles[0]
            else:
                entry["exampleBoolean"] = True
        else:
            entry["exampleBoolean"] = False
        entries.append(entry)

    entries.sort(
        key=lambda e: (
            GROUP_ORDER[e["groupingId"]],
            e.get("name", "").lower(),
            e["reference"]["reference"],
        )
    )
    ig["definition"]["resource"] = entries
    write_json(ig_path, ig)


def build_fhir_npm_package() -> Path:
    if FHIR_PACKAGE_ROOT.exists():
        shutil.rmtree(FHIR_PACKAGE_ROOT)
    FHIR_PACKAGE.mkdir(parents=True, exist_ok=True)

    package_json = {
        "name": "li-xinyang-interop-r4",
        "version": VERSION,
        "description": "Draft FHIR R4 implementation guide for the Li Xinyang FHIR-native interoperability and data-quality methodology.",
        "type": "fhir.ig",
        "canonical": CANONICAL,
        "url": f"{CANONICAL}/ImplementationGuide/li-xinyang-interop-r4",
        "title": "Li Xinyang FHIR-Native Interoperability and Data-Quality Framework (R4)",
        "author": "Xinyang Li",
        "license": "Apache-2.0",
        "fhirVersions": ["4.0.1"],
        "dependencies": {"hl7.fhir.r4.core": "4.0.1"},
    }
    write_json(FHIR_PACKAGE / "package.json", package_json)

    index_files: list[dict[str, Any]] = []
    for path in sorted(GENERATED.glob("*.json")):
        resource = read_json(path)
        destination = FHIR_PACKAGE / path.name
        shutil.copy2(path, destination)
        record: dict[str, Any] = {
            "filename": path.name,
            "resourceType": resource.get("resourceType"),
            "id": resource.get("id"),
        }
        for key in ("url", "version", "kind", "type"):
            if key in resource:
                record[key] = resource[key]
        inferred = infer_kind(resource)
        if inferred and "kind" not in record:
            record["kind"] = inferred
        index_files.append(record)
    write_json(FHIR_PACKAGE / ".index.json", {"index-version": 1, "files": index_files})

    archive = DIST / f"li-xinyang-interop-r4-{VERSION}.tgz"
    if archive.exists():
        archive.unlink()
    with tarfile.open(archive, "w:gz", format=tarfile.PAX_FORMAT) as tf:
        tf.add(FHIR_PACKAGE, arcname="package")

    digest = hashlib.sha256(archive.read_bytes()).hexdigest()
    write_json(
        DIST / "package-manifest.json",
        {
            "package": package_json,
            "archive": archive.name,
            "sha256": digest,
            "resourceCount": len(index_files),
        },
    )
    return archive


def build_inventory() -> None:
    resources = [read_json(p) for p in sorted(GENERATED.glob("*.json"))]
    rows: list[dict[str, Any]] = []
    for resource in resources:
        rt = resource.get("resourceType", "")
        ref = reference_for(resource)
        rows.append(
            {
                "resourceType": rt,
                "id": resource.get("id", ""),
                "title": title_for(resource),
                "url": resource.get("url", ""),
                "version": resource.get("version", ""),
                "status": resource.get("status", ""),
                "group": "implementation-guide" if rt == "ImplementationGuide" else group_for(resource),
                "file": next((p.name for p in GENERATED.glob(f"{rt}-{resource.get('id')}.json")), ""),
                "reference": ref,
            }
        )
    rows.sort(key=lambda r: (r["group"], r["resourceType"], r["id"]))

    csv_path = ROOT / "ARTIFACT_INVENTORY.csv"
    with csv_path.open("w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
        writer.writeheader()
        writer.writerows(rows)

    counts = Counter(r["resourceType"] for r in rows)
    md = [
        "# Artifact Inventory",
        "",
        f"Generated: 2026-07-21  ",
        f"FHIR version: R4 / 4.0.1  ",
        f"Package version: {VERSION}  ",
        f"Total JSON resources: **{len(rows)}**",
        "",
        "## Counts by resource type",
        "",
        "| Resource type | Count |",
        "|---|---:|",
    ]
    for rt, count in sorted(counts.items()):
        md.append(f"| {rt} | {count} |")
    md += [
        "",
        "## Detailed inventory",
        "",
        "| Group | Resource | Title | Canonical URL |",
        "|---|---|---|---|",
    ]
    for row in rows:
        url = row["url"] or "—"
        md.append(f"| {row['group']} | `{row['reference']}` | {row['title']} | `{url}` |")
    (ROOT / "ARTIFACT_INVENTORY.md").write_text("\n".join(md) + "\n", encoding="utf-8")


def main() -> None:
    copy_manual_resources()
    refresh_embedded_bundle_examples()
    patch_implementation_guide()
    archive = build_fhir_npm_package()
    build_inventory()
    print(f"Assembled resources in {GENERATED}")
    print(f"Built FHIR package: {archive}")


if __name__ == "__main__":
    main()
