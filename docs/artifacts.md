# FHIR Artifact Catalog

## Overview

This page summarizes the machine-consumable HL7 FHIR R4 artifacts included in this repository.

The artifacts formalize the clinical data interoperability methodology into executable FHIR resources.

---

# ImplementationGuide

## FHIR R4 Interoperability Framework

Primary conformance artifact:

- ImplementationGuide resource
- FHIR package metadata
- Dependency and publication definitions

---

# StructureDefinition Profiles

The repository includes executable FHIR R4 profiles defining constrained clinical resources.

Representative profiles include:

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

Define a canonical clinical data exchange model with enforceable constraints.

---

# Extension Definitions

Framework-specific extensions capture:

- Source system metadata
- Mapping strategy
- Mapping confidence
- Validation status
- Provenance information
- Quality metrics

---

# ConceptMaps

ConceptMap artifacts define semantic reconciliation rules.

Examples:

- HL7 v2 terminology mappings
- Clinical concept normalization
- Code system reconciliation

Purpose:

Enable consistent semantic interpretation across institutions.

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

Included:

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
