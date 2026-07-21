Logical: HITCV2MSH
Parent: Base
Id: HITCV2MSH
Title: "HL7 v2 MSH Logical Model"
Description: "Representative message-header fields used by the canonical envelope and provenance pipeline."
* sendingApplication 1..1 string "MSH-3 Sending Application"
* sendingFacility 1..1 string "MSH-4 Sending Facility"
* receivingApplication 0..1 string "MSH-5 Receiving Application"
* messageDateTime 1..1 dateTime "MSH-7 Date/Time of Message"
* messageType 1..1 string "MSH-9 Message Type"
* messageControlId 1..1 string "MSH-10 Message Control ID"
* versionId 1..1 string "MSH-12 Version ID"

Logical: HITCV2PID
Parent: Base
Id: HITCV2PID
Title: "HL7 v2 PID Logical Model"
Description: "Representative PID fields used by the Patient structure map."
* setId 0..1 positiveInt "PID-1 Set ID"
* patientIdentifier 1..* string "PID-3 Patient Identifier List"
* assigningAuthority 0..1 string "PID-3.4 Assigning Authority"
* identifierTypeCode 0..1 code "PID-3.5 Identifier Type Code"
* familyName 1..1 string "PID-5.1 Family Name"
* givenName 1..* string "PID-5.2 Given Name"
* birthDate 1..1 date "PID-7 Date/Time of Birth"
* administrativeSex 1..1 code "PID-8 Administrative Sex"
* addressLine 0..* string "PID-11 Street Address"
* city 0..1 string "PID-11 City"
* state 0..1 string "PID-11 State"
* postalCode 0..1 string "PID-11 ZIP/Postal Code"
* country 0..1 string "PID-11 Country"
* phone 0..* string "PID-13 Phone Number"

Logical: HITCV2PV1
Parent: Base
Id: HITCV2PV1
Title: "HL7 v2 PV1 Logical Model"
Description: "Representative PV1 fields used by the Encounter structure map."
* setId 0..1 positiveInt "PV1-1 Set ID"
* patientClass 1..1 code "PV1-2 Patient Class"
* assignedPatientLocation 0..1 string "PV1-3 Assigned Patient Location"
* attendingDoctor 0..* string "PV1-7 Attending Doctor"
* hospitalService 0..1 code "PV1-10 Hospital Service"
* visitNumber 1..1 string "PV1-19 Visit Number"
* admitDateTime 1..1 dateTime "PV1-44 Admit Date/Time"
* dischargeDateTime 0..1 dateTime "PV1-45 Discharge Date/Time"

Logical: HITCV2OBR
Parent: Base
Id: HITCV2OBR
Title: "HL7 v2 OBR Logical Model"
Description: "Representative OBR fields used by the DiagnosticReport structure map."
* setId 0..1 positiveInt "OBR-1 Set ID"
* placerOrderNumber 0..1 string "OBR-2 Placer Order Number"
* fillerOrderNumber 1..1 string "OBR-3 Filler Order Number"
* universalServiceIdentifier 1..1 Coding "OBR-4 Universal Service Identifier"
* observationDateTime 1..1 dateTime "OBR-7 Observation Date/Time"
* resultStatus 1..1 code "OBR-25 Result Status"
* diagnosticServiceSectionId 0..1 code "OBR-24 Diagnostic Service Section ID"
* principalResultInterpreter 0..* string "OBR-32 Principal Result Interpreter"

