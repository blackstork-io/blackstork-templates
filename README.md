<!-- markdownlint-disable -->

<div align="center">

# BlackStork Templates

[blackstork-cli](https://github.com/blackstork-io/blackstork-cli) | [blackstork-cli docs](https://blackstork.io/fabric/docs/)

</div>

**BlackStork** is a declarative document generation engine designed to automate reporting workflows for cybersecurity teams. Using [BlackStork Configuration Language](https://blackstork.io/fabric/docs/language/) (BCL, based on HashiCorp Configuration Language, HCL), BlackStork builds and evaluates a document definition (with defined data inputs, content blocks, and output formats) to fetch data from external APIs, process the payloads natively using [`jq`](https://jqlang.org/manual/), and render the output. Its primary purpose is to eliminate manual data aggregation by automatically transforming raw security data into human-readable documents.

This repository provides a collection of open-source BlackStork templates ready for deployment or customization. By applying these templates, security engineers, threat analysts and securty operators can rapidly generate standardized, production-ready outputs for their stakeholders. These templates can be used both in [BlackStork SaaS](https://blackstork.io) and with [`blackstork-cli`](https://github.com/blackstork-io/blackstork-cli) tool.

## Templates

- SecOps:
    - [SOC Weekly Activity Overview Template](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/secops/soc-weekly-activity-overview-elastic-security.fabric) ([example](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/secops/soc-weekly-activity-overview-elastic-security.md))
- Penetration Testing:
  - [Offensive Security](https://www.offsec.com/) exam reports:
    - [OSCE Exam Documentation](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-osce-exam-report.fabric) ([example](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-osce-exam-report.md))
    - [OSCP Penetration Test Report](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-oscp-exam-report.fabric) ([example](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-oscp-exam-report.md))
    - [OSDA Exam Report](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-osda-exam-report.fabric) ([example](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-osda-exam-report.md))
    - [OSED Exam Documentation](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-osed-exam-report.fabric) ([example](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-osed-exam-report.md))
    - [OSEE Exam Documentation](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-osee-exam-report.fabric) ([example](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-osee-exam-report.md))
    - [OSEP Exam Documentation](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-osep-exam-report.fabric) ([example](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-osep-exam-report.md))
    - [OSMR Exam Documentation](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-osmr-exam-report.fabric) ([example](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-osmr-exam-report.md))
    - [OSWA Exam Documentation](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-oswa-exam-report.fabric) ([example](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-oswa-exam-report.md))
    - [OSWE Exam Documentation](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-oswe-exam-report.fabric) ([example](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-oswe-exam-report.md))
    - [OSWP Exam Documentation](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-oswp-exam-report.fabric) ([example](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/pentesting/offsec-oswp-exam-report.md))
- Cyber Threat Intelligence:
  - MITRE CTID CTI Blueprints ([source](https://mitre-engenuity.org/cybersecurity/center-for-threat-informed-defense/our-work/cti-blueprints/))
    - [Campaign Report Template](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/cti/mitre-ctid-campaign-report.fabric) ([example](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/cti/mitre-ctid-campaign-report.md))
    - [Executive Report Template](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/cti/mitre-ctid-executive-report.fabric) ([example](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/cti/mitre-ctid-executive-report.md))
    - [Intrusion Analysis Report Template](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/cti/mitre-ctid-intrusion-analysis-report.fabric) ([example](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/cti/mitre-ctid-intrusion-analysis-report.md))
    - [Threat Actor Profile Report Template](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/cti/mitre-ctid-threat-actor-profile-report.fabric) ([example](https://github.com/blackstork-io/blackstork-templates/tree/main/cybersec/cti/mitre-ctid-threat-actor-profile-report.md))

## Contributions

We welcome contributions to this repository. If you have developed custom BlackStork templates for
threat intelligence, incident response, secops or compliance reporting, consider sharing them here.

Sharing your templates helps other security teams automate their workflows and establishes reporting
best practices across the industry. To get started, review our [contribution guidelines](CONTRIBUTING.md) and submit a
pull request with your new templates or improvements to existing ones.

## License

Fabric is licensed under the MIT License. See the [LICENSE](LICENSE) file for the details.
