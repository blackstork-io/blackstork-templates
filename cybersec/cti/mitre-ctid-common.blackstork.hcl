# Shared presentation blocks for MITRE CTID Blueprint reports. Each document
# normalizes its STIX 2.1 bundle into `.vars.report` before using these blocks.

config content llm_text "ctid_analyst" {
  vendor        = "openai"
  model         = "openai/gpt-5-mini"
  api_key       = env.BLACKSTORK_LLM_API_KEY
  system_prompt = <<-EOT
    You are a senior cyber threat intelligence analyst. Write concise,
    decision-oriented analysis grounded only in the supplied STIX 2.1 data.
    Distinguish observed facts from judgments, preserve stated confidence, and
    never invent indicators, attribution, victims, or TTPs.
  EOT
}

section "ctid_executive_summary" {
  title = "Executive Summary"
  content text {
    is_included = query_jq(".inputs.use_llm | not")
    value       = <<-EOT
      **Bottom line:** {{ .vars.report.subject }}

      This assessment is written for {{ .vars.report.audience }}. The principal
      judgment is assessed as **{{ .vars.report.probability }}** based on the
      STIX objects and external references supplied with this report.
    EOT
  }
  content llm_text {
    is_included = query_jq(".inputs.use_llm")
    config      = config.content.llm_text.ctid_analyst
    prompt      = <<-EOT
      Write a two-paragraph executive summary. Lead with the largest takeaway,
      explain what changed, and state why it matters to the intended audience.
      Report context: {{ .vars.report | toPrettyJson }}
    EOT
  }
}

section "ctid_key_points" {
  title = "Key Points"
  content list {
    items = [
      { label = "Subject", value = query_jq(".vars.report.subject") },
      { label = "Attribution", value = query_jq(".vars.report.actor.name") },
      { label = "Assessed probability", value = query_jq(".vars.report.probability") },
      { label = "Intended audience", value = query_jq(".vars.report.audience") }
    ]
    format        = "unordered"
    item_template = "{{ .label }}: {{ .value }}"
  }
}

section "ctid_assessment" {
  title = "Assessment"
  content text {
    is_included = query_jq(".inputs.use_llm | not")
    value       = <<-EOT
      **Key Judgment:** {{ .vars.report.subject }}

      **Confidence:** {{ .vars.report.probability }}.

      **Intelligence limitations:** {{ len .vars.report.intelligence_gaps }} key
      gaps remain and are listed below.
    EOT
  }
  content llm_text {
    is_included = query_jq(".inputs.use_llm")
    config      = config.content.llm_text.ctid_analyst
    prompt      = <<-EOT
      Write three labeled paragraphs: Key Judgment, Change Analysis, and
      Relevance to the Organization. Calibrate language to the supplied
      probability and explicitly identify missing evidence.
      {{ .vars.report | toPrettyJson }}
    EOT
  }
}

section "ctid_key_intelligence_gaps" {
  title = "Key Intelligence Gaps"
  content list {
    items         = query_jq(".vars.report.intelligence_gaps // []")
    format        = "unordered"
    item_template = "{{ . }}"
  }
}

section "ctid_probability_matrix" {
  title = "Probability Matrix"
  content text {
    value = "The marker identifies the probability of the principal analytic judgment."
  }
  content table {
    rows = query_jq("[.vars.report.probability // \"unknown\"]")
    columns = [
      { header = "Almost no chance (01–05%)", value = "{{ if eq .row.value \"almost_no_chance\" }}●{{ end }}" },
      { header = "Very unlikely (05–20%)", value = "{{ if eq .row.value \"very_unlikely\" }}●{{ end }}" },
      { header = "Unlikely (20–45%)", value = "{{ if eq .row.value \"unlikely\" }}●{{ end }}" },
      { header = "Roughly even chance (45–55%)", value = "{{ if eq .row.value \"roughly_even\" }}●{{ end }}" },
      { header = "Likely (55–80%)", value = "{{ if eq .row.value \"likely\" }}●{{ end }}" },
      { header = "Very likely (80–95%)", value = "{{ if eq .row.value \"very_likely\" }}●{{ end }}" },
      { header = "Almost certain (95–99%)", value = "{{ if eq .row.value \"almost_certain\" }}●{{ end }}" }
    ]
  }
}

section "ctid_intel_requirements" {
  title = "Intelligence Requirements"
  content list {
    items         = query_jq(".vars.report.intelligence_requirements // []")
    format        = "unordered"
    item_template = "{{ . }}"
  }
}

section "ctid_feedback" {
  title = "Feedback"
  content text {
    value = "Send feedback and follow-up requirements to {{ .vars.report.feedback_contact }}."
  }
}

content table "ctid_mitre_attack" {
  rows = query_jq(".vars.report.attack // []")
  columns = [
    { header = "Attribution", value = "{{ .row.value.attribution }}" },
    { header = "Tactics", value = "{{ .row.value.tactic }}" },
    { header = "Techniques", value = "{{ .row.value.technique }}" },
    { header = "Sub-technique", value = "{{ .row.value.subtechnique }}" },
    { header = "Procedure", value = "{{ .row.value.procedure }}" },
    { header = "D3FEND", value = "{{ .row.value.d3fend }}" },
    { header = "Deployed Control", value = "{{ .row.value.control }}" }
  ]
}

