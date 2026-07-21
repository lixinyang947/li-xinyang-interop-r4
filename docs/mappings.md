# FHIR Mapping Framework

## Overview

This page describes the two-phase mapping methodology implemented through HL7 FHIR mapping artifacts.

The framework separates structural transformation from semantic reconciliation.

---

# Phase 1: Structural Mapping

## FHIR StructureMap

StructureMap artifacts define deterministic transformations between source formats and FHIR R4 resources.

Examples:

---

# Phase 2: Semantic Reconciliation

## FHIR ConceptMap

ConceptMap artifacts define terminology translation and semantic normalization.

Examples:

- Local clinical codes → Standard terminology
- HL7 v2 tables → FHIR coding systems
- Institution-specific values → Canonical concepts

---

# Mapping Governance

Each mapping records:

- Mapping strategy
- Confidence level
- Validation status
- Provenance information

---

# Supported Source Formats

## HL7 v2

Supported message families:

- ADT
- ORU
- ORM
- SIU
- MDM


## C-CDA

Supported extraction targets:

- Problems
- Allergies
- Medications
- Procedures
- Clinical documents

---

# Output

The mapping pipeline produces validated FHIR R4 Bundles with:

- Resource profiles
- Terminology conformance
- Provenance records
- Quality metrics
