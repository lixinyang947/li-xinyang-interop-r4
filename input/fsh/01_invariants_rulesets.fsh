Invariant: hitc-obs-value-or-component
Description: "An observation must carry a value or at least one component."
Expression: "value.exists() or component.exists()"
Severity: #error

Invariant: hitc-lab-ucum
Description: "Every Quantity-valued laboratory result must use the UCUM system."
Expression: "value.ofType(Quantity).all(system = 'http://unitsofmeasure.org')"
Severity: #error

Invariant: hitc-document-content-location
Description: "Each document attachment must include embedded data or a resolvable URL."
Expression: "content.attachment.all(data.exists() or url.exists())"
Severity: #error

Invariant: hitc-bundle-patient
Description: "A canonical exchange bundle must contain at least one Patient resource."
Expression: "entry.resource.ofType(Patient).exists()"
Severity: #error

Invariant: hitc-bundle-provenance
Description: "A canonical exchange bundle must contain at least one Provenance resource."
Expression: "entry.resource.ofType(Provenance).exists()"
Severity: #error

RuleSet: HITCStrictCoreMetadata
* meta.profile 1..*
* extension contains HITCSourceSystem named sourceSystem 1..1
