Profile: HITCCanonicalObservation
Parent: Observation
Id: hitc-canonical-observation
Title: "HITC Canonical Observation"
Description: "Canonical observation profile supporting coded, attributable, temporally normalized results."
* insert HITCStrictCoreMetadata
* obeys hitc-obs-value-or-component
* identifier 1..*
* category 1..*
* subject 1..1
* subject only Reference(HITCCanonicalPatient)
* effective[x] 1..1
* performer 1..*

Profile: HITCLaboratoryObservation
Parent: HITCCanonicalObservation
Id: hitc-laboratory-observation
Title: "HITC Laboratory Observation"
Description: "Laboratory observation constrained to laboratory category and UCUM quantity units."
* obeys hitc-lab-ucum
* category = $ObservationCategory#laboratory
* code from http://hl7.org/fhir/ValueSet/observation-codes (extensible)
* specimen only Reference(HITCCanonicalSpecimen)

Profile: HITCQualityMetricObservation
Parent: Observation
Id: hitc-quality-metric-observation
Title: "HITC Data Quality Metric Observation"
Description: "Inline quality metric emitted by the exchange validation pipeline."
* insert HITCStrictCoreMetadata
* identifier 1..*
* status = #final
* category 1..1
* category = HITCObservationCategoryCS#data-quality
* code from HITCQualityMetricVS (required)
* subject 1..1
* subject only Reference(HITCCanonicalDevice)
* focus 1..*
* focus only Reference(HITCCanonicalOrganization)
* effective[x] only dateTime
* effectiveDateTime 1..1
* value[x] only Quantity
* valueQuantity 1..1
* valueQuantity.system = $UCUM
* valueQuantity.code = #%
* valueQuantity.unit = "%"
* extension contains HITCValidationStage named validationStage 1..1 and HITCQualityNumerator named numerator 1..1 and HITCQualityDenominator named denominator 1..1

Profile: HITCCanonicalDiagnosticReport
Parent: DiagnosticReport
Id: hitc-canonical-diagnostic-report
Title: "HITC Canonical Diagnostic Report"
Description: "Diagnostic report profile linking coded reports to canonical observations."
* insert HITCStrictCoreMetadata
* identifier 1..*
* category 1..*
* subject 1..1
* subject only Reference(HITCCanonicalPatient)
* effective[x] 1..1
* issued 1..1
* performer 1..*
* result 1..*
* result only Reference(HITCCanonicalObservation)

Profile: HITCCanonicalCondition
Parent: Condition
Id: hitc-canonical-condition
Title: "HITC Canonical Condition"
Description: "Condition profile with mandatory clinical status, verification, category, code, onset, and recording date."
* insert HITCStrictCoreMetadata
* identifier 1..*
* clinicalStatus 1..1
* verificationStatus 1..1
* category 1..*
* code 1..1
* subject only Reference(HITCCanonicalPatient)
* onset[x] 1..1
* recordedDate 1..1
* recorder 1..1

Profile: HITCCanonicalProcedure
Parent: Procedure
Id: hitc-canonical-procedure
Title: "HITC Canonical Procedure"
Description: "Procedure profile for normalized procedural history."
* insert HITCStrictCoreMetadata
* identifier 1..*
* code 1..1
* subject only Reference(HITCCanonicalPatient)
* performed[x] 1..1
* performer 1..*

Profile: HITCCanonicalAllergyIntolerance
Parent: AllergyIntolerance
Id: hitc-canonical-allergy-intolerance
Title: "HITC Canonical Allergy Intolerance"
Description: "Allergy profile designed to reduce silent loss of allergy and intolerance data."
* insert HITCStrictCoreMetadata
* identifier 1..*
* clinicalStatus 1..1
* verificationStatus 1..1
* type 1..1
* category 1..*
* criticality 1..1
* code 1..1
* patient only Reference(HITCCanonicalPatient)
* recordedDate 1..1

Profile: HITCCanonicalImmunization
Parent: Immunization
Id: hitc-canonical-immunization
Title: "HITC Canonical Immunization"
Description: "Immunization profile with normalized vaccine coding and occurrence."
* insert HITCStrictCoreMetadata
* identifier 1..*
* vaccineCode 1..1
* patient only Reference(HITCCanonicalPatient)
* occurrence[x] 1..1
* primarySource 1..1

Profile: HITCCanonicalMedication
Parent: Medication
Id: hitc-canonical-medication
Title: "HITC Canonical Medication"
Description: "Medication dictionary entry for RxNorm, NDC, or locally governed coded medication concepts."
* insert HITCStrictCoreMetadata
* identifier 1..*
* code 1..1
* status 1..1
* form 1..1

Profile: HITCCanonicalMedicationRequest
Parent: MedicationRequest
Id: hitc-canonical-medication-request
Title: "HITC Canonical Medication Request"
Description: "Medication order profile with mandatory requester, date, and dosage instruction."
* insert HITCStrictCoreMetadata
* identifier 1..*
* medication[x] only CodeableConcept or Reference(HITCCanonicalMedication)
* subject only Reference(HITCCanonicalPatient)
* authoredOn 1..1
* requester 1..1
* dosageInstruction 1..*

Profile: HITCCanonicalMedicationStatement
Parent: MedicationStatement
Id: hitc-canonical-medication-statement
Title: "HITC Canonical Medication Statement"
Description: "Medication history statement profile used for C-CDA medication extraction."
* insert HITCStrictCoreMetadata
* identifier 1..*
* medication[x] only CodeableConcept or Reference(HITCCanonicalMedication)
* subject only Reference(HITCCanonicalPatient)
* effective[x] 1..1
* dateAsserted 1..1
* informationSource 1..1

