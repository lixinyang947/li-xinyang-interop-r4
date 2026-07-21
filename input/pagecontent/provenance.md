# Provenance and Lineage

The canonical Provenance profile records targets, source entities, responsible agents, activity, time, and reason. Registered extensions capture:

- source format;
- mapping strategy;
- mapping confidence;
- mapping reviewer;
- one or more transformation steps;
- validation stages; and
- a hex-encoded Merkle root for tamper-evident lineage anchoring.

The Merkle extension is a computable data contract. The package does not claim to implement a durable Merkle-tree store or cross-organization ledger.
