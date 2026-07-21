Profile: HITCCanonicalConsent
Parent: Consent
Id: hitc-canonical-consent
Title: "HITC Canonical Consent"
Description: "Consent profile supporting consent-aware exchange governance."
* insert HITCStrictCoreMetadata
* identifier 1..*
* patient 1..1
* patient only Reference(HITCCanonicalPatient)
* dateTime 1..1
* performer 1..*
* organization 1..*
* organization only Reference(HITCCanonicalOrganization)
* policyRule 1..1
* provision 1..1

Profile: HITCCanonicalProvenance
Parent: Provenance
Id: hitc-canonical-provenance
Title: "HITC Canonical Provenance"
Description: "Append-only resource-level lineage record for mapping, validation, and terminology operations."
* insert HITCStrictCoreMetadata
* occurred[x] 1..1
* reason 1..*
* activity 1..1
* activity from HITCTransformationActivityVS (required)
* agent 1..*
* entity 1..*
* extension contains HITCSourceFormat named sourceFormat 1..1 and HITCMappingStrategy named mappingStrategy 0..1 and HITCMappingConfidence named mappingConfidence 0..1 and HITCMappingReviewer named mappingReviewer 0..1 and HITCTransformationStep named transformationStep 1..* and HITCValidationStage named validationStage 0..* and HITCMerkleRoot named merkleRoot 1..1

Profile: HITCCanonicalAuditEvent
Parent: AuditEvent
Id: hitc-canonical-audit-event
Title: "HITC Canonical Audit Event"
Description: "Security and access audit event for the exchange gateway."
* insert HITCStrictCoreMetadata
* subtype 1..*
* action 1..1
* outcome 1..1
* agent 1..*
* entity 1..*

Profile: HITCExchangeBundle
Parent: Bundle
Id: hitc-exchange-bundle
Title: "HITC Canonical Exchange Bundle"
Description: "Validated output bundle carrying canonical resources, inline quality observations, and provenance."
* obeys hitc-bundle-patient and hitc-bundle-provenance
* meta.profile 1..*
* identifier 1..1
* type = #collection
* timestamp 1..1
* entry 1..*
* entry.fullUrl 1..1
* entry.resource 1..1