Profile: HITCCanonicalMedicationAdministration
Parent: MedicationAdministration
Id: hitc-canonical-medication-administration
Title: "HITC Canonical Medication Administration"
Description: "Medication administration profile for actual administration events."
* insert HITCStrictCoreMetadata
* identifier 1..*
* medication[x] only CodeableConcept or Reference(HITCCanonicalMedication)
* subject only Reference(HITCCanonicalPatient)
* effective[x] 1..1
* performer 1..*
* request only Reference(HITCCanonicalMedicationRequest)

Profile: HITCCanonicalServiceRequest
Parent: ServiceRequest
Id: hitc-canonical-service-request
Title: "HITC Canonical Service Request"
Description: "Order and referral profile used by ORM structural mapping."
* insert HITCStrictCoreMetadata
* identifier 1..*
* category 1..*
* code 1..1
* subject only Reference(HITCCanonicalPatient)
* authoredOn 1..1
* requester 1..1

Profile: HITCCanonicalSpecimen
Parent: Specimen
Id: hitc-canonical-specimen
Title: "HITC Canonical Specimen"
Description: "Specimen profile supporting laboratory result traceability."
* insert HITCStrictCoreMetadata
* identifier 1..*
* status 1..1
* type 1..1
* subject 1..1
* subject only Reference(HITCCanonicalPatient)
* collection 1..1
* collection.collected[x] 1..1

Profile: HITCCanonicalDevice
Parent: Device
Id: hitc-canonical-device
Title: "HITC Canonical Device"
Description: "Device profile used for source systems and clinical devices."
* insert HITCStrictCoreMetadata
* identifier 1..*
* status 1..1
* type 1..1
* manufacturer 1..1
* deviceName 1..*

Profile: HITCCanonicalDeviceUseStatement
Parent: DeviceUseStatement
Id: hitc-canonical-device-use-statement
Title: "HITC Canonical Device Use Statement"
Description: "Device-use profile linked to a canonical patient and device."
* insert HITCStrictCoreMetadata
* identifier 1..*
* subject only Reference(HITCCanonicalPatient)
* device only Reference(HITCCanonicalDevice)
* timing[x] 1..1
* recordedOn 1..1

Profile: HITCCanonicalCarePlan
Parent: CarePlan
Id: hitc-canonical-care-plan
Title: "HITC Canonical Care Plan"
Description: "Care plan profile for longitudinal exchange and patient summary construction."
* insert HITCStrictCoreMetadata
* identifier 1..*
* category 1..*
* title 1..1
* subject only Reference(HITCCanonicalPatient)
* period 1..1
* careTeam 1..*
* careTeam only Reference(HITCCanonicalCareTeam)
* goal 1..*
* goal only Reference(HITCCanonicalGoal)
* activity 1..*

Profile: HITCCanonicalCareTeam
Parent: CareTeam
Id: hitc-canonical-care-team
Title: "HITC Canonical Care Team"
Description: "Care team profile with mandatory participation and period."
* insert HITCStrictCoreMetadata
* identifier 1..*
* status 1..1
* category 1..*
* subject 1..1
* subject only Reference(HITCCanonicalPatient)
* period 1..1
* participant 1..*

Profile: HITCCanonicalGoal
Parent: Goal
Id: hitc-canonical-goal
Title: "HITC Canonical Goal"
Description: "Goal profile for longitudinal care-plan exchange."
* insert HITCStrictCoreMetadata
* identifier 1..*
* achievementStatus 1..1
* category 1..*
* subject only Reference(HITCCanonicalPatient)
* start[x] 1..1
* target 1..*

Profile: HITCCanonicalDocumentReference
Parent: DocumentReference
Id: hitc-canonical-document-reference
Title: "HITC Canonical Document Reference"
Description: "Document profile used by MDM and C-CDA document exchange."
* insert HITCStrictCoreMetadata
* obeys hitc-document-content-location
* identifier 1..*
* type 1..1
* category 1..*
* subject 1..1
* subject only Reference(HITCCanonicalPatient)
* date 1..1
* author 1..*
* custodian 1..1
* custodian only Reference(HITCCanonicalOrganization)
* content 1..*
* content.attachment.contentType 1..1

Profile: HITCCanonicalComposition
Parent: Composition
Id: hitc-canonical-composition
Title: "HITC Canonical Composition"
Description: "Composition profile for structured clinical documents and patient summaries."
* insert HITCStrictCoreMetadata
* identifier 1..1
* subject 1..1
* subject only Reference(HITCCanonicalPatient)
* encounter 1..1
* encounter only Reference(HITCCanonicalEncounter)
* author 1..*
* section 1..*

Profile: HITCCanonicalQuestionnaireResponse
Parent: QuestionnaireResponse
Id: hitc-canonical-questionnaire-response
Title: "HITC Canonical Questionnaire Response"
Description: "Questionnaire response profile for structured patient-reported and clinical data."
* insert HITCStrictCoreMetadata
* identifier 1..1
* questionnaire 1..1
* subject 1..1
* subject only Reference(HITCCanonicalPatient)
* authored 1..1
* author 1..1
* item 1..*

Profile: HITCCanonicalCoverage
Parent: Coverage
Id: hitc-canonical-coverage
Title: "HITC Canonical Coverage"
Description: "Coverage profile for payer and beneficiary context."
* insert HITCStrictCoreMetadata
* identifier 1..*
* type 1..1
* beneficiary only Reference(HITCCanonicalPatient)
* period 1..1
* payor 1..*
* payor only Reference(HITCCanonicalOrganization)

