document "mitre_ctid_campaign_report" {

  meta {
    name = "MITRE CTID Campaign Report Template"

    description = <<-EOT
      The Campaign Report is designed to highlight new information related to a threat actor or capabilities. This should focus on new information and highlight how it poses a changed risk to your organization. This should not be an exhaustive product cataloguing all information about the topic, but rather a succinct report designed to convey a change in the status quo to the intended recipient.
    EOT

    url = "https://github.com/center-for-threat-informed-defense/cti-blueprints"

    license = "Apache License 2.0"
    tags = ["mitre", "campaign"]

    updated_at = "2024-01-22T10:00:01+01:00"
  }


  title = "Report Title*"

  section ref {
    base = section.ctid_executive_summary
  }

  section ref {
    base = section.ctid_key_points
  }

  section ref {
    base = section.ctid_assessment
  }

  section ref {
    base = section.ctid_key_intelligence_gaps
  }

  section ref {
    base = section.ctid_mitre_attack
  }

  section ref {
    base = section.ctid_timeline_of_activity
  }

  section ref {
    base = section.ctid_iocs
  }

  section ref {
    base = section.ctid_cves
  }

  section ref {
    base = section.ctid_signatures
  }

  content text {
    value = "_Attached Attack Flow and/or Navigator Heat Maps, if applicable_"
  }

  section ref {
    base = section.ctid_probability_matrix
  }

  section ref {
    base = section.ctid_intel_requirements
  }

  section ref {
    base = section.ctid_feedback
  }

  content ref {
    base = content.text.ctid_data_sources
  }

  section "metadata" {

    content text {
      value = <<-EOT
        The metadata table below is for automation purposes and provides discrete fields for tool extraction. If you are not using the tool, we recommend removing the table.

        |   |   |
        |---|---|
        | **Threat Actor:** | - Primary Threat Actor Name(s) or Unknown<br/>- Associated Group Names/Aliases or N/A|
        | **Victim Location:** | - Drop-down list of countries|
        | **Sectors:** | - Drop-down list of NAICS industries|
        | **Infrastructure Used:** | - Infrastructure used by adversary|
        | **Actor Motivation:** | - Cyber Espionage, Data Theft, Cyber Crime, Ransomware, Destructive Attack, Hacktivism, Other, Unknown|
      EOT
    }
  }
}
