document "mitre_ctid_threat_actor_profile_report" {

  meta {
    name = "MITRE CTID Threat Actor Profile Report Template"

    description = <<-EOT
      Author: CTI Team
      Audience: SOC
      Key Decisions: Determine alert prioritization and triaging; Identify TTPs that may require new or updated detections.
      Decision-Enabling Data Points: Context and relevance of the threat to the organization; Adversary behavior and potential goals; IOC enrichment; Associated malware and tools; Newly observed TTPs 

      Author: CTI Team
      Audience: Threat Hunt
      Key Decisions: Conduct tailored, specific searches in the network for the reported malicious behavior.
      Decision-Enabling Data Points: Adversary behavior and potential goals; IOC enrichment; Associated malware and tools; Observed TTPs; Difference from existing TTPs – net new capabilities, slight modifications, etc. 

      Author: CTI Team
      Audience: Red/Purple Team
      Key Decisions: Conduct updated, threat-informed adversary emulation to better assess an organization's defensive posture against the reported malicious activity.   
      Decision-Enabling Data Points: Adversary behavior and potential goals; IOC enrichment; Associated malware and tools; Observed TTPs 
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

  section "threat_actor_summary" {

    title = "Threat Actor Summary"

    content text {
      value = "This section should contain relevant information outlining the key differentiating features of the intrusion set. Start with an overarching summary: This intrusion set, associated with county Y, organization X, mainly targets sectors 1,2,3 and countries A, B, C. They have been openly tracked since XX/XX/XXXX."
    }

    section {
      title = "Tactics, Techniques, and Procedures"

      content text {
        value = <<-EOT
          This sub section should list out the types of tools and TTPs they leverage. This does not need to be an exhaustive list of tool names (that will be listed in the table below), but rather a description of how they operate.

          EXAMPLE: Threat actor X leverages legitimate administrative tools during their intrusions to avoid detection and attribution. They primarily rely on exploitation of vulnerabilities in internet facing devices for initial access, etc.
        EOT
      }
    }

    section {
      title = "Infrastructure"

      content text {
        value = <<-EOT
          This sub section should list the types of infrastructure the threat actor leverages for command and control, initial intrusion, and exfiltration from networks.
          EXAMPLE: Threat actor X leverages VPS providers for managing C2 communication and exfiltration but prefers to compromise open exchange relays to send phishing emails for initial intrusion.
        EOT
      }
    }

    section {
      title = "Victims"

      content text {
        value = <<-EOT
          This sub section should list the countries and industries targeted by the threat actor. It should also note if there is a pattern shift in this activity over time.
          EXAMPLE: Threat actor X primarily targeted Western Europe defense and advanced technology sectors from 2015- 2021. However, in 2022 the targeting saw a shift to include Latin America and financial services.
        EOT
      }
    }

    section {
      title = "Attribution"

      content text {
        value = <<-EOT
          This sub section should focus on what is known about the intrusion set from an attribution perspective. As attribution is often subjective, each organization will have to come to their own threshold for attributing activity internally. Reserve this section to discuss the known facts that could support attribution to a particular country or organization.
          EXAMPLE: Threat actor X is attributed to China by several cybersecurity vendors because Chinese language artifacts are present in different malware utilized by the threat actor. Operating times generally correlate to China’s time zone and there is a lull in activity around major Chinese holidays. Additionally, the victims of this activity align with Chinese national interests in Southeast Asia.
        EOT
      }
    }
  }

  section ref {
    base = section.ctid_timeline_of_activity
  }

  section ref {
    base = section.ctid_key_intelligence_gaps
  }

  section ref {
    base = section.ctid_mitre_attack
  }

  section "vistims" {
    title = "Victims"

    content text {
      value = "This table should detail known victims, including sector and geographic location, of this threat actor."
    }

    content table {
      columns = [
        {
          header = "Name"
          value = ""
        },
        {
          header = "Date Reported"
          value = ""
        },
        {
          header = "Sector"
          value = ""
        },
        {
          header = "City/State/Province/etc."
          value = ""
        },
        {
          header = "Country/Region"
          value = ""
        },
      ]
    }
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
