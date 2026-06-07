# Prerequisites:
#
# To be able to query the detection rule status changes, audit logging for the cluster
# needs to be configured:
#   - Deployment > Monitoring > Logs and metrics > Ship to a deployment;
#   - https://www.elastic.co/guide/en/cloud-enterprise/current/ece-enable-auditing.html
#      - audit must be enabled both on Elasticsearch and Kibana nodes
#
# The template relies on custom alert tags: "Materialized Risk" and "True Positive"
# For the details on how to add custom tags to alerts, see
# https://www.elastic.co/guide/en/security/current/advanced-settings.html#manage-alert-tags
#
# In addition to the configuration blocks (see https://blackstork.io/fabric/docs/language/configs/)
# the template expects these environment variables to be set:
# - ELASTIC_KB_ENDPOINT -- Kibana endpoint URL
# - ELASTIC_API_KEY -- API key for Elastic Cluster
# - ELASTIC_AGENT_POLICY_ID -- an ID of an existing fleet agent policy


data elasticsearch "alerts_w_aggs" {
  index = ".alerts-security.alerts-default"
  aggs = {
    per_rule_name = {
      "terms": {"field": "kibana.alert.rule.name"}
    },
    per_severity = {
      "terms": {"field": "kibana.alert.rule.parameters.severity"}
    },
    per_tag = {
      "terms": {"field": "kibana.alert.workflow_tags"}
    },
    per_hour = {
      "date_histogram": {"field": "@timestamp", "calendar_interval": "1h"}
    },
    per_day = {
      "date_histogram": {"field": "@timestamp", "calendar_interval": "1d"}
    },
    per_rule_per_tag = {
      "multi_terms": {
        "terms": [
          {"field": "kibana.alert.rule.name"},
          {"field": "kibana.alert.workflow_tags"},
        ]
      }
    }
    per_rule_per_severity = {
      "multi_terms": {
        "terms": [
          {"field": "kibana.alert.rule.name"},
          {"field": "kibana.alert.rule.parameters.severity"},
        ]
      }
    },
  }
  only_hits = false
  size = 0

  fields = [
    # Rule details
    "kibana.alert.rule.description",
    "kibana.alert.rule.name",
    "kibana.alert.rule.parameters.severity",
    # Workflow-related fields
    "kibana.alert.workflow_status",
    "kibana.alert.workflow_status_updated_at",
    # Alert details
    "kibana.alert.start",
  ]
}

