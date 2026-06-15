section "ctid_key_intelligence_gaps" {
 title = "Key Intelligence Gaps"

  content text {
    value = <<-EOT
      Brief bullet summary of additional information the CTI team is seeking to further evaluate risk. Call out explicit gaps in understanding and what will change assessment because you don’t have information yet
    EOT
  }
}


section "ctid_probability_matrix" {

  title = "Probability Matrix"

  content text {
    value = "We recommend that analysts properly express and explain uncertainties associated with major analytic judgments."
  }

  content table {
    columns = [
      {
        header = "Almost no chance (01-05%)"
        value = ""
      },
      {
        header = "Very unlikely (05-20%)"
        value = ""
      },
      {
        header = "Unlikely (20-45%)"
        value = ""
      },
      {
        header = "Roughly Even Chance (45-55%)"
        value = ""
      },
      {
        header = "Likely (55-80%)"
        value = ""
      },
      {
        header = "Very likely (80-95%)"
        value = ""
      },
      {
        header = "Almost certain(ly) (95-99%)"
        value = ""
      }
    ]
  }
}

section "ctid_intel_requirements" {

  title = "Intelligence Requirements"

  content text {
    value = "Brief citation of CTI requirements(s) addressed by this report."
  }
}


section "ctid_feedback" {

  title = "Feedback"

  content text {
    value = "Provide a point of contact (e.g., an email address) for customer feedback on the published CTI report, such as whether the report addressed the customers’ Intelligence Requirements, how the report could be more actionable, additional Intelligence Requirement questions to answer, etc."
  }
}


content table "ctid_mitre_attack" {
  columns = [
    {
      header = "Attribution"
      value = ""
    },
    {
      header = "Tactics"
      value = ""
    },
    {
      header = "Techniques"
      value = ""
    },
    {
      header = "Sub Technique"
      value = ""
    },
    {
      header = "Procedure"
      value = ""
    },
    {
      header = "D3FEND"
      value = ""
    },
    {
      header = "Deployed Control"
      value = ""
    }
  ]
}


section "ctid_mitre_attack" {
    title = "MITRE ATT&CK Table (based on v12)"

    content text {
      value = <<-EOT
        Table of the MITRE ATT&CK tactics and techniques/sub-techniques from the campaign. The procedure column details a particular instance of how a technique/sub-technique has been used. The D3FEND column includes the corresponding MITRE D3FEND countermeasure technique, if available. If using the tool, the Tactics and Techniques can be automatically generated from an Attack Flow document using the plug-in.
      EOT
    }

    content ref {
      base = content.table.ctid_mitre_attack
    }
}


section "ctid_iocs" {

  title = "Indicators of Compromise (IOC)"

  content text {
    value = "This section consists of three IOC tables [Malware, Network, and System Artifacts] associated with the Campaign."
  }

  section "malware" {

    title = "Malware"

    content text {
      value = "This table should detail the malware and tools associated with the campaign. The \"Associated Files Hash\" column can include any files related to the tool or malware, e.g., downloader for a memory dropper. The \"Brief Malware Description\" column should provide a short description for context, as well as where the activity falls in the intrusion chain. The first and last reported fields are intended to memorialize the longevity of a particular piece of malware, providing additional insight into trends in malicious behavior."
    }

    content table {
      columns = [
        {
          header = "Attribution"
          value = ""
        },
        {
          header = "Malicious Tool Name"
          value = ""
        },
        {
          header = "Hash Type"
          value = ""
        },
        {
          header = "File Hash"
          value = ""
        },
        {
          header = "Associated Files Hash"
          value = ""
        },
        {
          header = "Brief Description"
          value = ""
        },
        {
          header = "Malware Analysis Report (Hyperlink, or N/A)"
          value = ""
        },
        {
          header = "First Reported"
          value = ""
        },
        {
          header = "Last Reported"
          value = ""
        }
      ]
    }
  }

  section "network" {

    title = "Network"

    content text {
      value = "This table should detail the network indicators associated with the campaign, e.g., domains and IP addresses. The \"Intrusion Phase\" column includes Initial Access, Command and Control, and Exfiltration. The first and last reported fields are intended to memorialize the longevity of a particular network artifact, providing additional insight into trends in malicious behavior."
    }

    content table {
      columns = [
        {
          header = "Attribution"
          value = ""
        },
        {
          header = "Network Artifact"
          value = ""
        },
        {
          header = "Details"
          value = ""
        },
        {
          header = "Intrusion Phase"
          value = ""
        },
        {
          header = "First Reported"
          value = ""
        },
        {
          header = "Last Reported"
          value = ""
        }
      ]
    }
  }

  section "system_artifacts" {

    title = "System Artifacts"

    content text {
      value = "This table should detail any unique artifacts associated with the campaign that could be observed on a host, e.g., processes, DLLs, registry keys. The first and last reported fields are intended to memorialize the longevity of a particular system artifact, providing additional insight into trends in malicious behavior."
    }

    content table {
      columns = [
        {
          header = "Attribution"
          value = ""
        },
        {
          header = "Host Artifact"
          value = ""
        },
        {
          header = "Type"
          value = ""
        },
        {
          header = "Details"
          value = ""
        },
        {
          header = "Tactic"
          value = ""
        },
        {
          header = "First Reported"
          value = ""
        },
        {
          header = "Last Reported"
          value = ""
        }
      ]
    }
  }
}