Logical: HITCV2OBX
Parent: Base
Id: HITCV2OBX
Title: "HL7 v2 OBX Logical Model"
Description: "Representative OBX fields used by the Observation structure map."
* setId 0..1 positiveInt "OBX-1 Set ID"
* valueType 1..1 code "OBX-2 Value Type"
* observationIdentifier 1..1 Coding "OBX-3 Observation Identifier"
* observationSubId 0..1 string "OBX-4 Observation Sub-ID"
* value 0..* string "OBX-5 Observation Value"
* units 0..1 Coding "OBX-6 Units"
* referenceRange 0..1 string "OBX-7 Reference Range"
* abnormalFlags 0..* code "OBX-8 Abnormal Flags"
* resultStatus 1..1 code "OBX-11 Observation Result Status"
* observationDateTime 1..1 dateTime "OBX-14 Date/Time of Observation"
* responsibleObserver 0..* string "OBX-16 Responsible Observer"
* method 0..1 Coding "OBX-17 Observation Method"

Logical: HITCV2ORC
Parent: Base
Id: HITCV2ORC
Title: "HL7 v2 ORC Logical Model"
Description: "Representative ORC fields used by the ServiceRequest structure map."
* orderControl 1..1 code "ORC-1 Order Control"
* placerOrderNumber 0..1 string "ORC-2 Placer Order Number"
* fillerOrderNumber 0..1 string "ORC-3 Filler Order Number"
* orderStatus 0..1 code "ORC-5 Order Status"
* transactionDateTime 1..1 dateTime "ORC-9 Date/Time of Transaction"
* orderingProvider 1..* string "ORC-12 Ordering Provider"

Logical: HITCV2SCH
Parent: Base
Id: HITCV2SCH
Title: "HL7 v2 SCH Logical Model"
Description: "Representative scheduling fields used by the SIU-to-Encounter structure map."
* placerAppointmentId 1..1 string "SCH-1 Placer Appointment ID"
* fillerAppointmentId 0..1 string "SCH-2 Filler Appointment ID"
* eventReason 0..1 Coding "SCH-6 Event Reason"
* appointmentReason 0..1 Coding "SCH-7 Appointment Reason"
* appointmentType 0..1 Coding "SCH-8 Appointment Type"
* appointmentDuration 0..1 decimal "SCH-9 Appointment Duration"
* startDateTime 1..1 dateTime "SCH-11 Appointment Timing Quantity"
* location 0..1 string "SCH-16 Filler Contact Person/Location"
* enteredBy 0..* string "SCH-20 Entered By Person"

Logical: HITCV2TXA
Parent: Base
Id: HITCV2TXA
Title: "HL7 v2 TXA Logical Model"
Description: "Representative TXA fields used by the MDM-to-DocumentReference structure map."
* setId 0..1 positiveInt "TXA-1 Set ID"
* documentType 1..1 Coding "TXA-2 Document Type"
* documentContentPresentation 0..1 code "TXA-3 Document Content Presentation"
* activityDateTime 1..1 dateTime "TXA-6 Origination Date/Time"
* primaryActivityProvider 0..* string "TXA-9 Originator Code/Name"
* uniqueDocumentNumber 1..1 string "TXA-12 Unique Document Number"
* documentCompletionStatus 1..1 code "TXA-17 Document Completion Status"
* documentAvailabilityStatus 0..1 code "TXA-19 Document Availability Status"
* sourceUri 1..1 uri "Location of document payload"

Logical: HITCCCDAEntry
Parent: Base
Id: HITCCCDAEntry
Title: "C-CDA Section Entry Logical Model"
Description: "Normalized intermediate representation for C-CDA medication, problem, allergy, procedure, and discharge-medication entries."
* templateId 1..* oid "C-CDA template identifier"
* entryId 1..1 string "Entry identifier"
* sectionCode 1..1 Coding "C-CDA section code"
* code 1..1 Coding "Clinical concept code"
* statusCode 0..1 code "Entry status code"
* effectiveTime 0..1 dateTime "Normalized effective time"
* value[x] 0..1 CodeableConcept or Quantity or string or dateTime "Entry value"
* subjectIdentifier 1..1 string "Patient identifier carried by the document context"
* authorIdentifier 0..1 string "Author or performer identifier"
* negationIndicator 0..1 boolean "C-CDA negation indicator"
