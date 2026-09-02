document "mitre_ctid_intrusion_analysis_report" {
  meta {
    name        = "MITRE CTID Intrusion Analysis Report Template"
    description = "A dynamic intrusion-analysis Blueprint rendered from STIX 2.1 observations."
    url         = "https://github.com/center-for-threat-informed-defense/cti-blueprints"
    license     = "Apache License 2.0"
    authors     = ["Sergey Polzunov <sergey@blackstork.io>"]
    tags        = ["mitre", "ctid", "intrusion-analysis", "stix2"]
    updated_at  = "2026-09-01T00:00:00Z"
  }

  input "use_llm" {
    type          = "bool"
    default_value = false
    description   = "Use the configured LLM to synthesize narrative sections."
  }
  input "primary_object_id" {
    type          = "string"
    default_value = "observed-data--30000000-0000-4000-8000-000000000002"
    description   = "STIX identifier of the observed-data object anchoring the analysis."
  }

  vars {
    report_metadata = {
      producer_name  = "Acme Corp"
      producer_unit  = "Threat Intelligence"
      product_type   = "Intrusion Analysis"
      handling       = "Internal"
      tagline        = "Decision-grade intelligence for security leaders and defenders."
      generated_with = "BlackStork"
    }
    stix_bundle = {
      type = "bundle"
      id   = "bundle--30000000-0000-4000-8000-000000000001"
      objects = [
        {
          type                = "identity", spec_version = "2.1"
          id                  = "identity--30000000-0000-4000-8000-000000000001"
          created             = "2026-08-30T07:30:00Z", modified = "2026-08-30T07:30:00Z"
          name                = "Example Incident Response Team", identity_class = "organization"
          contact_information = "ir@example.org"
        },
        {
          type            = "observed-data", spec_version = "2.1"
          id              = "observed-data--30000000-0000-4000-8000-000000000002"
          created         = "2026-08-30T07:30:00Z", modified = "2026-08-30T07:30:00Z"
          first_observed  = "2026-08-29T03:14:00Z", last_observed = "2026-08-29T03:26:00Z"
          number_observed = 14
          object_refs     = ["ipv4-addr--30000000-0000-5000-8000-000000000003"]
        },
        {
          type  = "ipv4-addr", spec_version = "2.1"
          id    = "ipv4-addr--30000000-0000-5000-8000-000000000003"
          value = "192.0.2.80"
        },
        {
          type               = "threat-actor", spec_version = "2.1"
          id                 = "threat-actor--30000000-0000-4000-8000-000000000004"
          created            = "2026-08-30T07:30:00Z", modified = "2026-08-30T07:30:00Z"
          name               = "Unconfirmed SABLE JACKAL activity"
          description        = "Observed tradecraft overlaps with SABLE JACKAL, but available evidence is insufficient for firm attribution."
          threat_actor_types = ["unknown"]
        },
        {
          type                = "attack-pattern", spec_version = "2.1"
          id                  = "attack-pattern--30000000-0000-4000-8000-000000000005"
          created             = "2026-08-30T07:30:00Z", modified = "2026-08-30T07:30:00Z"
          name                = "PowerShell", description = "Encoded PowerShell launched from a spreadsheet process."
          kill_chain_phases   = [{ kill_chain_name = "mitre-attack", phase_name = "execution" }]
          external_references = [{ source_name = "mitre-attack", external_id = "T1059.001", url = "https://attack.mitre.org/techniques/T1059/001/" }]
        },
        {
          type                = "attack-pattern", spec_version = "2.1"
          id                  = "attack-pattern--30000000-0000-4000-8000-000000000006"
          created             = "2026-08-30T07:30:00Z", modified = "2026-08-30T07:30:00Z"
          name                = "OS Credential Dumping", description = "Credential access commonly follows this cluster's initial execution. Hunt for access to LSASS and registry credential stores."
          kill_chain_phases   = [{ kill_chain_name = "mitre-attack", phase_name = "credential-access" }]
          external_references = [{ source_name = "mitre-attack", external_id = "T1003", url = "https://attack.mitre.org/techniques/T1003/" }]
        },
        {
          type            = "indicator", spec_version = "2.1"
          id              = "indicator--30000000-0000-4000-8000-000000000007"
          created         = "2026-08-30T07:30:00Z", modified = "2026-08-30T07:30:00Z"
          name            = "Suspected C2 address", description = "Address contacted by the affected endpoint."
          indicator_types = ["malicious-activity"], pattern_type = "stix"
          pattern         = "[ipv4-addr:value = '192.0.2.80']", valid_from = "2026-08-29T03:14:00Z"
          kill_chain_phases = [
            { kill_chain_name = "mitre-attack", phase_name = "command-and-control" }
          ]
        },
        {
          type            = "indicator", spec_version = "2.1"
          id              = "indicator--30000000-0000-4000-8000-000000000008"
          created         = "2026-08-30T07:30:00Z", modified = "2026-08-30T07:30:00Z"
          name            = "Encoded PowerShell detection", description = "Detects the observed encoded command-line structure."
          indicator_types = ["malicious-activity"], pattern_type = "stix"
          pattern         = "[process:command_line MATCHES '(?i)powershell.*-enc']", valid_from = "2026-08-29T03:14:00Z"
          kill_chain_phases = [
            { kill_chain_name = "mitre-attack", phase_name = "execution" }
          ]
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--30000000-0000-4000-8000-000000000009"
          created           = "2026-08-30T07:30:00Z", modified = "2026-08-30T07:30:00Z"
          relationship_type = "based-on", source_ref = "indicator--30000000-0000-4000-8000-000000000007"
          target_ref        = "observed-data--30000000-0000-4000-8000-000000000002"
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--30000000-0000-4000-8000-000000000010"
          created           = "2026-08-30T07:30:00Z", modified = "2026-08-30T07:30:00Z"
          relationship_type = "based-on", source_ref = "indicator--30000000-0000-4000-8000-000000000008"
          target_ref        = "observed-data--30000000-0000-4000-8000-000000000002"
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--30000000-0000-4000-8000-000000000011"
          created           = "2026-08-30T07:30:00Z", modified = "2026-08-30T07:30:00Z"
          relationship_type = "related-to", source_ref = "observed-data--30000000-0000-4000-8000-000000000002"
          target_ref        = "attack-pattern--30000000-0000-4000-8000-000000000005"
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--30000000-0000-4000-8000-000000000012"
          created           = "2026-08-30T07:30:00Z", modified = "2026-08-30T07:30:00Z"
          relationship_type = "indicates", source_ref = "indicator--30000000-0000-4000-8000-000000000007"
          target_ref        = "threat-actor--30000000-0000-4000-8000-000000000004"
        },
        {
          type              = "relationship", spec_version = "2.1"
          id                = "relationship--30000000-0000-4000-8000-000000000013"
          created           = "2026-08-30T07:30:00Z", modified = "2026-08-30T07:30:00Z"
          relationship_type = "uses", source_ref = "threat-actor--30000000-0000-4000-8000-000000000004"
          target_ref        = "attack-pattern--30000000-0000-4000-8000-000000000006"
        }
      ]
    }

    report_context = {
      audience                  = "SOC, incident response, and threat hunting teams"
      summary                   = "Fourteen outbound connections from a finance workstation to a newly observed VPS followed a suspicious PowerShell launch."
      probability               = "likely"
      intelligence_gaps         = ["Whether credentials were accessed before containment.", "Whether the same VPS contacted other internal hosts."]
      intelligence_requirements = ["IR-4: Identify behaviors likely to precede and follow the observed command-and-control activity."]
      feedback_contact          = "ir@example.org"
      timeline                  = { location = "Internal network", sector = "Finance" }
      attack = {
        "attack-pattern--30000000-0000-4000-8000-000000000005" = { observed = true, d3fend = "D3-SCA" }
        "attack-pattern--30000000-0000-4000-8000-000000000006" = { observed = false, d3fend = "D3-OSM" }
      }
      indicators = {
        "indicator--30000000-0000-4000-8000-000000000007" = { kind = "network" }
        "indicator--30000000-0000-4000-8000-000000000008" = { kind = "signature" }
      }
    }

    report = query_jq(<<-JQ
      .vars.stix_bundle.objects as $objects |
      .vars.report_context as $context |
      .inputs.primary_object_id as $primary_id |
      ($objects | map(select(.id == $primary_id and .type == "observed-data")) | first) as $observation |
      ([$objects[] | select(.type == "relationship" and .target_ref == $primary_id and .relationship_type == "based-on") | .source_ref]) as $indicator_refs |
      ([$objects[] | select(.type == "relationship" and .source_ref == $primary_id and .relationship_type == "related-to") | .target_ref]) as $observed_attack_refs |
      ([$objects[] | select(.type == "relationship" and (.source_ref as $id | $indicator_refs | index($id)) and .relationship_type == "indicates") | .target_ref] | first) as $actor_ref |
      ($objects | map(select(.id == $actor_ref and .type == "threat-actor")) | first) as $actor |
      ([$objects[] | select(.type == "relationship" and .source_ref == $actor_ref and .relationship_type == "uses") | .target_ref]) as $actor_uses_refs |
      def probability_label: {
        almost_no_chance: "Almost no chance", very_unlikely: "Very unlikely", unlikely: "Unlikely",
        roughly_even: "Roughly even chance", likely: "Likely", very_likely: "Very likely", almost_certain: "Almost certain"
      }[.] // "Not assessed";
      def attack_row: {
        attribution: ($actor.name // "Not available"),
        tactic: (([.kill_chain_phases[]? | select(.kill_chain_name == "mitre-attack").phase_name] | first) // "Unknown"),
        technique: (([.external_references[]? | select(.source_name == "mitre-attack").external_id] | first) // "N/A"),
        subtechnique: (([.external_references[]? | select(.source_name == "mitre-attack").external_id] | first) as $id | if ($id // "" | contains(".")) then .name else "N/A" end),
        procedure: .description, d3fend: ($context.attack[.id].d3fend // "N/A"), control: "Not provided"
      };
      {
        title: "Intrusion Analysis: Suspicious PowerShell and C2 Activity",
        audience: $context.audience, subject: $context.summary,
        observation: $observation, actor: $actor, probability: $context.probability,
        probability_label: ($context.probability | probability_label),
        intelligence_gaps: $context.intelligence_gaps,
        intelligence_requirements: $context.intelligence_requirements,
        feedback_contact: $context.feedback_contact,
        attack: [$objects[] | select(.type == "attack-pattern" and (.id as $id | $actor_uses_refs | index($id))) | attack_row],
        observed_attack: [$objects[] | select(.type == "attack-pattern" and (.id as $id | $observed_attack_refs | index($id))) | attack_row],
        timeline: [{ attribution: $actor.name, start: $observation.first_observed, end: $observation.last_observed,
          location: $context.timeline.location, sector: $context.timeline.sector, activity: $context.summary }],
        malware: [],
        network_indicators: [$objects[] | select(.type == "indicator" and (.id as $id | $indicator_refs | index($id)) and ($context.indicators[.id].kind // "") == "network") | {
          attribution: $actor.name,
          value: (.id as $indicator_id |
            ($objects[] | select(.type == "relationship" and .source_ref == $indicator_id and .relationship_type == "based-on").target_ref) as $observed_id |
            ($objects[] | select(.id == $observed_id).object_refs[0]) as $observable_id |
            $objects[] | select(.id == $observable_id).value),
          description: .description,
          phase: (([.kill_chain_phases[]? | select(.kill_chain_name == "mitre-attack").phase_name] | first) // "unknown" | split("-") | map(if . == "and" then . else ((.[0:1] | ascii_upcase) + .[1:]) end) | join(" ")),
          first_seen: .valid_from, last_seen: (.valid_until // "Active")
        }],
        host_indicators: [], cves: [],
        signatures: [$objects[] | select(.type == "indicator" and (.id as $id | $indicator_refs | index($id)) and ($context.indicators[.id].kind // "") == "signature") | { name: .name, pattern: .pattern }],
        sources: [{ name: "Incident telemetry", url: "https://example.org/incidents/IR-2026-081", description: "Sanitized SOC and IR observations" }],
        metadata: (if $actor == null then [] else [{ field: "Threat Actor", value: $actor.name }, { field: "Actor Motivation", value: ($actor.primary_motivation // "Unknown") }] end)
      }
    JQ
    )
  }

  title = "{{ .vars.report.title }}"
  content ref { base = content.table.ctid_report_identity }
  section ref { base = section.ctid_executive_summary }
  section ref { base = section.ctid_key_points }

  section "indicator_analysis" {
    title = "Indicator Analysis"
    content text {
      is_included = query_jq(".inputs.use_llm | not")
      value       = <<-EOT
        {{ .vars.report.subject }} Attribution remains
        {{ .vars.report.probability_label }}; hunt first for the expected behaviors in
        the following ATT&CK table and for the listed network indicators.
      EOT
    }
    content llm_text {
      is_included = query_jq(".inputs.use_llm")
      prompt      = <<-EOT
        You are a senior cyber threat intelligence analyst. Assess what activity
        likely preceded and may follow the observation.
        Separate observed from expected behavior, explain attribution confidence,
        and give prioritized hunt recommendations. Use only:
        {{ .vars.report | toPrettyJson }}
      EOT
    }
  }

  section "ttps_likely" {
    title = "MITRE ATT&CK: TTPs Likely to Be in the Network"
    content ref { base = content.table.ctid_mitre_attack }
  }

  section "ttps_observed" {
    title = "MITRE ATT&CK: TTPs Observed in the Intrusion"
    content table {
      is_included = query_jq("(.vars.report.observed_attack // []) | length > 0")
      rows = query_jq(".vars.report.observed_attack")
      columns = [
        { header = "Tactics", value = "{{ .row.value.tactic }}" }, { header = "Techniques", value = "{{ .row.value.technique }}" },
        { header = "Sub-technique", value = "{{ .row.value.subtechnique }}" }, { header = "Procedure", value = "{{ .row.value.procedure }}" },
        { header = "D3FEND", value = "{{ .row.value.d3fend }}" }
      ]
    }
    content text {
      is_included = query_jq("(.vars.report.observed_attack // []) | length == 0")
      value       = "No ATT&CK techniques were directly observed in the intrusion data available for analysis."
    }
  }

  section "iocs_for_hunting" {
    title = "Indicators of Compromise for Hunting"
    content text {
      is_included = query_jq("((.vars.report.malware // []) + (.vars.report.network_indicators // []) + (.vars.report.host_indicators // [])) | length == 0")
      value       = "No indicators of compromise were available for hunting."
    }
    section "malware" {
      title       = "Malware"
      is_included = query_jq("(.vars.report.malware // []) | length > 0")
      content table {
        rows = query_jq(".vars.report.malware")
        columns = [
          { header = "Name", value = "{{ .row.value.name }}" },
          { header = "Description", value = "{{ .row.value.description }}" },
          { header = "First Reported", value = "{{ .row.value.first_seen }}" },
          { header = "Last Reported", value = "{{ .row.value.last_seen }}" }
        ]
      }
    }
    section "network" {
      title       = "Network"
      is_included = query_jq("(.vars.report.network_indicators // []) | length > 0")
      content table {
        rows = query_jq(".vars.report.network_indicators")
        columns = [
          { header = "Artifact", value = "{{ .row.value.value }}" },
          { header = "Details", value = "{{ .row.value.description }}" },
          { header = "Intrusion Phase", value = "{{ .row.value.phase }}" },
          { header = "First Reported", value = "{{ .row.value.first_seen }}" },
          { header = "Last Reported", value = "{{ .row.value.last_seen }}" }
        ]
      }
    }
  }
  section ref { base = section.ctid_signatures }
  content text { value = "No ATT&CK visualization was provided with this report." }
  section ref { base = section.ctid_probability_matrix }
  section ref { base = section.ctid_intel_requirements }
  section ref { base = section.ctid_feedback }
  section ref { base = section.ctid_data_sources }
  section "metadata" {
    title = "Report Metadata"
    content ref { base = content.table.ctid_metadata }
    content text {
      is_included = query_jq("(.vars.report.metadata // []) | length == 0")
      value       = "No additional report metadata was provided."
    }
  }
  format md "report" {}
  format ref { base = format.html.ctid_mitre }
}
