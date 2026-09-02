document "mitre_ctid_campaign_report" {
  meta {
    name        = "MITRE CTID Campaign Report Template"
    description = "A dynamic MITRE CTID Campaign Blueprint rendered from STIX 2.1 data."
    url         = "https://github.com/center-for-threat-informed-defense/cti-blueprints"
    license     = "Apache License 2.0"
    authors     = ["Sergey Polzunov <sergey@blackstork.io>"]
    tags        = ["mitre", "ctid", "campaign", "stix2"]
    updated_at  = "2026-09-03T00:00:00Z"
  }

  input "use_llm" {
    type          = "bool"
    default_value = false
    description   = "Use the configured LLM to synthesize narrative sections."
  }
  input "primary_object_id" {
    type          = "string"
    default_value = "campaign--00000000-0000-4000-8000-000000000003"
    description   = "STIX identifier of the campaign covered by the report."
  }

  vars {
    report_metadata = {
      producer_name   = "Acme Corp"
      producer_unit   = "Threat Intelligence"
      product_type    = "Finished Intelligence"
      handling        = "Internal"
      tagline         = "Decision-grade intelligence for security leaders and defenders."
      generated_with  = "BlackStork"
    }
    # Replace this example bundle with a STIX 2.1 bundle from a data source or input.
    stix_bundle = {
      type = "bundle"
      id   = "bundle--00000000-0000-4000-8000-000000000001"
      objects = [
        {
          type                = "identity"
          spec_version        = "2.1"
          id                  = "identity--00000000-0000-4000-8000-000000000001"
          created             = "2026-08-20T08:00:00Z"
          modified            = "2026-08-20T08:00:00Z"
          name                = "Example CTI Team"
          identity_class      = "organization"
          contact_information = "cti@example.org"
        },
        {
          type                = "threat-actor"
          spec_version        = "2.1"
          id                  = "threat-actor--00000000-0000-4000-8000-000000000002"
          created             = "2026-08-20T08:00:00Z"
          modified            = "2026-08-20T08:00:00Z"
          name                = "EMBER BEAR"
          description         = "A financially motivated intrusion set targeting European logistics organizations."
          aliases             = ["Example Group 42"]
          primary_motivation  = "organizational-gain"
          sophistication      = "advanced"
          external_references = [{ source_name = "Example advisory", url = "https://example.org/advisories/ember-bear" }]
        },
        {
          type               = "threat-actor", spec_version = "2.1"
          id                 = "threat-actor--00000000-0000-4000-8000-000000000090"
          created            = "2026-08-20T08:00:00Z", modified = "2026-08-20T08:00:00Z"
          name               = "OUT-OF-SCOPE ACTOR"
          description        = "Unrelated object included to demonstrate relationship-scoped selection."
          threat_actor_types = ["unknown"]
        },
        {
          type            = "marking-definition", spec_version = "2.1"
          id              = "marking-definition--00000000-0000-4000-8000-000000000099"
          created         = "2026-08-20T08:00:00Z"
          definition_type = "statement"
          definition      = { statement = "Internal" }
        },
        {
          type         = "campaign"
          spec_version = "2.1"
          id           = "campaign--00000000-0000-4000-8000-000000000003"
          created      = "2026-08-20T08:00:00Z"
          modified     = "2026-08-25T12:00:00Z"
          name         = "Night Freight"
          description  = "Credential theft and ransomware activity affecting logistics providers."
          first_seen   = "2026-07-02T00:00:00Z"
          last_seen    = "2026-08-18T00:00:00Z"
          objective    = "Obtain privileged access and disrupt logistics operations for extortion."
          created_by_ref      = "identity--00000000-0000-4000-8000-000000000001"
          object_marking_refs = ["marking-definition--00000000-0000-4000-8000-000000000099"]
          confidence          = 75
        },
        {
          type                = "attack-pattern"
          spec_version        = "2.1"
          id                  = "attack-pattern--00000000-0000-4000-8000-000000000004"
          created             = "2026-08-20T08:00:00Z"
          modified            = "2026-08-20T08:00:00Z"
          name                = "Valid Accounts"
          description         = "The actor used compromised VPN credentials for initial access."
          kill_chain_phases   = [{ kill_chain_name = "mitre-attack", phase_name = "initial-access" }]
          external_references = [{ source_name = "mitre-attack", external_id = "T1078", url = "https://attack.mitre.org/techniques/T1078/" }]
        },
        {
          type          = "malware"
          spec_version  = "2.1"
          id            = "malware--00000000-0000-4000-8000-000000000005"
          created       = "2026-08-20T08:00:00Z"
          modified      = "2026-08-20T08:00:00Z"
          name          = "FreightLock"
          is_family     = true
          malware_types = ["ransomware"]
          description   = "Encrypts Windows file shares after privilege escalation."
          first_seen    = "2026-07-02T00:00:00Z"
          last_seen     = "2026-08-18T00:00:00Z"
          sample_refs   = ["file--00000000-0000-5000-8000-000000000012"]
        },
        {
          type            = "indicator"
          spec_version    = "2.1"
          id              = "indicator--00000000-0000-4000-8000-000000000006"
          created         = "2026-08-20T08:00:00Z"
          modified        = "2026-08-20T08:00:00Z"
          name            = "Night Freight command-and-control domain"
          description     = "Domain observed in command-and-control traffic."
          indicator_types = ["malicious-activity"]
          pattern_type    = "stix"
          pattern         = "[domain-name:value = 'updates.example.net']"
          valid_from      = "2026-07-02T00:00:00Z"
          kill_chain_phases = [
            { kill_chain_name = "mitre-attack", phase_name = "command-and-control" }
          ]
        },
        {
          type                = "vulnerability"
          spec_version        = "2.1"
          id                  = "vulnerability--00000000-0000-4000-8000-000000000007"
          created             = "2026-08-20T08:00:00Z"
          modified            = "2026-08-20T08:00:00Z"
          name                = "CVE-2025-0001"
          description         = "Example VPN gateway vulnerability used after credential access."
          external_references = [{ source_name = "cve", external_id = "CVE-2025-0001", url = "https://example.org/cve/CVE-2025-0001" }]
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--00000000-0000-4000-8000-000000000008"
          created           = "2026-08-20T08:00:00Z", modified = "2026-08-20T08:00:00Z"
          relationship_type = "attributed-to"
          source_ref        = "campaign--00000000-0000-4000-8000-000000000003"
          target_ref        = "threat-actor--00000000-0000-4000-8000-000000000002"
        },
        {
          type    = "location", spec_version = "2.1"
          id      = "location--00000000-0000-4000-8000-000000000009"
          created = "2026-08-20T08:00:00Z", modified = "2026-08-20T08:00:00Z"
          name    = "Germany", country = "DE", region = "western-europe"
        },
        {
          type    = "location", spec_version = "2.1"
          id      = "location--00000000-0000-4000-8000-000000000010"
          created = "2026-08-20T08:00:00Z", modified = "2026-08-20T08:00:00Z"
          name    = "Netherlands", country = "NL", region = "western-europe"
        },
        {
          type    = "identity", spec_version = "2.1"
          id      = "identity--00000000-0000-4000-8000-000000000011"
          created = "2026-08-20T08:00:00Z", modified = "2026-08-20T08:00:00Z"
          name    = "European logistics organizations", identity_class = "class"
          sectors = ["transportation"]
        },
        {
          type   = "file", spec_version = "2.1"
          id     = "file--00000000-0000-5000-8000-000000000012"
          name   = "freightlock.exe"
          hashes = { "SHA-256" = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" }
        },
        {
          type  = "domain-name", spec_version = "2.1"
          id    = "domain-name--00000000-0000-5000-8000-000000000013"
          value = "updates.example.net"
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--00000000-0000-4000-8000-000000000014"
          created           = "2026-08-20T08:00:00Z", modified = "2026-08-20T08:00:00Z"
          relationship_type = "targets", source_ref = "campaign--00000000-0000-4000-8000-000000000003"
          target_ref        = "location--00000000-0000-4000-8000-000000000009"
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--00000000-0000-4000-8000-000000000015"
          created           = "2026-08-20T08:00:00Z", modified = "2026-08-20T08:00:00Z"
          relationship_type = "targets", source_ref = "campaign--00000000-0000-4000-8000-000000000003"
          target_ref        = "location--00000000-0000-4000-8000-000000000010"
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--00000000-0000-4000-8000-000000000016"
          created           = "2026-08-20T08:00:00Z", modified = "2026-08-20T08:00:00Z"
          relationship_type = "targets", source_ref = "campaign--00000000-0000-4000-8000-000000000003"
          target_ref        = "identity--00000000-0000-4000-8000-000000000011"
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--00000000-0000-4000-8000-000000000017"
          created           = "2026-08-20T08:00:00Z", modified = "2026-08-20T08:00:00Z"
          relationship_type = "based-on", source_ref = "indicator--00000000-0000-4000-8000-000000000006"
          target_ref        = "observed-data--00000000-0000-4000-8000-000000000018"
        },
        {
          type            = "observed-data", spec_version = "2.1"
          id              = "observed-data--00000000-0000-4000-8000-000000000018"
          created         = "2026-08-20T08:00:00Z", modified = "2026-08-20T08:00:00Z"
          first_observed  = "2026-07-02T00:00:00Z", last_observed = "2026-08-18T00:00:00Z"
          number_observed = 12
          object_refs     = ["domain-name--00000000-0000-5000-8000-000000000013"]
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--00000000-0000-4000-8000-000000000019"
          created           = "2026-08-20T08:00:00Z", modified = "2026-08-20T08:00:00Z"
          relationship_type = "uses", source_ref = "campaign--00000000-0000-4000-8000-000000000003"
          target_ref        = "attack-pattern--00000000-0000-4000-8000-000000000004"
          description       = "Night Freight used compromised valid accounts for initial access."
          confidence        = 80
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--00000000-0000-4000-8000-000000000020"
          created           = "2026-08-20T08:00:00Z", modified = "2026-08-20T08:00:00Z"
          relationship_type = "uses", source_ref = "campaign--00000000-0000-4000-8000-000000000003"
          target_ref        = "malware--00000000-0000-4000-8000-000000000005"
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--00000000-0000-4000-8000-000000000021"
          created           = "2026-08-20T08:00:00Z", modified = "2026-08-20T08:00:00Z"
          relationship_type = "exploits", source_ref = "attack-pattern--00000000-0000-4000-8000-000000000004"
          target_ref        = "vulnerability--00000000-0000-4000-8000-000000000007"
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--00000000-0000-4000-8000-000000000022"
          created           = "2026-08-20T08:00:00Z", modified = "2026-08-20T08:00:00Z"
          relationship_type = "indicates", source_ref = "indicator--00000000-0000-4000-8000-000000000006"
          target_ref        = "campaign--00000000-0000-4000-8000-000000000003"
        }
      ]
    }

    # Reporting and organizational enrichment is deliberately kept outside STIX.
    report_context = {
      audience                  = "CTI customers and security leadership"
      as_of                     = "2026-09-03T00:00:00Z"
      probability               = "likely"
      probability_label         = "Likely"
      intelligence_gaps         = ["Whether access brokers supplied the initial credentials.", "Whether the actor retains persistence in affected environments."]
      intelligence_requirements = ["IR-1: Assess ransomware risk to European logistics operations."]
      feedback_contact          = "cti@example.org"
      attack = {
        "attack-pattern--00000000-0000-4000-8000-000000000004" = { d3fend = "D3-ANCI", control = "MFA and impossible-travel alerting" }
      }
      vulnerabilities = {
        "vulnerability--00000000-0000-4000-8000-000000000007" = {
          cvss      = "8.8", patch_available = "Y", remediation = "Apply the vendor security update."
          published = "2025-01-15", patch_applied = "UNK"
        }
      }
    }

    report = query_jq(<<-JQ
      .vars.stix_bundle.objects as $objects |
      .vars.report_context as $context |
      .inputs.primary_object_id as $primary_id |
      ($objects | map(select(.id == $primary_id and .type == "campaign")) | first) as $campaign |
      ($objects | map(select(.id == $campaign.created_by_ref and .type == "identity")) | first) as $creator |
      ([$objects[] | select(.id as $id | ($campaign.object_marking_refs // []) | index($id)) |
        if .definition_type == "tlp" then ("TLP:" + (.definition.tlp | ascii_upcase)) else .definition.statement end] | join("; ")) as $handling |
      ($objects | map(select(.type == "relationship" and .source_ref == $primary_id and .relationship_type == "attributed-to")) | first | .target_ref) as $actor_ref |
      ($objects | map(select(.id == $actor_ref and .type == "threat-actor")) | first) as $actor |
      ([$objects[] | select(.type == "relationship" and .source_ref == $campaign.id and .relationship_type == "targets") | .target_ref]) as $target_refs |
      ([$objects[] | select(.type == "relationship" and .source_ref == $campaign.id and .relationship_type == "uses") | .target_ref]) as $used_refs |
      ([$objects[] | select(.type == "relationship" and .target_ref == $campaign.id and .relationship_type == "indicates") | .source_ref]) as $indicator_refs |
      ([$objects[] | select(.type == "relationship" and (.source_ref as $id | $used_refs | index($id)) and .relationship_type == "exploits") | .target_ref]) as $vulnerability_refs |
      ([$objects[] | select(.type == "location" and (.id as $id | $target_refs | index($id)))]) as $locations |
      ([$objects[] | select(.type == "identity" and (.id as $id | $target_refs | index($id)))]) as $victims |
      {
        title: $campaign.name,
        audience: $context.audience,
        subject: $campaign.description,
        actor: $actor,
        campaign: $campaign,
        probability: $context.probability,
        probability_label: ($context.probability_label // "Not assessed"),
        handling: (if $handling == "" then "Not specified" else $handling end),
        intelligence_gaps: $context.intelligence_gaps,
        intelligence_requirements: $context.intelligence_requirements,
        feedback_contact: $context.feedback_contact,
        attack: [$objects[] | select(.type == "attack-pattern" and (.revoked // false | not) and (.id as $id | $used_refs | index($id))) | . as $pattern |
          ($objects | map(select(.type == "relationship" and .source_ref == $campaign.id and .target_ref == $pattern.id and .relationship_type == "uses")) | first) as $edge | {
          attribution: $actor.name,
          tactic: (([.kill_chain_phases[]? | select(.kill_chain_name == "mitre-attack") | .phase_name] | unique) | if length == 0 then "Unknown" else join(", ") end),
          technique: (([.external_references[]? | select(.source_name == "mitre-attack") | .external_id] | unique) | if length == 0 then "N/A" else join(", ") end),
          subtechnique: (if ([.external_references[]? | select(.source_name == "mitre-attack") | .external_id | contains(".")] | any) then .name else "N/A" end), procedure: ($edge.description // .description),
          confidence: (($edge.confidence // .confidence // $campaign.confidence // 0) | tostring) + "/100",
          d3fend: ($context.attack[.id].d3fend // "N/A"), control: ($context.attack[.id].control // "Not provided")
        }],
        timeline: [{ attribution: $actor.name, start: $campaign.first_seen, end: $campaign.last_seen,
          location: ($locations | map(.name) | join(", ")), sector: ($victims | map(.sectors[]) | unique | join(", ")),
          activity: $campaign.description }],
        malware: [$objects[] | select(.type == "malware" and (.revoked // false | not) and (.id as $id | $used_refs | index($id))) | . as $malware |
          ([($malware.sample_refs // [])[] as $sample | $objects[] | select(.id == $sample) | (.hashes // {}) | to_entries[]]) as $hashes | {
          attribution: $actor.name, name: .name,
          hash_type: (if ($hashes | length) == 0 then "N/A" else ($hashes | map(.key) | unique | join(", ")) end),
          hash: (if ($hashes | length) == 0 then "N/A" else ($hashes | map(.value) | unique | join(", ")) end),
          associated_hashes: (if ($hashes | length) < 2 then "N/A" else ($hashes | map(.value) | unique | join(", ")) end), description: .description,
          report_url: "N/A", first_seen: (.first_seen // "Unknown"), last_seen: (.last_seen // "Unknown")
        }],
        network_indicators: [$objects[] | select(.type == "indicator" and (.revoked // false | not) and (.valid_until == null or .valid_until >= $context.as_of) and (.id as $id | $indicator_refs | index($id))) | {
          attribution: $actor.name,
          value: (.id as $indicator_id | [
            $objects[] | select(.type == "relationship" and .source_ref == $indicator_id and .relationship_type == "based-on") | .target_ref as $observed_id |
            $objects[] | select(.id == $observed_id) | (.object_refs // [])[] as $observable_id |
            $objects[] | select(.id == $observable_id) | (.value // .name // empty)
          ] | unique | join(", ")),
          description: .description,
          phase: (([.kill_chain_phases[]? | select(.kill_chain_name == "mitre-attack").phase_name] | first) // "unknown" | split("-") | map(if . == "and" then . else ((.[0:1] | ascii_upcase) + .[1:]) end) | join(" ")),
          first_seen: .valid_from, last_seen: (.valid_until // "Active")
        }],
        host_indicators: [],
        cves: [$objects[] | select(.type == "vulnerability" and (.revoked // false | not) and (.id as $id | $vulnerability_refs | index($id))) | {
          attribution: $actor.name, name: .name, cvss: ($context.vulnerabilities[.id].cvss // "Unknown"),
          patch_available: ($context.vulnerabilities[.id].patch_available // "UNK"), remediation: ($context.vulnerabilities[.id].remediation // "N/A"),
          published: ($context.vulnerabilities[.id].published // "Unknown"), patch_applied: ($context.vulnerabilities[.id].patch_applied // "UNK")
        }],
        signatures: [],
        sources: [$objects[] | select(.id == $campaign.id or .id == $actor.id or (.id as $id | ($used_refs + $indicator_refs + $vulnerability_refs) | index($id))) | .external_references[]? | select(.url != null) | {
          name: .source_name, url: .url, description: "External STIX reference"
        }] | unique_by(.url),
        metadata: [
          { field: "Threat Actor", value: $actor.name },
          { field: "Aliases", value: ($actor.aliases | join(", ")) },
          { field: "Victim Location", value: ($locations | map(.name) | join(", ")) },
          { field: "Sectors", value: ($victims | map(.sectors[]) | unique | join(", ")) },
          { field: "Actor Motivation", value: $actor.primary_motivation }
          ,{ field: "Intelligence Producer", value: ($creator.name // "Not available") }
          ,{ field: "Source Confidence", value: (($campaign.confidence // 0) | tostring) + "/100" }
        ]
      }
    JQ
    )
  }

  title = "{{ .vars.report.title }}"
  content ref { base = content.table.mitre_ctid_report_identity }

  section ref { base = section.mitre_ctid_executive_summary }
  section ref { base = section.mitre_ctid_key_points }
  section ref { base = section.mitre_ctid_assessment }
  section ref { base = section.mitre_ctid_key_intelligence_gaps }
  section ref { base = section.mitre_ctid_attack }
  section ref { base = section.mitre_ctid_timeline_of_activity }
  section ref { base = section.mitre_ctid_iocs }
  section ref { base = section.mitre_ctid_cves }
  section ref { base = section.mitre_ctid_signatures }

  content text {
    value = "No ATT&CK visualization was provided with this report."
  }

  section ref { base = section.mitre_ctid_probability_matrix }
  section ref { base = section.mitre_ctid_intel_requirements }
  section ref { base = section.mitre_ctid_feedback }
  section ref { base = section.mitre_ctid_data_sources }

  section "metadata" {
    title = "Report Metadata"
    content ref { base = content.table.mitre_ctid_metadata }
    content text {
      is_included = query_jq("(.vars.report.metadata // []) | length == 0")
      value       = "No additional report metadata was provided."
    }
  }

  format md "report" {}
  format ref { base = format.html.mitre_ctid }
}
