document "mitre_ctid_executive_report" {

  meta {
    name = "MITRE CTID Executive Report Template"

    description = <<-EOT
      Executive template Use Cases:

      Author: CTI Team 
      Audience: Executive 
      Key Decisions: Resource allocation; Evaluate options to mitigate risks to the organization.
      Decision-Enabling Data Points: Analysis of change in the cyber landscape that is relevant and impactful to organization; Estimate of how the trend may evolve; Key variables that could have an impact on the trend.
    EOT

    url = "https://github.com/center-for-threat-informed-defense/cti-blueprints"
    license = "Apache License 2.0"
    updated_at = "2024-01-26T11:00:11+01:00"
    tags = ["mitre", "executive"]

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
        * What is the trend and why it is significant for the decision maker?

        This section should not summarize the underlying reports used to create the analysis.
        The Executive Summary should not be longer than 2–3 paragraphs, according to best practices.
      EOT
    }
  }

  section "key_points" {
    title = "Key Points*"

    content text {
      value = <<-EOT
        This section should clearly lay out:

        * The trend in question.
        * The reason it is important.
        * The key decision/risk/opportunity it presents.
      EOT
    }
  }

  section "assessment" {
    title = "Assessment"

    content text {
      value = <<-EOT
        This section needs to lay out several things.

        * What is the trend that is being assessed?
        * What is the historical baseline?
        * What is the new information that creates a need to understand this now?
        * Why is this relevant to your consumer? For example: does it have the potential to undermine existing security controls? Does it have the potential to undermine earnings in each geographic region? Does it present an opportunity to move into a new market space?
        * What does the new normal likely look like if no action is taken?
        * What key variables can impact the trend (both positively and negatively) should they change from current available information?
      EOT
    }
  }

  section "outlook" {
    title = "Outlook"

    content text {
      value = <<-EOT
        This section should provide an analysis of both the impact and what key points of leverage the company must disrupt or take advantage of the trend. This should focus on what key variables can impact the trend (both positively and negatively) should they change from current available information and which of those variables are within the constituent's control.
      EOT
    }
  }

  section ref {
    base = section.ctid_key_intelligence_gaps
  }

  section ref {
    base = section.ctid_probability_matrix
  }

  section ref {
    base = section.ctid_intel_requirements
  }

  content ref {
    base = content.text.ctid_data_sources
  }
}
