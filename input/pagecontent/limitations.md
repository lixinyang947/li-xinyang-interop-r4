# Limitations and Publication Readiness

This is a draft, experimental technical specification.

Before operational publication, an adopter must replace the placeholder canonical, define namespace governance, approve local extensions, populate licensed/local ConceptMaps, connect a terminology server, specify source-field dictionaries, harden security and consent controls, and complete clinical-safety and performance validation.

C-CDA maps begin from a normalized entry logical model; they do not replace XML parsing and XPath/template extraction. HL7 v2 maps begin from normalized segment logical models; they do not parse ER7 messages or local Z-segments.

The TF-IDF resolver, `$validate-code` calls, query planner, materialized views, adaptive cache, and Merkle store are represented as methods and conformance contracts, not as completed runtime services.
