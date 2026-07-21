# Validation and Inline Data Quality

## Validation stages

- **R-SCH:** R4 JSON and profile conformance.
- **R-REF:** reference integrity.
- **R-TERM:** terminology and value-set conformance.
- **QMC:** quality-metrics collection.

## Quality metrics

The quality metric Observation profile supports:

- FFR — field fill rate
- CSC — code-system conformance
- RIR — reference integrity rate
- TC — temporal consistency
- MSR — mapping success rate
- TCR — terminology coverage rate

Metric Observations carry numerator, denominator, validation stage, source-system identity, effective time, and a percentage Quantity. The included values are synthetic demonstrations, not measured production outcomes.

## Package checks

The build generates StructureDefinition snapshots with SUSHI, verifies artifact counts and canonical resolution, checks StructureMap dependencies and bundle references, and performs a separate offline R4 validation pass over all non-StructureDefinition JSON resources.
