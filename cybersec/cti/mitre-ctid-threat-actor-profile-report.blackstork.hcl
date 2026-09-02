document "mitre_ctid_threat_actor_profile_report" {
  meta {
    name        = "MITRE CTID Threat Actor Profile Report Template"
    description = "A dynamic threat-actor profile Blueprint rendered from STIX 2.1 data."
    url         = "https://github.com/center-for-threat-informed-defense/cti-blueprints"
    license     = "Apache License 2.0"
    tags        = ["mitre", "ctid", "threat-actor", "stix2"]
    updated_at  = "2026-09-01T00:00:00Z"
  }

  input "use_llm" {
    type          = "bool"
    default_value = false
    description   = "Use the configured LLM to synthesize narrative sections."
  }

  vars {
    stix_bundle = {
      type = "bundle"
      id   = "bundle--20000000-0000-4000-8000-000000000001"
      objects = [
        {
          type                = "identity", spec_version = "2.1"
          id                  = "identity--20000000-0000-4000-8000-000000000001"
          created             = "2026-08-24T10:00:00Z", modified = "2026-08-24T10:00:00Z"
          name                = "Example CTI Team", identity_class = "organization"
          contact_information = "cti@example.org"
        },
        {
          type                = "threat-actor", spec_version = "2.1"
          id                  = "threat-actor--20000000-0000-4000-8000-000000000002"
          created             = "2026-08-24T10:00:00Z", modified = "2026-08-24T10:00:00Z"
          name                = "SABLE JACKAL"
          description         = "An advanced espionage group targeting energy and engineering organizations."
          aliases             = ["Example Group 17"]
          threat_actor_types  = ["nation-state"]
          roles               = ["agent"]
          goals               = ["Collect industrial research and strategic energy information."]
          sophistication      = "advanced"
          resource_level      = "government"
          primary_motivation  = "organizational-gain"
          first_seen          = "2021-03-01T00:00:00Z"
          last_seen           = "2026-08-10T00:00:00Z"
          external_references = [{ source_name = "Example actor profile", url = "https://example.org/actors/sable-jackal" }]
        },
        {
          type                = "attack-pattern", spec_version = "2.1"
          id                  = "attack-pattern--20000000-0000-4000-8000-000000000003"
          created             = "2026-08-24T10:00:00Z", modified = "2026-08-24T10:00:00Z"
          name                = "Exploit Public-Facing Application"
          description         = "The actor exploits internet-facing edge devices for initial access."
          kill_chain_phases   = [{ kill_chain_name = "mitre-attack", phase_name = "initial-access" }]
          external_references = [{ source_name = "mitre-attack", external_id = "T1190", url = "https://attack.mitre.org/techniques/T1190/" }]
        },
        {
          type                 = "infrastructure", spec_version = "2.1"
          id                   = "infrastructure--20000000-0000-4000-8000-000000000004"
          created              = "2026-08-24T10:00:00Z", modified = "2026-08-24T10:00:00Z"
          name                 = "SABLE JACKAL relay tier"
          description          = "Rented VPS nodes used as redirectors."
          infrastructure_types = ["command-and-control"]
          first_seen           = "2026-04-12T00:00:00Z", last_seen = "2026-08-10T00:00:00Z"
        },
        {
          type           = "identity", spec_version = "2.1"
          id             = "identity--20000000-0000-4000-8000-000000000005"
          created        = "2026-08-24T10:00:00Z", modified = "2026-08-24T10:00:00Z"
          name           = "Example Northern Grid Operator"
          identity_class = "organization"
          sectors        = ["energy"]
        },
        {
          type            = "indicator", spec_version = "2.1"
          id              = "indicator--20000000-0000-4000-8000-000000000006"
          created         = "2026-08-24T10:00:00Z", modified = "2026-08-24T10:00:00Z"
          name            = "Relay address", description = "VPS address used as a redirector."
          indicator_types = ["malicious-activity"], pattern_type = "stix"
          pattern         = "[ipv4-addr:value = '192.0.2.44']", valid_from = "2026-04-12T00:00:00Z"
          kill_chain_phases = [
            { kill_chain_name = "mitre-attack", phase_name = "command-and-control" }
          ]
        },
        {
          type  = "ipv4-addr", spec_version = "2.1"
          id    = "ipv4-addr--20000000-0000-5000-8000-000000000007"
          value = "192.0.2.44"
        },
        {
          type    = "location", spec_version = "2.1"
          id      = "location--20000000-0000-4000-8000-000000000008"
          created = "2026-08-24T10:00:00Z", modified = "2026-08-24T10:00:00Z"
          name    = "Northern Europe", region = "northern-europe"
        },
        {
          type    = "location", spec_version = "2.1"
          id      = "location--20000000-0000-4000-8000-000000000009"
          created = "2026-08-24T10:00:00Z", modified = "2026-08-24T10:00:00Z"
          name    = "Central Asia", region = "central-asia"
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--20000000-0000-4000-8000-000000000010"
          created           = "2026-08-24T10:00:00Z", modified = "2026-08-24T10:00:00Z"
          relationship_type = "uses", source_ref = "threat-actor--20000000-0000-4000-8000-000000000002"
          target_ref        = "infrastructure--20000000-0000-4000-8000-000000000004"
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--20000000-0000-4000-8000-000000000011"
          created           = "2026-08-24T10:00:00Z", modified = "2026-08-24T10:00:00Z"
          relationship_type = "targets", source_ref = "threat-actor--20000000-0000-4000-8000-000000000002"
          target_ref        = "identity--20000000-0000-4000-8000-000000000005"
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--20000000-0000-4000-8000-000000000012"
          created           = "2026-08-24T10:00:00Z", modified = "2026-08-24T10:00:00Z"
          relationship_type = "targets", source_ref = "threat-actor--20000000-0000-4000-8000-000000000002"
          target_ref        = "location--20000000-0000-4000-8000-000000000008"
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--20000000-0000-4000-8000-000000000013"
          created           = "2026-08-24T10:00:00Z", modified = "2026-08-24T10:00:00Z"
          relationship_type = "targets", source_ref = "threat-actor--20000000-0000-4000-8000-000000000002"
          target_ref        = "location--20000000-0000-4000-8000-000000000009"
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--20000000-0000-4000-8000-000000000014"
          created           = "2026-08-24T10:00:00Z", modified = "2026-08-24T10:00:00Z"
          relationship_type = "based-on", source_ref = "indicator--20000000-0000-4000-8000-000000000006"
          target_ref        = "observed-data--20000000-0000-4000-8000-000000000015"
        },
        {
          type            = "observed-data", spec_version = "2.1"
          id              = "observed-data--20000000-0000-4000-8000-000000000015"
          created         = "2026-08-24T10:00:00Z", modified = "2026-08-24T10:00:00Z"
          first_observed  = "2026-04-12T00:00:00Z", last_observed = "2026-08-10T00:00:00Z"
          number_observed = 7
          object_refs     = ["ipv4-addr--20000000-0000-5000-8000-000000000007"]
        }
      ]
    }

    report_context = {
      audience                  = "SOC, threat hunt, and red/purple teams"
      probability               = "likely"
      attribution_assessment    = "Multiple independent sources associate the cluster with a state-aligned collection requirement; attribution remains assessed, not confirmed."
      intelligence_gaps         = ["The actor's current initial-access provider.", "Whether 2026 infrastructure represents a distinct subgroup."]
      intelligence_requirements = ["IR-3: Track actors targeting energy-sector intellectual property."]
      feedback_contact          = "cti@example.org"
      attack                    = { "attack-pattern--20000000-0000-4000-8000-000000000003" = { control = "Rapid edge-device patching and exploit telemetry" } }
      victims                   = { "identity--20000000-0000-4000-8000-000000000005" = { date_reported = "2026-07-18" } }
    }

    report = query_jq(<<-JQ
      .vars.stix_bundle.objects as $objects |
      .vars.report_context as $context |
      ($objects | map(select(.type == "threat-actor")) | first) as $actor |
      ([$objects[] | select(.type == "relationship" and .source_ref == $actor.id and .relationship_type == "targets") | .target_ref]) as $target_refs |
      ([$objects[] | select(.type == "location" and (.id as $id | $target_refs | index($id)))]) as $locations |
      ([$objects[] | select(.type == "identity" and (.id as $id | $target_refs | index($id)))]) as $victims |
      ([$objects[] | select(.type == "relationship" and .source_ref == $actor.id and .relationship_type == "uses") | .target_ref]) as $infrastructure_refs |
      ([$objects[] | select(.type == "infrastructure" and (.id as $id | $infrastructure_refs | index($id)))]) as $infrastructure |
      {
        title: ($actor.name + " Threat Actor Profile"), audience: $context.audience,
        subject: $actor.description, actor: $actor, probability: $context.probability,
        attribution_assessment: $context.attribution_assessment,
        locations: ($locations | map(.name)),
        sectors: ($victims | map(.sectors[]) | unique),
        infrastructure: ($infrastructure | map(.description)),
        intelligence_gaps: $context.intelligence_gaps,
        intelligence_requirements: $context.intelligence_requirements,
        feedback_contact: $context.feedback_contact,
        attack: [$objects[] | select(.type == "attack-pattern") | {
          attribution: $actor.name, tactic: .kill_chain_phases[0].phase_name,
          technique: .external_references[0].external_id, subtechnique: "N/A", procedure: .description,
          d3fend: "N/A", control: ($context.attack[.id].control // "Not provided")
        }],
        timeline: [{ attribution: $actor.name, start: $actor.first_seen, end: $actor.last_seen,
          location: ($locations | map(.name) | join(", ")),
          sector: ($victims | map(.sectors[]) | unique | join(", ")), activity: $actor.description }],
        victims: [$victims[] | {
          name: .name, date: ($context.victims[.id].date_reported // "Unknown"), sector: (.sectors | join(", ")),
          locality: "N/A", country: ($locations | map(.name) | join(", "))
        }],
        malware: [],
        network_indicators: [$objects[] | select(.type == "indicator") | {
          attribution: $actor.name,
          value: (.id as $indicator_id |
            ($objects[] | select(.type == "relationship" and .source_ref == $indicator_id and .relationship_type == "based-on").target_ref) as $observed_id |
            ($objects[] | select(.id == $observed_id).object_refs[0]) as $observable_id |
            $objects[] | select(.id == $observable_id).value),
          description: .description,
          phase: (([.kill_chain_phases[]? | select(.kill_chain_name == "mitre-attack").phase_name] | first) // "unknown" | split("-") | map(if . == "and" then . else ((.[0:1] | ascii_upcase) + .[1:]) end) | join(" ")),
          first_seen: .valid_from, last_seen: (.valid_until // "Active")
        }],
        host_indicators: [], cves: [], signatures: [],
        sources: [$actor.external_references[] | { name: .source_name, url: .url, description: "External STIX reference" }],
        metadata: [
          { field: "Threat Actor", value: $actor.name }, { field: "Aliases", value: ($actor.aliases | join(", ")) },
          { field: "Victim Location", value: ($locations | map(.name) | join(", ")) },
          { field: "Sectors", value: ($victims | map(.sectors[]) | unique | join(", ")) },
          { field: "Infrastructure Used", value: ($infrastructure | map(.description) | join("; ")) },
          { field: "Actor Motivation", value: $actor.primary_motivation }
        ]
      }
    JQ
    )
  }

  title = "{{ .vars.report.title }}"
  section ref { base = section.ctid_executive_summary }
  section ref { base = section.ctid_key_points }
  section ref { base = section.ctid_assessment }

  section "threat_actor_summary" {
    title = "Threat Actor Summary"
    content text { value = "{{ .vars.report.actor.description }}" }

    section "ttps" {
      title = "Tactics, Techniques, and Procedures"
      content text {
        is_included = query_jq(".inputs.use_llm | not")
        value       = "The actor's documented behavior is summarized in the MITRE ATT&CK table below."
      }
      content llm_text {
        is_included = query_jq(".inputs.use_llm")
        config      = config.content.llm_text.ctid_analyst
        prompt      = "Describe how the actor operates using only these STIX-derived ATT&CK rows: {{ .vars.report.attack | toPrettyJson }}"
      }
    }
    section "infrastructure" {
      title = "Infrastructure"
      content list {
        items         = query_jq(".vars.report.infrastructure // []")
        format        = "unordered"
        item_template = "{{ . }}"
      }
    }
    section "victimology" {
      title = "Victims"
      content text { value = "Known targeting includes {{ .vars.report.sectors | join \", \" }} in {{ .vars.report.locations | join \", \" }}." }
    }
    section "attribution" {
      title = "Attribution"
      content text { value = "{{ .vars.report.attribution_assessment }}" }
    }
  }

  section ref { base = section.ctid_timeline_of_activity }
  section ref { base = section.ctid_key_intelligence_gaps }
  section ref { base = section.ctid_mitre_attack }

  section "victims" {
    title = "Victims"
    content table {
      rows = query_jq(".vars.report.victims")
      columns = [
        { header = "Name", value = "{{ .row.value.name }}" }, { header = "Date Reported", value = "{{ .row.value.date }}" },
        { header = "Sector", value = "{{ .row.value.sector }}" }, { header = "City/State/Province", value = "{{ .row.value.locality }}" },
        { header = "Country/Region", value = "{{ .row.value.country }}" }
      ]
    }
  }

  section ref { base = section.ctid_iocs }
  section ref { base = section.ctid_cves }
  section ref { base = section.ctid_signatures }
  section ref { base = section.ctid_probability_matrix }
  section ref { base = section.ctid_intel_requirements }
  section ref { base = section.ctid_feedback }
  section ref { base = section.ctid_data_sources }
  section "metadata" {
    title = "Report Metadata"
    content ref { base = content.table.ctid_metadata }
  }
  format md "report" {}
}
