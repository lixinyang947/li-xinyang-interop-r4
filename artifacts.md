# FHIR Artifact Catalog

## Overview

This page summarizes the machine-consumable HL7 FHIR R4 artifacts included in this repository.

The artifacts formalize the interoperability methodology into executable FHIR resources.

---

# ImplementationGuide

## Li Xinyang FHIR R4 Interoperability Framework

Primary conformance artifact:

- ImplementationGuide resource
- FHIR package metadata
- Publication and dependency definitions

---

# StructureDefinition Profiles

The repository contains executable FHIR R4 profiles defining constrained clinical resources.

Included profiles cover:

- Patient
- Encounter
- Observation
- DiagnosticReport
- Condition
- Procedure
- MedicationRequest
- AllergyIntolerance
- Immunization
- DocumentReference
- Provenance

Purpose:

Define canonical clinical data exchange structures with enforceable constraints.

---

# Extensions

Custom extensions capture framework-specific metadata including:

- Source system information
- Mapping strategy
- Mapping confidence
- Validation status
- Provenance information
- Quality metrics

---

# ConceptMaps

ConceptMap artifacts define semantic reconciliation rules.

Examples:

- HL7 v2 code mappings
- Terminology normalization
- Clinical concept translation

Purpose:

Enable controlled terminology interoperability.

---

# StructureMaps

StructureMap artifacts define structural transformation rules.

Examples:

Purpose:

Provide reusable and auditable transformation logic.

---

# Terminology Resources

Included:

- CodeSystems
- ValueSets
- Mapping terminology resources

Purpose:

Support terminology validation and semantic consistency.

---

# Validation Documentation

Included documentation:

- Build reports
- Validation reports
- Artifact inventory
- Traceability matrix

Purpose:

Provide reproducibility and quality assurance evidence.

---

# Artifact Summary

| Artifact Type | Quantity |
|---|---:|
| ImplementationGuide | 1 |
| StructureDefinition | 55 |
| Profiles | 35 |
| Extensions | 11 |
| ConceptMaps | 11 |
| StructureMaps | 12 |
| CodeSystems | 7 |
| ValueSets | 7 |
