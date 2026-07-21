# Methodology Traceability

The source methodology is formalized through six connected components.

| Method component | Computable representation |
|---|---|
| Canonical FHIR R4 model | 35 resource Profiles, 11 extensions, one exchange Bundle profile |
| Two-phase mapping | 12 StructureMaps/FML files plus 11 ConceptMaps |
| Terminology bridge | CodeSystems/ValueSets, ConceptMap equivalence, mapping strategy/confidence/reviewer metadata |
| Validation pipeline | Profile constraints, invariants, validation-stage codes, `$validate-exchange` contract |
| Provenance and lineage | Provenance profile, transformation-step extensions, Merkle-root extension, search parameter |
| Federated query workflow | CapabilityStatement and `$federated-summary` OperationDefinition |

See the repository-level `TRACEABILITY_MATRIX.md` for claim-to-file mapping and explicit limitations.