document "soc_weekly_activity_overview" {
 
   meta {
     name = "SOC Weekly Activity Overview Template using Elastic Security"
     authors = [
       "Filip Winiarczyk <https://www.linkedin.com/in/filipwiniarczyk>",
       "Sergey Polzunov <sergey@blackstork.io>"
     ]
     url = "https://blackstork.io/blog/soc-weekly-activity-overview-report/"
     license = "Apache License 2.0"
     updated_at = "2024-04-15T22:32:11+02:00"
     tags = ["soc", "elastic", "operational", "weekly"]
   }

  # All alerts created in a current period
  data ref "alerts_curr" {
    base = data.elasticsearch.alerts_w_aggs

    query_string = "@timestamp:[now-7d TO now]"
    size = 30000
  }

  # All alerts created in a previous period
  data ref "alerts_prev" {
    base = data.elasticsearch.alerts_w_aggs

    query_string = "@timestamp:[now-14d TO now-7d]"
    size = 0
  }

  # Closed alerts in a current period with impact.
  # The alerts with impact are marked with "Materialized Risk" tag.
  data ref "alerts_curr_w_impact" {
    base = data.elasticsearch.alerts_w_aggs

    query_string = <<-EOT
      @timestamp:[now-7d TO now]
      AND NOT kibana.alert.workflow_status:"open"
      AND kibana.alert.workflow_tags:"Materialized Risk"
    EOT
    size = 10000
  }

  # Closed alerts in a current period without impact.
  # These are the alerts that are NOT marked with "Materialised risk" tag.
  data ref "alerts_curr_wo_impact" {
    base = data.elasticsearch.alerts_w_aggs

    query_string = <<-EOT
      @timestamp:[now-7d TO now]
      AND NOT kibana.alert.workflow_status:"open"
      AND NOT kibana.alert.workflow_tags:"Materialized Risk"
    EOT
    size = 0
  }

  # Closed alerts in a current period that are false positives.
  # False positives are marked with "False Positive" tag.
  data ref "alerts_curr_fp" {
    base = data.elasticsearch.alerts_w_aggs

    query_string = <<-EOT
      @timestamp:[now-7d TO now]
      AND kibana.alert.workflow_tags:"False Positive"
      AND NOT kibana.alert.workflow_status:"open"
    EOT
    size = 0
  }

  # The list of detection rules configured in Elastic Security
  data http "rules" {
    url = join("", [
      env.ELASTIC_KB_ENDPOINT,
      "/api/alerting/rules/_find?per_page=10000&fields=%5B%22name%22%2C%22id%22%2C%22enabled%22%5D"
    ])
    headers = {
      Authorization = join(" ", ["ApiKey", env.ELASTIC_API_KEY])
    }
  }

  # Detection rules disabled in a current period
  data elasticsearch "rules_disabled_curr" {
    index = "elastic-cloud-logs-*"
    query_string = "event.action:rule_disable AND @timestamp:[now-7d TO now]"

    aggs = {
      per_rule_id = {
        "terms": {"field": "kibana.saved_object.id"}
      }
    }
    only_hits = false
    size = 0
  }

  # Detection rules enabled in a current period
  data elasticsearch "rules_enabled_curr" {
    index = "elastic-cloud-logs-*"

    query_string = "event.action:rule_enable AND @timestamp:[now-7d TO now]"

    aggs = {
      per_rule_id = {
        "terms": {"field": "kibana.saved_object.id"}
      }
    }
    only_hits = false
    size = 0
  }

  # Detection rules failed in a current period
  data elasticsearch "rule_failures_curr" {
    index = "elastic-cloud-logs-*"

    query_string = <<-EOT
      rule.id:*
      AND @timestamp:[now-7d TO now]
      AND NOT rule.execution.status:running
      AND NOT rule.execution.status:success
    EOT

    aggs = {
      per_rule_name = {
        "terms": {"field": "rule.name"}
      }
    }
    only_hits = false
    size = 0
  }

  # Fleet agents enrolled in a current period.
  # Note, we query only the agents enrolled with a specific policy.
  data elasticsearch "fleet_agents_enrolled_curr" {
    index = ".fleet-agents"

    query_string = <<-EOT
      enrolled_at:[now-7d TO now]
      AND policy_id:"${env.ELASTIC_AGENT_POLICY_ID}"
    EOT

    # We want to get a total count, no need to return docs
    only_hits = false
    size = 0
  }

  # Fleet agents enrolled in a previous period.
  # Note, we query only the agents enrolled with a specific policy.
  data elasticsearch "fleet_agents_enrolled_prev" {
    index = ".fleet-agents"

    query_string = <<-EOT
      enrolled_at:[now-14d TO now-7d]
      AND policy_id:"${env.ELASTIC_AGENT_POLICY_ID}"
    EOT

    # We want to get a total count, no need to get any docs
    only_hits = false
    size = 0
  }

  # Fleet agents that did not check in in a current period
  # Note, we query only the agents enrolled with a specific policy.
  data elasticsearch "fleet_agents_wo_checkin_curr" {
    index = ".fleet-agents"

    query_string = <<-EOT
      policy_id:"${env.ELASTIC_AGENT_POLICY_ID}"
      AND NOT last_checkin:[now-7d TO now]
    EOT

    # We want to get a total count, no need to get any docs
    only_hits = false
    size = 0
  }

  # Template-wide variables
  vars {

    # SLAs thresholds in hours per alert severity
    alert_slas_hours_per_severity = {
      low = 24
      medium = 6
      high = 3
      critical = 1
    }

    # Calculating the start of a current period
    week_start_datetime = query_jq(
      <<-EOT
        # Use the current week number and year to figure out Monday 00:00:00 datetime
        now | strftime("Monday, Week %W, Year %Y, 00:00:00") | strptime("%A, Week %W, Year %Y, %H:%M:%S") | todateiso8601
      EOT
    )

    # Calculating the end of a current period
    week_end_datetime = query_jq(
      <<-EOT
        # Use the current week number and year to figure out Sunday 23:59:59 datetime
        now | strftime("Sunday, Week %W, Year %Y, 23:59:59") | strptime("%A, Week %W, Year %Y, %H:%M:%S") | todateiso8601
      EOT
    )

    # Analyst shifts for the week.
    # Shift pattern is 12h shifts, 2 days on / 2 days off, 2 people per shift
    # The shift boundaries are in the format of "%a, %H:%M"
    analyst_shifts = {
      "Dion Ballard": [
        ["Mon, 00:00", "Mon, 12:00"],
        ["Tue, 00:00", "Tue, 12:00"],
        ["Fri, 00:00", "Fri, 12:00"],
        ["Sat, 00:00", "Sat, 12:00"],
      ]
      "Elnora Hebert": [
        ["Mon, 00:00", "Mon, 12:00"],
        ["Tue, 00:00", "Tue, 12:00"],
        ["Fri, 00:00", "Fri, 12:00"],
        ["Sat, 00:00", "Sat, 12:00"],
      ]
      "Dane Harding": [
        ["Mon, 12:00", "Mon, 23:59"],
        ["Tue, 12:00", "Tue, 23:59"],
        ["Fri, 12:00", "Fri, 23:59"],
        ["Sat, 12:00", "Sat, 23:59"],
      ]
      "Steve Acosta": [
        ["Mon, 12:00", "Mon, 23:59"],
        ["Tue, 12:00", "Tue, 23:59"],
        # Steve was sick on Fri and Sat
        # ["Fri, 12:00", "Fri, 23:59"],
        # ["Sat, 12:00", "Sat, 23:59"],
      ]
      "Gerard Harrison": [
        ["Wed, 00:00", "Wed, 12:00"],
        ["Thu, 00:00", "Thu, 12:00"],
        ["Sun, 00:00", "Sun, 12:00"],
      ]
      "Marlene Shaffer": [
        ["Wed, 00:00", "Wed, 12:00"],
        ["Thu, 00:00", "Thu, 12:00"],
        ["Sun, 00:00", "Sun, 12:00"],
      ]
      "Minerva Stout": [
        ["Wed, 12:00", "Wed, 23:59"],
        ["Thu, 12:00", "Thu, 23:59"],
        ["Sun, 12:00", "Sun, 23:59"],
      ]
      "Clark Wilson": [
        ["Wed, 12:00", "Wed, 23:59"],
        ["Thu, 12:00", "Thu, 23:59"],
        ["Sun, 12:00", "Sun, 23:59"],
      ]
    }
  }

  # ================== THE REPORT BODY ======================

  title = "SOC Weekly Activity Overview"

  content text {

    value = <<-EOT
      As part of our ongoing commitment to transparency and collaboration, we are sharing the weekly overview report
      for the Security Operations Center (SOC) activities for the week between
      {{ toDate "2006-01-02T15:04:05Z" .vars.week_start_datetime | date "Mon, Jan 02, 2006 15:04:05 MST" }} and
      {{ toDate "2006-01-02T15:04:05Z" .vars.week_end_datetime | date "Mon, Jan 02, 2006 15:04:05 MST" }}.
    EOT
  }

  section "exec_summary" {

    title = "Exec Summary"

    content llm_text {

      local_var = query_jq(
        join("\n", [
          from_file("./soc-weekly-activity-overview-elastic-security.utils.jq"),
          <<-EOQ
            gather_data_for_summarisation(
              .data.elasticsearch.alerts_curr_w_impact.hits.hits;
              .vars.alert_slas_hours_per_severity;
              .data.elasticsearch.alerts_curr.hits.hits;
              .data.elasticsearch.alerts_curr_wo_impact.aggregations.per_tag.buckets;
              .data.http.rules.data;
              .data.elasticsearch.rules_enabled_curr.aggregations.per_rule_id.buckets;
              .data.elasticsearch.rules_disabled_curr.aggregations.per_rule_id.buckets;
              .data.elasticsearch.alerts_curr_fp.aggregations.per_rule_per_severity.buckets;
              .data.elasticsearch.alerts_curr.aggregations.per_severity.buckets;
              .data.elasticsearch.alerts_prev.aggregations.per_severity.buckets;
              .vars.analyst_shifts
            )
          EOQ
        ])
      )

      prompt = <<-EOT
        As a security analyst, write an executive summary of the operational metrics for SOC for the
        current reporting period. The metrics are listed below. In the summary, prioritise metrics that
        are important for the business: the ones that increase risk and affect operational continuity.
        Do not give advice, only summarise. If there is no data, say nothing.

        Be concise and limit text to two paragraphs. Output plain text without any Markdown formatting.

        {{ .vars.local | toJson }}
      EOT
    }

    section "materialized_risk" {

      content text {
        value = <<-EOT
          {{- $r := .data.elasticsearch.alerts_curr_w_impact -}}
          There were {{ if eq $r.hits.total.relation "gte" -}} > {{- end -}}{{ $r.hits.total.value }} alerts in
          the current week with materialized risk.
        EOT
      }

      content table {

        rows = query_jq(".data.elasticsearch.alerts_curr_w_impact.aggregations.per_rule_per_severity.buckets")

        columns = [
          {
            header = "Rule Name" 
            value = "{{ index .row.value.key 0 }}"
          },
          {
            header = "Severity" 
            value = "{{ index .row.value.key 1 }}"
          },
          {
            header = "Alerts" 
            value = "{{ .row.value.doc_count }}"
          },
        ]
      }

      content llm_text {
        local_var = query_jq(
          <<-EOT
            .data.elasticsearch.alerts_curr_w_impact.hits.hits
            | map(._source)
            | map({
                "description": ."kibana.alert.rule.description",
                "name": ."kibana.alert.rule.name",
                "severity": ."kibana.alert.rule.parameters".severity,
            })
          EOT
        )

        prompt = <<-EOT
          Describe the alerts with materialized risks seen in the last week using the data
          included below. Do not give advice, only summarise the details of the alerts.
          Be concise and limit the description to a single paragraph. If there is no data,
          say nothing.

          Be concise and limit text to one paragraph. Output plain text without any Markdown formatting.

          {{ .vars.local | toJson }}
        EOT
      }
    }
  }

  section "kpis" {
    title = "KPIs"

    section "slas" {
      title = "SLA Metrics"

      content table {

        rows = query_jq(
            join("\n", [
              from_file("./soc-weekly-activity-overview-elastic-security.utils.jq"),
              "calculate_sla_metrics(.vars.alert_slas_hours_per_severity; .data.elasticsearch.alerts_curr.hits.hits)"
            ]
          )
        )

        columns = [
          {
            header = "Severity" 
            value = "{{ .row.value.severity }}"
          },
          {
            header = "Alerts" 
            value = <<-EOT
              {{- with .row.value.metrics -}}
                {{ add .in_sla .out_sla }}
              {{- else -}}
                -
              {{- end -}}
            EOT 
          },
          {
            header = "Limit" 
            value = "<= {{ .row.value.max_hours }}h"
          },
          {
            header = "SLA met / not met" 
            value = <<-EOT
              {{- with .row.value.metrics -}}
                {{ .in_sla }} / {{ .out_sla }}
              {{- else -}}
                -
              {{- end -}}
            EOT
          },
          {
            header = "% met" 
            value = <<-EOT
              {{- with .row.value.metrics -}}
                {{ round (mul (div .in_sla (max 1 (add .in_sla .out_sla))) 100) 2 }}%
              {{- else -}}
                -
              {{- end -}}
            EOT 
          },
          {
            header = "TimeToRespond" 
            value = <<-EOT
              {{- with .row.value.time_to_respond_hours -}}
                Median: {{ round .median 2 }}h<br/>
                Max: {{ round .max 2 }}h
              {{- else -}}
              {{- end -}}
            EOT 
          },
        ]
      }
    }

    section "true_false_positives" {
      title = "True / False Positives resolved before risk materialization"

      content text {
        local_var = query_jq(
          <<-EOT
            .data.elasticsearch.alerts_curr_wo_impact.aggregations.per_tag.buckets as $agg_buckets
            | {
               "true_positives_count": ([($agg_buckets[] | select(.key == "True Positive"))][0].doc_count // 0),
               "false_positives_count": ([($agg_buckets[] | select(.key == "False Positive"))][0].doc_count // 0),
              }
            | .percentage = (
              if .false_positives_count > 0 then 
                ((.false_positives_count / (.true_positives_count + .false_positives_count) * 100) | floor)
              else
                0
              end)
          EOT
        )

        value = <<-EOT
          - *True Positives*: {{ default 0 .vars.local.true_positives_count }} 
          - *False Positives*: {{ default 0 .vars.local.false_positives_count }}
          - *FP %*: {{ .vars.local.percentage }}%
        EOT
      }
    }

    section "env_state" {
      title = "Estate coverage"

      
      section "fleet" {
        title = "Fleet agents"

        content text {
          value = <<-EOT
            {{- $r := .data.elasticsearch.fleet_agents_enrolled_curr -}}
            {{- $m := .data.elasticsearch.fleet_agents_wo_checkin_curr -}}

            *New agents enrolled in the current week*: {{ if eq $r.hits.total.relation "gte" -}} > {{- end -}}{{ $r.hits.total.value }} (previous week: {{ if eq $r.hits.total.relation "gte" -}} > {{- end -}}{{ $r.hits.total.value }})

            *Agents that missed their check-in*: {{ if eq $m.hits.total.relation "gte" -}} > {{- end -}}{{ $m.hits.total.value }}
          EOT
        }
      }
      
      section "detection_rules" {
        title = "Detection rules"

        content text {

          local_var = query_jq(
            <<-EOT
              .data.http.rules.data as $rules
              | ($rules | map({(.id): .name}) | add) as $rules_map
              | {
                "enabled_rules_curr": (
                  (.data.elasticsearch.rules_enabled_curr.aggregations.per_rule_id.buckets // []) | map($rules_map[.key])
                ),
                "disabled_rules_curr": (
                  (.data.elasticsearch.rules_disabled_curr.aggregations.per_rule_id.buckets // []) | map($rules_map[.key])
                ),
                "overall_enabled": ($rules | map(select(.enabled == true)) | length),
              }
            EOT
          )

          value = <<-EOT
            Rule status changes in the current week:

            *Changed to Enabled* ({{ len .vars.local.enabled_rules_curr }}):
            {{ range .vars.local.enabled_rules_curr -}}
            - {{ . }}
            {{ end }}
            *Changed to Disabled* ({{ len .vars.local.disabled_rules_curr }}):
            {{ range .vars.local.disabled_rules_curr -}}
            - {{ . }}
            {{ end }}
            *Overall enabled rules*: {{ .vars.local.overall_enabled }}
          EOT
        }
      }
    }
  }

  section "rule_performance" {
    title = "Rule Performance"

    content text {
      value = <<-EOT
        {{ with .data.elasticsearch.alerts_curr_fp.aggregations.per_rule_per_severity.buckets }}

        The rules producing the most FP alerts:

        {{ range (slice . 0 5) }}
        - **{{ index .key 0 }}** ({{ index .key 1 }} severity): {{ .doc_count }} alerts
        {{ end }}
        {{- else -}}
        No rules produced FP alerts.
        {{ end -}}

        {{- with .data.elasticsearch.rule_failures_curr.aggregations.per_rule_name.buckets }}
        Rules failing the most:

        {{ range (slice . 0 5) }}
        - **{{ .key }}**: {{ .doc_count }} failures
        {{- end }}
        {{- else -}}
        No rules failed in the current period.
        {{ end }}
      EOT
    }
  }

  section "analytical_load" {
    title = "Analytical Load"

    section "alerts_overview" {
      title = "Alerts Overview"

      content text {
        local_var = query_jq(".data.elasticsearch.alerts_curr.aggregations.per_severity.buckets | map(.doc_count) | add")
        value = "{{ .vars.local }} alerts were created last week."
      }

      content code {
        language = "mermaid"

        value = <<-EOT
          ---
          config:
            theme: base
            themeVariables:
              xyChart:
                plotColorPalette: "#B2B2CC"
            xyChart:
              width: 900
              height: 300
              xAxis:
                labelPadding: 5
              yAxis:
                titlePadding: 10
          ---
          xychart-beta
              title "Alerts per day"
              x-axis [
                {{- $divider := "" -}}
                {{- range .data.elasticsearch.alerts_curr.aggregations.per_day.buckets -}}
                  {{ $divider }} {{ substr 0 10 .key_as_string }} {{- $divider = "," -}}
                {{- end -}}
              ]
              y-axis "Alerts"
              bar [
                {{- $divider := "" -}}
                {{- range .data.elasticsearch.alerts_curr.aggregations.per_day.buckets -}}
                  {{ $divider }} {{ .doc_count }} {{- $divider = "," -}}
                {{- end -}}
              ]
        EOT
      }

      content table {
        rows = query_jq(
          <<-EOT
            def buckets_to_map($buckets): $buckets | map({(.key): (.doc_count)}) | add;

            buckets_to_map(.data.elasticsearch.alerts_curr.aggregations.per_severity.buckets) as $curr_counts
            | buckets_to_map(.data.elasticsearch.alerts_prev.aggregations.per_severity.buckets) as $prev_counts
            | ["high", "medium", "low"] | map({
              key: .,
              curr_count: ($curr_counts[.] // 0),
              prev_count: ($prev_counts[.] // 0),
            })
          EOT
        )

        columns = [
          {
            header = "Severity" 
            value = "{{ .row.value.key }}"
          },
          {
            header = "Alerts" 
            value = "{{ .row.value.curr_count }}"
          },
          {
            header = "Alerts (week before)" 
            value = "{{ .row.value.prev_count }}"
          },
          {
            header = "Change"
            value = "{{ ceil (mulf (divf (sub .row.value.curr_count .row.value.prev_count) (default 1 .row.value.prev_count)) 100) }}%"
          },

        ]
      }

      content text {

        local_var = query_jq(
            join("\n", [
              from_file("./soc-weekly-activity-overview-elastic-security.utils.jq"),
              "calculate_time_to_respond_metrics(.data.elasticsearch.alerts_curr.hits.hits)"
            ]
          )
        )

        value = <<-EOT
          - MTTR: {{ round .vars.local.mean_time_to_respond_hours 2}}h
          - 95th percentile: {{ round .vars.local.percentile_95th_hours 2}}h
        EOT
      }
    }

    section "alerts_per_analysts" {
      title = "Alerts per on-duty analyst"

      vars {
        metrics = query_jq(
            join("\n", [
              from_file("./soc-weekly-activity-overview-elastic-security.utils.jq"),
              <<-EOT
                calculate_alerts_load_metrics(
                  .vars.week_start_datetime | fromdateiso8601;
                  .vars.week_end_datetime | fromdateiso8601;
                  .vars.analyst_shifts;
                  .data.elasticsearch.alerts_curr.aggregations.per_hour.buckets | map([.key_as_string, .doc_count])
                )
              EOT
            ])
        )
      }

      content text {
        value = <<-EOT
          - *Unattended hours*: {{ .vars.metrics.unattended_hours }}h with {{ .vars.metrics.alerts_during_unattended_hours }} alerts
          - *Dead hours without any alerts*: {{ .vars.metrics.dead_hours }}h
        EOT
      }

      content table {
        rows = query_jq(".vars.metrics.analyst_metrics")

        columns = [
          {
            header = "Analyst" 
            value = "{{ .row.value.analyst }}"
          },
          {
            header = "Shifts" 
            value = "{{ len .row.value.shifts }}"
          },
          {
            header = "Hours alone" 
            value = "{{ .row.value.hours_alone }}"
          },
          {
            header = "Avg alerts/h" 
            value = "{{ round .row.value.avg_alerts_per_hour 2 }}"
          },
        ]
      }

      content code {
        language = "mermaid"
        value = <<-EOT
          ---
          config:
            theme: base
            themeVariables:
              primaryColor: "#B2B2CC"
              font-size: 8
          ---
          gantt
              title Week between {{ .vars.metrics.week_start }} and {{ .vars.metrics.week_end }}
              weekday Monday
              tickInterval 1d
              todayMarker off
              dateFormat YYYY-MM-DDTHH:mm
              axisFormat %a, %H
              {{ range .vars.metrics.analyst_metrics }}
              section {{ .analyst -}}
                {{ range .shifts }}
                  shift          :, {{ index . 0 }},{{ index . 1 }}
                {{- end }}
              {{- end }}
        EOT
      }
    }
  }

  section "footer" {
    title = "Feedback"

    content text {
      value = "Feel free to reach out if you have any specific questions or require additional information regarding the provided report."
    }

  }

  # Frontmatter for Pandoc
  format md {
    frontmatter = {
      format = "yaml"
      content = {
        title = "SOC Weekly Activity Overview"
        author = ["Clark Wilson, SOC team"]
        date = "2024-08-08"
      }
    }
  }

}