section "ctid_signatures" {
  title = "Signatures"

  content text {
    value = <<-EOT
      This section should include detections (e.g., Yara signature) that correspond to the malware or malicious activity associated with the campaign.

      1. Malware or malicious activity name
        1. Detection
      2. Malware or malicious activity name
        1. Detection
    EOT
  }
}


section "ctid_executive_summary" {
  title = "Executive Summary*"

  content text {
    value = <<-EOT
      This is a brief narrative explaining the significance of the report. This section should focus on the decision the CTI summary is supporting and the change in circumstances that makes this timely and actionable.

      It should focus on:

      * The single largest takeaway from the CTI analysis?
      * What is the new information?
      * Why it is important for the audience to understand?

      This section should not summarize the underlying reports used to create the analysis.
      This should be able to convey the most important analysis to the reader, so that they can skip the rest of the report and still be able to take an informed action.
    EOT
  }
}

section "ctid_key_points" {
  title = "Key Points*"

  content text {
    value = <<-EOT
      These bullets should summarize:

      * Who is the report about?
      * What did they do?
      * How they did it?
      * Why does it matter to the audience of the CTI analysis?
    EOT
  }
}


section "ctid_assessment" {
  title = "Assessment"

  content text {
    value = <<-EOT
      This section should contain:

      * Key Judgement: This activity, threat actor, malware, etc. demonstrates X that has the potential to impact Y.
      * Change Analysis: Threat actor has a new tool that creates capability Y, leverages vuln X, etc.
      * Relation to Your Organization: This threat actor historically targets our sector; we have previous detections of malware associated with this threat actor; the malware leverages vulnerabilities in our software stack, etc.
    EOT
  }
}


section "ctid_timeline_of_activity" {

  title = "Timeline of Activity"

  content table {
    columns = [
      {
        header = "Attribution"
        value = "Sample text goes here"
      },
      {
        header = "Start Date"
        value = ""
      },
      {
        header = "End Date"
        value = ""
      },
      {
        header = "Location"
        value = ""
      },
      {
        header = "Sector"
        value = ""
      },
      {
        header = "Activity"
        value = ""
      }
    ]
  }
}


section "ctid_cves" {

  title = "Common Vulnerabilities and Exposures (CVEs)"

  content text {
    value = "CVEs associated with the campaign. The date reported field is designed to capture the date when the CVE became public knowledge. To adequately fill out this table, it may require information from other internal teams."
  }

  content table {
    columns = [
      {
        header = "Attribution"
        value = ""
      },
      {
        header = "CVE Number"
        value = ""
      },
      {
        header = "CVSS Score"
        value = ""
      },
      {
        header = "Patch Available (Y/N)"
        value = ""
      },
      {
        header = "Other Remediation"
        value = ""
      },
      {
        header = "Date Reported"
        value = ""
      },
      {
        header = "Patch Applied (Y/N/UNK/NA)"
        value = ""
      }
    ]
  }
}


content text "ctid_data_sources" {
  value = <<-EOT
    *Data Sources:*

    * Cite external CTI Report with hyperlink if available
    * Cite Internal Telemetry sources provided by the SOC as needed. This field is not designed to preserve telemetry data and should only include data necessary to justify the analytic assessments.
  EOT
}
