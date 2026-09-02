# SABLE JACKAL Threat Actor Profile

## Executive Summary

**Bottom line:** An advanced espionage group targeting energy and engineering organizations.

This assessment is written for SOC, threat hunt, and red/purple teams. The principal
judgment is assessed as **likely** based on the
STIX objects and external references supplied with this report.

## Key Points

- Subject: An advanced espionage group targeting energy and engineering organizations.
- Attribution: SABLE JACKAL
- Assessed probability: likely
- Intended audience: SOC, threat hunt, and red/purple teams

## Assessment

**Key Judgment:** An advanced espionage group targeting energy and engineering organizations.

**Confidence:** likely.

**Intelligence limitations:** 2 key
gaps remain and are listed below.

## Threat Actor Summary

An advanced espionage group targeting energy and engineering organizations.

### Tactics, Techniques, and Procedures

The actor's documented behavior is summarized in the MITRE ATT&CK table below.

### Infrastructure

- Rented VPS nodes used as redirectors.

### Victims

Known targeting includes energy in Northern Europe, Central Asia.

### Attribution

Multiple independent sources associate the cluster with a state-aligned collection requirement; attribution remains assessed, not confirmed.

## Timeline of Activity

| Attribution  |      Start Date      |       End Date       |           Location            | Sector |                                  Activity                                   |
|:------------:|:--------------------:|:--------------------:|:-----------------------------:|:------:|:---------------------------------------------------------------------------:|
| SABLE JACKAL | 2021-03-01T00:00:00Z | 2026-08-10T00:00:00Z | Northern Europe, Central Asia | energy | An advanced espionage group targeting energy and engineering organizations. |


## Key Intelligence Gaps

- The actor's current initial-access provider.
- Whether 2026 infrastructure represents a distinct subgroup.

## MITRE ATT&CK Table

| Attribution  |    Tactics     | Techniques | Sub-technique |                              Procedure                              | D3FEND |                 Deployed Control                 |
|:------------:|:--------------:|:----------:|:-------------:|:-------------------------------------------------------------------:|:------:|:------------------------------------------------:|
| SABLE JACKAL | initial-access |   T1190    |      N/A      | The actor exploits internet-facing edge devices for initial access. |  N/A   | Rapid edge-device patching and exploit telemetry |


## Victims

|              Name              | Date Reported | Sector | City/State/Province |        Country/Region         |
|:------------------------------:|:-------------:|:------:|:-------------------:|:-----------------------------:|
| Example Northern Grid Operator |  2026-07-18   | energy |         N/A         | Northern Europe, Central Asia |


## Indicators of Compromise (IOC)

### Network

| Attribution  | Network Artifact |              Details              |   Intrusion Phase   |    First Reported    | Last Reported |
|:------------:|:----------------:|:---------------------------------:|:-------------------:|:--------------------:|:-------------:|
| SABLE JACKAL |    192.0.2.44    | VPS address used as a redirector. | Command and Control | 2026-04-12T00:00:00Z |    Active     |


## Probability Matrix

The marker identifies the probability of the principal analytic judgment.

| Almost no chance (01–05%) | Very unlikely (05–20%) | Unlikely (20–45%) | Roughly even chance (45–55%) | Likely (55–80%) | Very likely (80–95%) | Almost certain (95–99%) |
|:-------------------------:|:----------------------:|:-----------------:|:----------------------------:|:---------------:|:--------------------:|:-----------------------:|
|                           |                        |                   |                              |        ●        |                      |                         |


## Intelligence Requirements

- IR-3: Track actors targeting energy-sector intellectual property.

## Feedback

Send feedback and follow-up requirements to cti@example.org.

## Data Sources

- [Example actor profile](https://example.org/actors/sable-jackal) — External STIX reference

## Report Metadata

|          Field          |                 Value                 |
|:-----------------------:|:-------------------------------------:|
|    **Threat Actor**     |             SABLE JACKAL              |
|       **Aliases**       |           Example Group 17            |
|   **Victim Location**   |     Northern Europe, Central Asia     |
|       **Sectors**       |                energy                 |
| **Infrastructure Used** | Rented VPS nodes used as redirectors. |
|  **Actor Motivation**   |          organizational-gain          |
