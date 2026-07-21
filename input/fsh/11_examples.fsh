Instance: ExampleHospital
InstanceOf: HITCCanonicalOrganization
Usage: #example
Title: "Example Regional Medical Center"
* extension[sourceSystem].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceSystem].valueIdentifier.value = "urn:oid:1.2.840.114350.1.13.99999.1.7.2.688879"
* identifier.system = "https://example.org/fhir/sid/organization"
* identifier.value = "HOSP-A"
* active = true
* type.coding.system = "http://terminology.hl7.org/CodeSystem/organization-type"
* type.coding.code = #prov
* type.coding.display = "Healthcare Provider"
* name = "Example Regional Medical Center"

Instance: ExampleSourceEHR
InstanceOf: HITCCanonicalDevice
Usage: #example
Title: "Example Source EHR"
* extension[sourceSystem].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceSystem].valueIdentifier.value = "urn:oid:1.2.840.114350.1.13.99999.1.7.2.688879"
* identifier.system = "https://example.org/fhir/sid/source-system"
* identifier.value = "EHR-CERNER-01"
* status = #active
* type.text = "Electronic health record source system"
* manufacturer = "Example EHR Vendor"
* deviceName.name = "Source EHR Gateway 01"
* deviceName.type = #user-friendly-name

Instance: ExampleReviewer
InstanceOf: HITCCanonicalPractitioner
Usage: #example
Title: "Example Mapping Reviewer"
* extension[sourceSystem].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceSystem].valueIdentifier.value = "urn:oid:1.2.840.114350.1.13.99999.1.7.2.688879"
* identifier.system = "https://example.org/fhir/sid/practitioner"
* identifier.value = "REV-1001"
* name.family = "Reviewer"
* name.given = "Alex"
* qualification.identifier.system = "https://example.org/fhir/sid/credential"
* qualification.identifier.value = "CI-1001"
* qualification.code.coding.system = "http://terminology.hl7.org/CodeSystem/v2-0360"
* qualification.code.coding.code = #MD
* qualification.code.text = "Clinical informatics reviewer"

Instance: ExamplePatient
InstanceOf: HITCCanonicalPatient
Usage: #example
Title: "Example Canonical Patient"
* extension[sourceSystem].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceSystem].valueIdentifier.value = "urn:oid:1.2.840.114350.1.13.99999.1.7.2.688879"
* identifier.system = "https://example.org/fhir/sid/mrn"
* identifier.value = "MRN-100045"
* name.use = #official
* name.family = "Chen"
* name.given = "Mei"
* gender = #female
* birthDate = "1985-03-12"
* managingOrganization = Reference(ExampleHospital)

Instance: ExampleLocation
InstanceOf: HITCCanonicalLocation
Usage: #example
Title: "Example Cardiology Clinic"
* extension[sourceSystem].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceSystem].valueIdentifier.value = "urn:oid:1.2.840.114350.1.13.99999.1.7.2.688879"
* identifier.system = "https://example.org/fhir/sid/location"
* identifier.value = "CARD-CLINIC-1"
* status = #active
* name = "Cardiology Clinic 1"
* managingOrganization = Reference(ExampleHospital)

Instance: ExampleEncounter
InstanceOf: HITCCanonicalEncounter
Usage: #example
Title: "Example Ambulatory Encounter"
* extension[sourceSystem].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceSystem].valueIdentifier.value = "urn:oid:1.2.840.114350.1.13.99999.1.7.2.688879"
* identifier.system = "https://example.org/fhir/sid/encounter"
* identifier.value = "ENC-20260715-001"
* status = #finished
* class.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* class.code = #AMB
* class.display = "ambulatory"
* type.coding.system = "http://snomed.info/sct"
* type.coding.code = #185349003
* type.coding.display = "Encounter for check up"
* subject = Reference(ExamplePatient)
* period.start = "2026-07-15T09:00:00-04:00"
* period.end = "2026-07-15T09:45:00-04:00"
* serviceProvider = Reference(ExampleHospital)
* location.location = Reference(ExampleLocation)

