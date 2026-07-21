CodeSystem: HITCQualityMetricCS
Id: hitc-quality-metric
Title: "HITC Data Quality Metric Codes"
Description: "Codes for inline data-quality metrics emitted as FHIR Observation resources."
* ^caseSensitive = true
* ^content = #complete
* #ffr "FFR" "Field fill rate: proportion of required or expected fields populated."
* #csc "CSC" "Code system conformance: proportion of coded elements using approved code systems."
* #rir "RIR" "Reference integrity rate: proportion of references that resolve successfully."
* #tc "TC" "Temporal consistency: proportion of temporal relationships passing consistency rules."
* #msr "MSR" "Mapping success rate: proportion of source elements successfully mapped."
* #tcr "TCR" "Terminology coverage rate: proportion of coded concepts resolved by the terminology bridge."

ValueSet: HITCQualityMetricVS
Id: hitc-quality-metric
Title: "HITC Data Quality Metric Value Set"
Description: "The six quality metrics defined by the interoperability methodology."
* include codes from system HITCQualityMetricCS

CodeSystem: HITCMappingStrategyCS
Id: hitc-mapping-strategy
Title: "HITC Mapping Strategy Codes"
Description: "Resolution strategies used by the terminology bridge."
* ^caseSensitive = true
* ^content = #complete
* #exact "Exact lookup" "Direct crosswalk or exact-code lookup."
* #fuzzy-tfidf "TF-IDF fuzzy match" "Description-based TF-IDF candidate resolution."
* #validate-code "FHIR validate-code" "Value-set membership checked using the FHIR validate-code operation."
* #human-reviewed "Human reviewed" "Mapping accepted or revised by an authorized reviewer."
* #unmapped "Unmapped" "No acceptable target concept was resolved."

ValueSet: HITCMappingStrategyVS
Id: hitc-mapping-strategy
Title: "HITC Mapping Strategy Value Set"
* include codes from system HITCMappingStrategyCS

CodeSystem: HITCValidationStageCS
Id: hitc-validation-stage
Title: "HITC Validation Stage Codes"
Description: "Composable validation stages specified by the methodology."
* ^caseSensitive = true
* ^content = #complete
* #r-sch "R-SCH" "FHIR schema and profile conformance."
* #r-ref "R-REF" "Reference integrity validation."
* #r-term "R-TERM" "Terminology conformance validation."
* #qmc "Quality Metrics Collector" "Collection and emission of data-quality metrics."

ValueSet: HITCValidationStageVS
Id: hitc-validation-stage
Title: "HITC Validation Stage Value Set"
* include codes from system HITCValidationStageCS

CodeSystem: HITCSourceFormatCS
Id: hitc-source-format
Title: "HITC Source Format Codes"
Description: "Input formats supported by the mapping methodology."
* ^caseSensitive = true
* ^content = #complete
* #fhir-r4 "FHIR R4" "FHIR Release 4 resource or Bundle."
* #hl7-v2 "HL7 v2" "HL7 version 2.x message."
* #c-cda-r2.1 "C-CDA R2.1" "Consolidated CDA Release 2.1 document."
* #custom "Custom export" "Institution-specific structured export."

ValueSet: HITCSourceFormatVS
Id: hitc-source-format
Title: "HITC Source Format Value Set"
* include codes from system HITCSourceFormatCS

CodeSystem: HITCTransformationActivityCS
Id: hitc-transformation-activity
Title: "HITC Transformation Activity Codes"
Description: "Activities recorded in resource-level provenance."
* ^caseSensitive = true
* ^content = #complete
* #structural-mapping "Structural mapping" "Phase 1 structure-to-resource transformation."
* #terminology-translation "Terminology translation" "Code-system reconciliation through the terminology bridge."
* #unit-normalization "Unit normalization" "Normalization to UCUM."
* #temporal-normalization "Temporal normalization" "Normalization to ISO 8601-compatible FHIR date/time values."
* #validation "Validation" "Execution of one or more validation stages."
* #quality-measurement "Quality measurement" "Collection of inline data-quality metrics."
* #lineage-recording "Lineage recording" "Creation or update of append-only provenance lineage."

ValueSet: HITCTransformationActivityVS
Id: hitc-transformation-activity
Title: "HITC Transformation Activity Value Set"
* include codes from system HITCTransformationActivityCS

CodeSystem: HITCObservationCategoryCS
Id: hitc-observation-category
Title: "HITC Observation Category Codes"
Description: "Additional observation categories required by the inline data-quality pipeline."
* ^caseSensitive = true
* ^content = #complete
* #data-quality "Data quality" "Observation reports a data-quality metric for an exchange source or transaction."

ValueSet: HITCObservationCategoryVS
Id: hitc-observation-category
Title: "HITC Observation Category Value Set"
* include codes from system HITCObservationCategoryCS

CodeSystem: HITCSupportedTerminologyCS
Id: hitc-supported-terminology
Title: "HITC Supported Terminology System Codes"
Description: "The twelve terminology systems identified by the methodology."
* ^caseSensitive = true
* ^content = #complete
* #icd-10-cm "ICD-10-CM"
* #icd-9-cm "ICD-9-CM"
* #snomed-ct "SNOMED CT"
* #loinc "LOINC"
* #rxnorm "RxNorm"
* #ndc "NDC"
* #cpt "CPT"
* #hcpcs "HCPCS"
* #cvx "CVX"
* #ucum "UCUM"
* #hl7-v2-0078 "HL7 v2 Table 0078"
* #administrative-gender "HL7 Administrative Gender"

ValueSet: HITCSupportedTerminologyVS
Id: hitc-supported-terminology
Title: "HITC Supported Terminology Value Set"
* include codes from system HITCSupportedTerminologyCS