section "ctid_mitre_attack" {
  title = "MITRE ATT&CK Table"
  content ref {
    base = content.table.ctid_mitre_attack
  }
}

section "ctid_timeline_of_activity" {
  title = "Timeline of Activity"
  content table {
    rows = query_jq(".vars.report.timeline // []")
    columns = [
      { header = "Attribution", value = "{{ .row.value.attribution }}" },
      { header = "Start Date", value = "{{ .row.value.start }}" },
      { header = "End Date", value = "{{ .row.value.end }}" },
      { header = "Location", value = "{{ .row.value.location }}" },
      { header = "Sector", value = "{{ .row.value.sector }}" },
      { header = "Activity", value = "{{ .row.value.activity }}" }
    ]
  }
}

section "ctid_iocs" {
  title = "Indicators of Compromise (IOC)"

  section "malware" {
    title       = "Malware"
    is_included = query_jq("(.vars.report.malware // []) | length > 0")
    content table {
      rows = query_jq(".vars.report.malware // []")
      columns = [
        { header = "Attribution", value = "{{ .row.value.attribution }}" },
        { header = "Malicious Tool Name", value = "{{ .row.value.name }}" },
        { header = "Hash Type", value = "{{ .row.value.hash_type }}" },
        { header = "File Hash", value = "{{ .row.value.hash }}" },
        { header = "Associated Files Hash", value = "{{ .row.value.associated_hashes }}" },
        { header = "Brief Description", value = "{{ .row.value.description }}" },
        { header = "Analysis Report", value = "{{ .row.value.report_url }}" },
        { header = "First Reported", value = "{{ .row.value.first_seen }}" },
        { header = "Last Reported", value = "{{ .row.value.last_seen }}" }
      ]
    }
  }

  section "network" {
    title       = "Network"
    is_included = query_jq("(.vars.report.network_indicators // []) | length > 0")
    content table {
      rows = query_jq(".vars.report.network_indicators // []")
      columns = [
        { header = "Attribution", value = "{{ .row.value.attribution }}" },
        { header = "Network Artifact", value = "{{ .row.value.value }}" },
        { header = "Details", value = "{{ .row.value.description }}" },
        { header = "Intrusion Phase", value = "{{ .row.value.phase }}" },
        { header = "First Reported", value = "{{ .row.value.first_seen }}" },
        { header = "Last Reported", value = "{{ .row.value.last_seen }}" }
      ]
    }
  }

  section "system_artifacts" {
    title       = "System Artifacts"
    is_included = query_jq("(.vars.report.host_indicators // []) | length > 0")
    content table {
      rows = query_jq(".vars.report.host_indicators // []")
      columns = [
        { header = "Attribution", value = "{{ .row.value.attribution }}" },
        { header = "Host Artifact", value = "{{ .row.value.value }}" },
        { header = "Type", value = "{{ .row.value.type }}" },
        { header = "Details", value = "{{ .row.value.description }}" },
        { header = "Tactic", value = "{{ .row.value.tactic }}" },
        { header = "First Reported", value = "{{ .row.value.first_seen }}" },
        { header = "Last Reported", value = "{{ .row.value.last_seen }}" }
      ]
    }
  }
}

section "ctid_cves" {
  title       = "Common Vulnerabilities and Exposures (CVEs)"
  is_included = query_jq("(.vars.report.cves // []) | length > 0")
  content table {
    rows = query_jq(".vars.report.cves // []")
    columns = [
      { header = "Attribution", value = "{{ .row.value.attribution }}" },
      { header = "CVE Number", value = "{{ .row.value.name }}" },
      { header = "CVSS Score", value = "{{ .row.value.cvss }}" },
      { header = "Patch Available", value = "{{ .row.value.patch_available }}" },
      { header = "Other Remediation", value = "{{ .row.value.remediation }}" },
      { header = "Date Reported", value = "{{ .row.value.published }}" },
      { header = "Patch Applied", value = "{{ .row.value.patch_applied }}" }
    ]
  }
}

section "ctid_signatures" {
  title       = "Signatures"
  is_included = query_jq("(.vars.report.signatures // []) | length > 0")
  content list {
    items         = query_jq(".vars.report.signatures // []")
    format        = "unordered"
    item_template = "**{{ .name }}:** `{{ .pattern }}`"
  }
}

section "ctid_data_sources" {
  title = "Data Sources"
  content list {
    items         = query_jq(".vars.report.sources // []")
    format        = "unordered"
    item_template = "[{{ .name }}]({{ .url }}) — {{ .description }}"
  }
}

content table "ctid_metadata" {
  rows = query_jq(".vars.report.metadata // []")
  columns = [
    { header = "Field", value = "**{{ .row.value.field }}**" },
    { header = "Value", value = "{{ .row.value.value }}" }
  ]
}
