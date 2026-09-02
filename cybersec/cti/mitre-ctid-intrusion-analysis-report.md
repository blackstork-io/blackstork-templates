# Intrusion Analysis: Suspicious PowerShell and C2 Activity

## Executive Summary

**Bottom line:** Fourteen outbound connections from a finance workstation to a newly observed VPS followed a suspicious PowerShell launch.

This assessment is written for SOC, incident response, and threat hunting teams. The principal
judgment is assessed as **likely** based on the
STIX objects and external references supplied with this report.

## Key Points

- Subject: Fourteen outbound connections from a finance workstation to a newly observed VPS followed a suspicious PowerShell launch.
- Attribution: Unconfirmed SABLE JACKAL activity
- Assessed probability: likely
- Intended audience: SOC, incident response, and threat hunting teams

## Indicator Analysis

Fourteen outbound connections from a finance workstation to a newly observed VPS followed a suspicious PowerShell launch. Attribution remains
likely; hunt first for the expected behaviors in
the following ATT&CK table and for the listed network indicators.

## MITRE ATT&CK: TTPs Likely to Be in the Network

|            Attribution            |      Tactics      | Techniques | Sub-technique |                                                           Procedure                                                           | D3FEND | Deployed Control |
|:---------------------------------:|:-----------------:|:----------:|:-------------:|:-----------------------------------------------------------------------------------------------------------------------------:|:------:|:----------------:|
| Unconfirmed SABLE JACKAL activity | credential-access |   T1003    |      N/A      | Credential access commonly follows this cluster's initial execution. Hunt for access to LSASS and registry credential stores. | D3-OSM |   Not provided   |


## MITRE ATT&CK: TTPs Observed in the Intrusion

|  Tactics  | Techniques | Sub-technique |                        Procedure                        | D3FEND |
|:---------:|:----------:|:-------------:|:-------------------------------------------------------:|:------:|
| execution | T1059.001  |  PowerShell   | Encoded PowerShell launched from a spreadsheet process. | D3-SCA |


## Indicators of Compromise for Hunting

### Indicators of Compromise (IOC)

#### Network

|            Attribution            | Network Artifact |                   Details                   |   Intrusion Phase   |    First Reported    | Last Reported |
|:---------------------------------:|:----------------:|:-------------------------------------------:|:-------------------:|:--------------------:|:-------------:|
| Unconfirmed SABLE JACKAL activity |    192.0.2.80    | Address contacted by the affected endpoint. | Command and Control | 2026-08-29T03:14:00Z |    Active     |


## Signatures

- **Encoded PowerShell detection:** `[process:command_line MATCHES '(?i)powershell.*-enc']`

_Attach an Attack Flow and/or Navigator heat map when available._

## Probability Matrix

The marker identifies the probability of the principal analytic judgment.

| Almost no chance (01–05%) | Very unlikely (05–20%) | Unlikely (20–45%) | Roughly even chance (45–55%) | Likely (55–80%) | Very likely (80–95%) | Almost certain (95–99%) |
|:-------------------------:|:----------------------:|:-----------------:|:----------------------------:|:---------------:|:--------------------:|:-----------------------:|
|                           |                        |                   |                              |        ●        |                      |                         |


## Intelligence Requirements

- IR-4: Identify behaviors likely to precede and follow the observed command-and-control activity.

## Feedback

Send feedback and follow-up requirements to ir@example.org.

## Data Sources

- [Incident telemetry](https://example.org/incidents/IR-2026-081) — Sanitized SOC and IR observations

## Report Metadata

|        Field         |               Value               |
|:--------------------:|:---------------------------------:|
|   **Threat Actor**   | Unconfirmed SABLE JACKAL activity |
| **Actor Motivation** |              Unknown              |
