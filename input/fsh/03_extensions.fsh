Extension: HITCSourceSystem
Id: hitc-source-system
Title: "HITC Source System"
Description: "Identifies the originating institution or source application for an exchanged resource."
Context: Resource
* value[x] only Identifier
* valueIdentifier.system 1..1
* valueIdentifier.value 1..1

Extension: HITCSourceFormat
Id: hitc-source-format
Title: "HITC Source Format"
Description: "Identifies the source payload format before structural mapping."
Context: Resource
* value[x] only code
* valueCode from HITCSourceFormatVS (required)

Extension: HITCOriginalCode
Id: hitc-original-code
Title: "HITC Original Source Code"
Description: "Preserves the source code before terminology translation."
Context: Coding
* value[x] only Coding

Extension: HITCMappingStrategy
Id: hitc-mapping-strategy
Title: "HITC Mapping Strategy"
Description: "Records the strategy used to resolve a source concept."
Context: Resource
* value[x] only code
* valueCode from HITCMappingStrategyVS (required)

Extension: HITCMappingConfidence
Id: hitc-mapping-confidence
Title: "HITC Mapping Confidence"
Description: "Decimal confidence score from zero through one for a terminology mapping."
Context: Resource
* value[x] only decimal

Extension: HITCMappingReviewer
Id: hitc-mapping-reviewer
Title: "HITC Mapping Reviewer"
Description: "Identifies the person or role that reviewed a terminology mapping."
Context: Resource
* value[x] only Reference(Practitioner or PractitionerRole)

Extension: HITCTransformationStep
Id: hitc-transformation-step
Title: "HITC Transformation Step"
Description: "Records a transformation or normalization step applied to the target resource."
Context: Resource
* value[x] only CodeableConcept
* valueCodeableConcept from HITCTransformationActivityVS (required)

Extension: HITCValidationStage
Id: hitc-validation-stage
Title: "HITC Validation Stage"
Description: "Identifies a validation stage executed against the resource."
Context: Resource
* value[x] only code
* valueCode from HITCValidationStageVS (required)

Extension: HITCMerkleRoot
Id: hitc-merkle-root
Title: "HITC Merkle Root"
Description: "Hex-encoded Merkle root or transaction hash used for tamper-evident lineage."
Context: Provenance
* value[x] only string

Extension: HITCQualityNumerator
Id: hitc-quality-numerator
Title: "HITC Quality Metric Numerator"
Description: "Numerator used to calculate a quality metric."
Context: Observation
* value[x] only unsignedInt

Extension: HITCQualityDenominator
Id: hitc-quality-denominator
Title: "HITC Quality Metric Denominator"
Description: "Denominator used to calculate a quality metric."
Context: Observation
* value[x] only unsignedInt