Instance: ExampleSpecimen
InstanceOf: HITCCanonicalSpecimen
Usage: #example
Title: "Example Blood Specimen"
* extension[sourceSystem].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceSystem].valueIdentifier.value = "urn:oid:1.2.840.114350.1.13.99999.1.7.2.688879"
* identifier.system = "https://example.org/fhir/sid/specimen"
* identifier.value = "SP-20260715-88"
* status = #available
* type.coding.system = "http://snomed.info/sct"
* type.coding.code = #119297000
* type.coding.display = "Blood specimen"
* subject = Reference(ExamplePatient)
* collection.collectedDateTime = "2026-07-15T09:10:00-04:00"
* collection.collector = Reference(ExampleReviewer)

Instance: ExampleHbA1cObservation
InstanceOf: HITCLaboratoryObservation
Usage: #example
Title: "Example HbA1c Laboratory Observation"
* extension[sourceSystem].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceSystem].valueIdentifier.value = "urn:oid:1.2.840.114350.1.13.99999.1.7.2.688879"
* identifier.system = "https://example.org/fhir/sid/lab-result"
* identifier.value = "LAB-20260715-4548-4"
* status = #final
* category = $ObservationCategory#laboratory
* code.coding.system = $LOINC
* code.coding.code = #4548-4
* code.coding.display = "Hemoglobin A1c/Hemoglobin.total in Blood"
* subject = Reference(ExamplePatient)
* effectiveDateTime = "2026-07-15T09:10:00-04:00"
* performer = Reference(ExampleHospital)
* specimen = Reference(ExampleSpecimen)
* valueQuantity.value = 7.2
* valueQuantity.unit = "%"
* valueQuantity.system = $UCUM
* valueQuantity.code = #%
* referenceRange.text = "Example reference range; not for clinical use"

Instance: ExampleCondition
InstanceOf: HITCCanonicalCondition
Usage: #example
Title: "Example Type 2 Diabetes Condition"
* extension[sourceSystem].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceSystem].valueIdentifier.value = "urn:oid:1.2.840.114350.1.13.99999.1.7.2.688879"
* identifier.system = "https://example.org/fhir/sid/condition"
* identifier.value = "COND-1001"
* clinicalStatus.coding.system = "http://terminology.hl7.org/CodeSystem/condition-clinical"
* clinicalStatus.coding.code = #active
* verificationStatus.coding.system = "http://terminology.hl7.org/CodeSystem/condition-ver-status"
* verificationStatus.coding.code = #confirmed
* category.coding.system = "http://terminology.hl7.org/CodeSystem/condition-category"
* category.coding.code = #problem-list-item
* code.coding.system = $SNOMEDCT
* code.coding.code = #44054006
* code.coding.display = "Type 2 diabetes mellitus"
* subject = Reference(ExamplePatient)
* onsetDateTime = "2020-05-01"
* recordedDate = "2026-07-15T09:30:00-04:00"
* recorder = Reference(ExampleReviewer)

Instance: ExampleSourceDocument
InstanceOf: HITCCanonicalDocumentReference
Usage: #example
Title: "Example Captured Source Document"
* extension[sourceSystem].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceSystem].valueIdentifier.value = "urn:oid:1.2.840.114350.1.13.99999.1.7.2.688879"
* identifier.system = "https://example.org/fhir/sid/document"
* identifier.value = "DOC-CCDA-1001"
* status = #current
* type.coding.system = $LOINC
* type.coding.code = #34133-9
* type.coding.display = "Summary of episode note"
* category.coding.system = "http://hl7.org/fhir/us/core/CodeSystem/us-core-documentreference-category"
* category.coding.code = #clinical-note
* subject = Reference(ExamplePatient)
* date = "2026-07-15T08:59:00-04:00"
* author = Reference(ExampleReviewer)
* custodian = Reference(ExampleHospital)
* content.attachment.contentType = #application/hl7-v3+xml
* content.attachment.url = "urn:uuid:8b18f680-49d0-4d0a-a6d2-44f320887cd4"
* content.format.system = "http://ihe.net/fhir/ihe.formatcode.fhir/CodeSystem/formatcode"
* content.format.code = #urn:ihe:pcc:xphr:2007

