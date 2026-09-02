document "mitre_ctid_executive_report" {
  meta {
    name        = "MITRE CTID Executive Report Template"
    description = "A dynamic executive CTI Blueprint rendered from STIX 2.1 data."
    url         = "https://github.com/center-for-threat-informed-defense/cti-blueprints"
    license     = "Apache License 2.0"
    authors     = ["Sergey Polzunov <sergey@blackstork.io>"]
    tags        = ["mitre", "ctid", "executive", "stix2"]
    updated_at  = "2026-09-01T00:00:00Z"
  }

  input "use_llm" {
    type          = "bool"
    default_value = false
    description   = "Use the configured LLM to synthesize narrative sections."
  }
  input "primary_object_id" {
    type          = "string"
    default_value = "report--10000000-0000-4000-8000-000000000002"
    description   = "STIX identifier of the report object that defines the intelligence in scope."
  }

  vars {
    report_metadata = {
      producer_name  = "Acme Corp"
      producer_unit  = "Threat Intelligence"
      product_type   = "Executive Intelligence"
      handling       = "Internal"
      tagline        = "Decision-grade intelligence for security leaders and defenders."
      generated_with = "BlackStork"
    }
    # Replace this example with a STIX bundle supplied by an input or data source.
    stix_bundle = {
      type = "bundle"
      id   = "bundle--10000000-0000-4000-8000-000000000001"
      objects = [
        {
          type                = "identity", spec_version = "2.1"
          id                  = "identity--10000000-0000-4000-8000-000000000001"
          created             = "2026-08-28T09:00:00Z", modified = "2026-08-28T09:00:00Z"
          name                = "Example CTI Team", identity_class = "organization"
          contact_information = "cti@example.org"
        },
        {
          type         = "report", spec_version = "2.1"
          id           = "report--10000000-0000-4000-8000-000000000002"
          created      = "2026-08-28T09:00:00Z", modified = "2026-08-28T09:00:00Z"
          name         = "Ransomware Access-Broker Trend"
          description  = "Access brokers increasingly combine stolen cloud sessions with help-desk social engineering, shortening the path to ransomware deployment."
          report_types = ["threat-report"]
          published    = "2026-08-28T09:00:00Z"
          object_refs = [
            "threat-actor--10000000-0000-4000-8000-000000000003",
            "attack-pattern--10000000-0000-4000-8000-000000000004"
          ]
          external_references = [{ source_name = "Example trend assessment", url = "https://example.org/reports/access-brokers" }]
        },
        {
          type               = "threat-actor", spec_version = "2.1"
          id                 = "threat-actor--10000000-0000-4000-8000-000000000003"
          created            = "2026-08-28T09:00:00Z", modified = "2026-08-28T09:00:00Z"
          name               = "Example Access Broker Cluster"
          description        = "A cluster selling unauthorized access to ransomware affiliates."
          threat_actor_types = ["crime-syndicate"]
          motivations        = ["organizational-gain"]
        },
        {
          type                = "attack-pattern", spec_version = "2.1"
          id                  = "attack-pattern--10000000-0000-4000-8000-000000000004"
          created             = "2026-08-28T09:00:00Z", modified = "2026-08-28T09:00:00Z"
          name                = "Multi-Factor Authentication Request Generation"
          description         = "Repeated authentication requests pressure users into approving access."
          kill_chain_phases   = [{ kill_chain_name = "mitre-attack", phase_name = "credential-access" }]
          external_references = [{ source_name = "mitre-attack", external_id = "T1621", url = "https://attack.mitre.org/techniques/T1621/" }]
        }
      ]
    }

    report_context = {
      audience                 = "Executive leadership"
      historical_baseline      = "Initial access previously depended primarily on commodity phishing and exposed remote services."
      organizational_relevance = "The organization operates cloud identity and help-desk workflows targeted by this tradecraft."
      outlook                  = "Without stronger identity verification, time from access sale to ransomware deployment will likely continue to decrease."
      probability              = "very_likely"
      intelligence_gaps = [
        "Prevalence of session-token theft in incidents attributed to access brokers.",
        "Effectiveness of current help-desk identity verification controls."
      ]
      intelligence_requirements = ["IR-2: Identify cyber trends that require executive resource allocation."]
      feedback_contact          = "cti@example.org"
    }

    report = query_jq(<<-JQ
      .vars.stix_bundle.objects as $objects |
      .vars.report_context as $context |
      .inputs.primary_object_id as $primary_id |
      ($objects | map(select(.id == $primary_id and .type == "report")) | first) as $source |
      ($source.object_refs // []) as $scope_refs |
      ($objects | map(select(.type == "threat-actor" and (.id as $id | $scope_refs | index($id)))) | first) as $actor |
      def probability_label: {
        almost_no_chance: "Almost no chance", very_unlikely: "Very unlikely", unlikely: "Unlikely",
        roughly_even: "Roughly even chance", likely: "Likely", very_likely: "Very likely", almost_certain: "Almost certain"
      }[.] // "Not assessed";
      {
        title: $source.name,
        audience: $context.audience,
        subject: $source.description,
        trend: $source.description,
        historical_baseline: $context.historical_baseline,
        organizational_relevance: $context.organizational_relevance,
        outlook: $context.outlook,
        actor: $actor,
        probability: $context.probability,
        probability_label: ($context.probability | probability_label),
        intelligence_gaps: $context.intelligence_gaps,
        intelligence_requirements: $context.intelligence_requirements,
        feedback_contact: $context.feedback_contact,
        attack: [$objects[] | select(.type == "attack-pattern" and (.id as $id | $scope_refs | index($id))) | {
          attribution: ($actor.name // "Not available"),
          tactic: (([.kill_chain_phases[]? | select(.kill_chain_name == "mitre-attack").phase_name] | first) // "Unknown"),
          technique: (([.external_references[]? | select(.source_name == "mitre-attack").external_id] | first) // "N/A"),
          subtechnique: (([.external_references[]? | select(.source_name == "mitre-attack").external_id] | first) as $id | if ($id // "" | contains(".")) then .name else "N/A" end),
          procedure: .description, d3fend: "N/A", control: "Not provided"
        }],
        timeline: [], malware: [], network_indicators: [], host_indicators: [], cves: [], signatures: [],
        sources: [($source.external_references // [])[] | select(.url != null) | { name: .source_name, url: .url, description: "Source reference" }],
        metadata: (if $actor == null then [] else [{ field: "Threat Actor", value: $actor.name }] end)
      }
    JQ
    )
  }

  title = "{{ .vars.report.title }}"
  content ref { base = content.table.ctid_report_identity }
  section ref { base = section.ctid_executive_summary }
  section ref { base = section.ctid_key_points }

  section "assessment" {
    title = "Assessment"
    content text {
      is_included = query_jq(".inputs.use_llm | not")
      value       = <<-EOT
        **Trend:** {{ .vars.report.trend }}

        **Historical baseline:** {{ .vars.report.historical_baseline }}

        **Organizational relevance:** {{ .vars.report.organizational_relevance }}
      EOT
    }
    content llm_text {
      is_included = query_jq(".inputs.use_llm")
      prompt      = <<-EOT
        You are a senior cyber threat intelligence analyst. Assess the trend
        for executives. Contrast the historical baseline with
        the new information, explain organizational relevance, and identify the
        variables that could materially change the outlook. Use only:
        {{ .vars.report | toPrettyJson }}
      EOT
    }
  }

  section "outlook" {
    title = "Outlook"
    content text {
      is_included = query_jq(".inputs.use_llm | not")
      value       = "{{ .vars.report.outlook }}"
    }
    content llm_text {
      is_included = query_jq(".inputs.use_llm")
      prompt      = <<-EOT
        You are a senior cyber threat intelligence analyst. Write a short outlook
        focused on business impact and points of leverage
        within leadership's control. Use only this STIX-derived context:
        {{ .vars.report | toPrettyJson }}
      EOT
    }
  }

  section ref { base = section.ctid_key_intelligence_gaps }
  section ref { base = section.ctid_probability_matrix }
  section ref { base = section.ctid_intel_requirements }
  section ref { base = section.ctid_feedback }
  section ref { base = section.ctid_data_sources }
  format md "report" {}
  format ref { base = format.html.ctid_mitre }
}
