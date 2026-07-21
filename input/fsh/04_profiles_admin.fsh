Profile: HITCCanonicalPatient
Parent: Patient
Id: hitc-canonical-patient
Title: "HITC Canonical Patient"
Description: "Strict-at-core patient identity profile for cross-institutional exchange."
* insert HITCStrictCoreMetadata
* identifier 1..*
* identifier.system 1..1
* identifier.value 1..1
* name 1..*
* name.family 1..1
* name.given 1..*
* gender 1..1
* birthDate 1..1
* managingOrganization 1..1
* managingOrganization only Reference(HITCCanonicalOrganization)

Profile: HITCCanonicalRelatedPerson
Parent: RelatedPerson
Id: hitc-canonical-related-person
Title: "HITC Canonical Related Person"
Description: "Related-person profile linked to a canonical patient."
* insert HITCStrictCoreMetadata
* identifier 1..*
* patient only Reference(HITCCanonicalPatient)
* relationship 1..*
* name 1..*
* active 1..1

Profile: HITCCanonicalPractitioner
Parent: Practitioner
Id: hitc-canonical-practitioner
Title: "HITC Canonical Practitioner"
Description: "Practitioner profile used for attribution, review, and provenance."
* insert HITCStrictCoreMetadata
* identifier 1..*
* name 1..*
* qualification 1..*

Profile: HITCCanonicalPractitionerRole
Parent: PractitionerRole
Id: hitc-canonical-practitioner-role
Title: "HITC Canonical Practitioner Role"
Description: "Role profile binding a practitioner to an organization and function."
* insert HITCStrictCoreMetadata
* identifier 1..*
* active 1..1
* practitioner 1..1
* practitioner only Reference(HITCCanonicalPractitioner)
* organization 1..1
* organization only Reference(HITCCanonicalOrganization)
* code 1..*

Profile: HITCCanonicalOrganization
Parent: Organization
Id: hitc-canonical-organization
Title: "HITC Canonical Organization"
Description: "Organization profile for institutions participating in exchange."
* insert HITCStrictCoreMetadata
* identifier 1..*
* active 1..1
* type 1..*
* name 1..1

Profile: HITCCanonicalLocation
Parent: Location
Id: hitc-canonical-location
Title: "HITC Canonical Location"
Description: "Location profile for encounter and source-system context."
* insert HITCStrictCoreMetadata
* identifier 1..*
* status 1..1
* name 1..1
* managingOrganization 1..1
* managingOrganization only Reference(HITCCanonicalOrganization)

Profile: HITCCanonicalEncounter
Parent: Encounter
Id: hitc-canonical-encounter
Title: "HITC Canonical Encounter"
Description: "Encounter profile with mandatory identity, patient, period, and service organization."
* insert HITCStrictCoreMetadata
* identifier 1..*
* type 1..*
* subject 1..1
* subject only Reference(HITCCanonicalPatient)
* period 1..1
* serviceProvider 1..1
* serviceProvider only Reference(HITCCanonicalOrganization)
* location 1..*
* location.location only Reference(HITCCanonicalLocation)

Profile: HITCCanonicalEpisodeOfCare
Parent: EpisodeOfCare
Id: hitc-canonical-episode-of-care
Title: "HITC Canonical Episode of Care"
Description: "Episode-of-care profile for longitudinal cross-institutional grouping."
* insert HITCStrictCoreMetadata
* identifier 1..*
* type 1..*
* patient only Reference(HITCCanonicalPatient)
* managingOrganization 1..1
* managingOrganization only Reference(HITCCanonicalOrganization)
* period 1..1