Instance: ExampleQualityFFR
InstanceOf: HITCQualityMetricObservation
Usage: #example
Title: "FFR synthetic demonstration"
* extension[sourceSystem].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceSystem].valueIdentifier.value = "urn:oid:1.2.840.114350.1.13.99999.1.7.2.688879"
* identifier.system = "https://example.org/fhir/sid/quality-metric"
* identifier.value = "QM-FFR-20260715"
* status = #final
* category = HITCObservationCategoryCS#data-quality
* code = HITCQualityMetricCS#ffr
* subject = Reference(ExampleSourceEHR)
* focus = Reference(ExampleHospital)
* effectiveDateTime = "2026-07-15T10:00:00-04:00"
* valueQuantity.value = 98.7
* valueQuantity.unit = "%"
* valueQuantity.system = $UCUM
* valueQuantity.code = #%
* extension[validationStage].valueCode = #r-sch
* extension[numerator].valueUnsignedInt = 987
* extension[denominator].valueUnsignedInt = 1000
* note.text = "Synthetic example only; not a production performance claim."

Instance: ExampleQualityCSC
InstanceOf: HITCQualityMetricObservation
Usage: #example
Title: "CSC synthetic demonstration"
* extension[sourceSystem].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceSystem].valueIdentifier.value = "urn:oid:1.2.840.114350.1.13.99999.1.7.2.688879"
* identifier.system = "https://example.org/fhir/sid/quality-metric"
* identifier.value = "QM-CSC-20260715"
* status = #final
* category = HITCObservationCategoryCS#data-quality
* code = HITCQualityMetricCS#csc
* subject = Reference(ExampleSourceEHR)
* focus = Reference(ExampleHospital)
* effectiveDateTime = "2026-07-15T10:00:00-04:00"
* valueQuantity.value = 99.4
* valueQuantity.unit = "%"
* valueQuantity.system = $UCUM
* valueQuantity.code = #%
* extension[validationStage].valueCode = #r-term
* extension[numerator].valueUnsignedInt = 994
* extension[denominator].valueUnsignedInt = 1000
* note.text = "Synthetic example only; not a production performance claim."

Instance: ExampleQualityRIR
InstanceOf: HITCQualityMetricObservation
Usage: #example
Title: "RIR synthetic demonstration"
* extension[sourceSystem].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceSystem].valueIdentifier.value = "urn:oid:1.2.840.114350.1.13.99999.1.7.2.688879"
* identifier.system = "https://example.org/fhir/sid/quality-metric"
* identifier.value = "QM-RIR-20260715"
* status = #final
* category = HITCObservationCategoryCS#data-quality
* code = HITCQualityMetricCS#rir
* subject = Reference(ExampleSourceEHR)
* focus = Reference(ExampleHospital)
* effectiveDateTime = "2026-07-15T10:00:00-04:00"
* valueQuantity.value = 100.0
* valueQuantity.unit = "%"
* valueQuantity.system = $UCUM
* valueQuantity.code = #%
* extension[validationStage].valueCode = #r-ref
* extension[numerator].valueUnsignedInt = 1000
* extension[denominator].valueUnsignedInt = 1000
* note.text = "Synthetic example only; not a production performance claim."

Instance: ExampleQualityTC
InstanceOf: HITCQualityMetricObservation
Usage: #example
Title: "TC synthetic demonstration"
* extension[sourceSystem].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceSystem].valueIdentifier.value = "urn:oid:1.2.840.114350.1.13.99999.1.7.2.688879"
* identifier.system = "https://example.org/fhir/sid/quality-metric"
* identifier.value = "QM-TC-20260715"
* status = #final
* category = HITCObservationCategoryCS#data-quality
* code = HITCQualityMetricCS#tc
* subject = Reference(ExampleSourceEHR)
* focus = Reference(ExampleHospital)
* effectiveDateTime = "2026-07-15T10:00:00-04:00"
* valueQuantity.value = 99.2
* valueQuantity.unit = "%"
* valueQuantity.system = $UCUM
* valueQuantity.code = #%
* extension[validationStage].valueCode = #r-sch
* extension[numerator].valueUnsignedInt = 992
* extension[denominator].valueUnsignedInt = 1000
* note.text = "Synthetic example only; not a production performance claim."

