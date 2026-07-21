# Canonical Profiles

## Administrative and exchange context

Patient, RelatedPerson, Practitioner, PractitionerRole, Organization, Location, Encounter, EpisodeOfCare, Coverage, Consent, Composition, DocumentReference, AuditEvent, Provenance, and Exchange Bundle.

## Clinical data

Observation, Laboratory Observation, Quality Metric Observation, Condition, DiagnosticReport, Procedure, AllergyIntolerance, Immunization, Medication, MedicationRequest, MedicationStatement, MedicationAdministration, ServiceRequest, Specimen, Device, DeviceUseStatement, CarePlan, CareTeam, Goal, and QuestionnaireResponse.

## Strict-at-core rule

Every canonical resource declares a profile and a source-system identifier. Profiles add selected mandatory identifiers, status, subject, code, temporal, reference, and terminology requirements according to the role of each resource. The extension catalog preserves institution-specific information without weakening the exchange primitives.

The profile inventory and canonical URLs are listed in `ARTIFACT_INVENTORY.md` and the generated ImplementationGuide resource.
