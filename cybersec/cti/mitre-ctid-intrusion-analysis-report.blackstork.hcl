document "mitre_ctid_intrusion_analysis_report" {

  meta {
    name = "MITRE CTID Intrusion Analysis Report Template"

    description = <<-EOT
      Author: CTI Team 
      Audience: SOC, IR, Hunt 
      Key Decisions: Look for additional adversary behavior beyond the initial alert; Stop the adversary from reaching their goals and contain the threats.  
      Decision-Enabling Data Points: intelligence assessment of potential intrusion scenarios; Set of techniques used in past adversary behavior.
    EOT

    url = "https://github.com/center-for-threat-informed-defense/cti-blueprints"

    license = "Apache License 2.0"
    tags = ["mitre", "campaign"]

    updated_at = "2024-01-22T10:00:01+01:00"
  }

  title = "Report Title*"

  section "summary" {
    title = "Executive Summary*"

    content text {
      value = <<-EOT
        This should be a brief narrative explaining the significance of the report to senior leadership. This should focus on the decision the CTI summary is supporting and the change in circumstances that makes this timely and actionable.

        This should focus on:

        * Bottom Line Up Front (BLUF): The single largest takeaway from the CTI analysis.
        * What is the new information?
        * Why it is important for the audience to understand this now?

        This section should not summarize the underlying reports used to create the analysis.

        This should be able to convey the most important analysis to the reader, so that they can skip the rest of the report and still be able to take an informed action.

        The Executive Summary should not be longer than 2 -3 paragraphs, according to best practices. For this report, we recommend trying to keep it to a paragraph
      EOT
    }
  }

  section "key_points" {
    title = "Key Points*"

    content text {
      value = <<-EOT
        These bullets should summarize:

        * What data anchors the analysis.
        * Where the data falls in the intrusion chain.
        * Threat actors associated with the data.
        * Malicious activity generally observed before and after the known activity.
      EOT
    }
  }

  section "indicator_analysis" {
    title = "Indicator Analysis"

    content text {
      value = <<-EOT
      This section should provide:

      * An assessment of what other TTPs are likely to be in a network based on the initial information provided by the SOC or IR team.
        * Include corresponding detections in the Signature section below, if applicable (i.e., YARA signatures, etc.)
      * Once possible, provide attribution to a threat actor with a level of confidence.
        * An Attack Flow for that threat actor should then be included *IF CURRENTLY AVAILABLE*
          * If not available, a description of end goal TTPs is most important to aid in initial containment steps.
          * Only take the time to create a full Attack Flow once the IR has moved into eradication and remediation.
        * If multiple threat actors could be responsible based on observed data, provide the above for each threat actor ordered by confidence in attribution and secondarily by potential harm caused. This should provide key hunt recommendations for the different threat actors that may be responsible to help the IR team find additional malicious activity and increase the intelligence assessment of attribution.
      EOT
    }
  }

  section "mitreattack_ttps_in_network" {
    title = "MITRE ATT&CK Table (based on v12): TTPs Likely to Be in the Network"

    content text {
      value = <<-EOT
        This table should show the MITRE tactics and techniques/Sub-techniques not yet observed but likely to be in the network. The procedure column details a particular instance of how a technique/sub-technique has been used. The D3FEND column includes the corresponding MITRE D3FEND countermeasure technique, if available. If using the tool, the tactics and techniques can be automatically generated from an Attack Flow document using the plug-in.
      EOT
    }

    content ref {
      base = content.table.ctid_mitre_attack
    }
  }

  section "mitreattack_ttps_observed" {
    title = "MITRE ATT&CK Table (based on v12): TTPs Observed in the Intrusion"

    content text {
      value = <<-EOT
        This table should show the MITRE tactics, techniques/sub-techniques, and procedures observed during the intrusion based on data provided by the SOC or IR team. Analysts can include the corresponding MITRE DEFEND countermeasure technique, if available. If using the tool, the tactics and techniques can be automatically generated from an Attack Flow document using the plug-in.
      EOT
    }

    content table {
      columns = [
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
      ]
    }
  }

  section ref {
    base = section.ctid_iocs

    title = "Indicators of Compromise for Hunting"
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
        | **Actor Motivation:** | - Cyber Espionage, Data Theft, Cyber Crime, Ransomware, Destructive Attack, Hacktivism, Other, Unknown|
      EOT
    }
  }
}