Instance: ExampleQualityMSR
InstanceOf: HITCQualityMetricObservation
Usage: #example
Title: "MSR synthetic demonstration"
* extension[sourceSystem].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceSystem].valueIdentifier.value = "urn:oid:1.2.840.114350.1.13.99999.1.7.2.688879"
* identifier.system = "https://example.org/fhir/sid/quality-metric"
* identifier.value = "QM-MSR-20260715"
* status = #final
* category = HITCObservationCategoryCS#data-quality
* code = HITCQualityMetricCS#msr
* subject = Reference(ExampleSourceEHR)
* focus = Reference(ExampleHospital)
* effectiveDateTime = "2026-07-15T10:00:00-04:00"
* valueQuantity.value = 96.1
* valueQuantity.unit = "%"
* valueQuantity.system = $UCUM
* valueQuantity.code = #%
* extension[validationStage].valueCode = #qmc
* extension[numerator].valueUnsignedInt = 961
* extension[denominator].valueUnsignedInt = 1000
* note.text = "Synthetic example only; not a production performance claim."

Instance: ExampleQualityTCR
InstanceOf: HITCQualityMetricObservation
Usage: #example
Title: "TCR synthetic demonstration"
* extension[sourceSystem].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceSystem].valueIdentifier.value = "urn:oid:1.2.840.114350.1.13.99999.1.7.2.688879"
* identifier.system = "https://example.org/fhir/sid/quality-metric"
* identifier.value = "QM-TCR-20260715"
* status = #final
* category = HITCObservationCategoryCS#data-quality
* code = HITCQualityMetricCS#tcr
* subject = Reference(ExampleSourceEHR)
* focus = Reference(ExampleHospital)
* effectiveDateTime = "2026-07-15T10:00:00-04:00"
* valueQuantity.value = 97.8
* valueQuantity.unit = "%"
* valueQuantity.system = $UCUM
* valueQuantity.code = #%
* extension[validationStage].valueCode = #r-term
* extension[numerator].valueUnsignedInt = 978
* extension[denominator].valueUnsignedInt = 1000
* note.text = "Synthetic example only; not a production performance claim."

Instance: ExampleMappingProvenance
InstanceOf: HITCCanonicalProvenance
Usage: #example
Title: "Example Mapping and Validation Provenance"
* extension[sourceSystem].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceSystem].valueIdentifier.value = "urn:oid:1.2.840.114350.1.13.99999.1.7.2.688879"
* target[0] = Reference(ExamplePatient)
* target[1] = Reference(ExampleHbA1cObservation)
* target[2] = Reference(ExampleCondition)
* occurredPeriod.start = "2026-07-15T09:55:00-04:00"
* occurredPeriod.end = "2026-07-15T09:59:30-04:00"
* recorded = "2026-07-15T10:00:00-04:00"
* reason.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActReason"
* reason.coding.code = #TREAT
* reason.text = "Cross-institutional clinical data exchange"
* activity = HITCTransformationActivityCS#structural-mapping
* agent.type.coding.system = "http://terminology.hl7.org/CodeSystem/provenance-participant-type"
* agent.type.coding.code = #assembler
* agent.who = Reference(ExampleSourceEHR)
* agent.onBehalfOf = Reference(ExampleHospital)
* entity.role = #source
* entity.what = Reference(ExampleSourceDocument)
* extension[sourceFormat].valueCode = #hl7-v2
* extension[mappingStrategy].valueCode = #exact
* extension[mappingConfidence].valueDecimal = 1.0
* extension[mappingReviewer].valueReference = Reference(ExampleReviewer)
* extension[transformationStep][0].valueCodeableConcept = HITCTransformationActivityCS#structural-mapping
* extension[transformationStep][1].valueCodeableConcept = HITCTransformationActivityCS#terminology-translation
* extension[transformationStep][2].valueCodeableConcept = HITCTransformationActivityCS#unit-normalization
* extension[transformationStep][3].valueCodeableConcept = HITCTransformationActivityCS#temporal-normalization
* extension[transformationStep][4].valueCodeableConcept = HITCTransformationActivityCS#validation
* extension[transformationStep][5].valueCodeableConcept = HITCTransformationActivityCS#quality-measurement
* extension[transformationStep][6].valueCodeableConcept = HITCTransformationActivityCS#lineage-recording
* extension[validationStage][0].valueCode = #r-sch
* extension[validationStage][1].valueCode = #r-ref
* extension[validationStage][2].valueCode = #r-term
* extension[validationStage][3].valueCode = #qmc
* extension[merkleRoot].valueString = "7d0f2c4aee774f8c4d8d9c9025f9b9a2f1dcd8b67b97b695514f27dd3c7445d8"

