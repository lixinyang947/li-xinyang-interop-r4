# Two-Phase Mapping Pipeline

## Phase 1 — Structural transformation

HL7 v2 and C-CDA inputs are represented as normalized logical models and transformed with StructureMap resources. Included mappings cover:

- PID → Patient
- PV1 → Encounter
- OBX → Observation
- OBR → DiagnosticReport
- ORC → ServiceRequest
- SCH → planned Encounter
- TXA → DocumentReference
- C-CDA Problem → Condition
- C-CDA Allergy → AllergyIntolerance
- C-CDA Procedure → Procedure
- C-CDA Medication → MedicationStatement
- C-CDA Discharge Medication → MedicationRequest

The `.map` files are readable FHIR Mapping Language source. The JSON StructureMap resources are the canonical FHIR artifacts.

## Phase 2 — Semantic reconciliation

ConceptMap resources support representative HL7 v2 status, class, administrative sex, and abnormal-flag translation. Mapping provenance is recorded through strategy, confidence, original-code, reviewer, and transformation-step metadata.

Crosswalks whose content depends on licensing, local codes, releases, or governance are supplied as intentionally empty templates rather than invented mappings.
