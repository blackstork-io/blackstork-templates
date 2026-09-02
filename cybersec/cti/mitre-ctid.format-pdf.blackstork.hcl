format pdf "ctid_mitre" {
  meta {
    name        = "MITRE CTI Blueprint PDF Format"
    description = "An A4 landscape PDF format for professional cyber threat intelligence reports."
    license     = "Apache License 2.0"
    authors     = ["Sergey Polzunov <sergey@blackstork.io>"]
    tags        = ["mitre", "ctid", "pdf", "threat-intelligence"]
    updated_at  = "2026-09-02T00:00:00Z"
  }

  # Damask uses this HTML format as the semantic and visual base before Paged.js
  # applies the print-specific rules below.
  html_format = "ctid_mitre"

  page_size             = "A4 landscape"
  page_margins          = "17mm 16mm 18mm 16mm"
  page_background_color = "#ffffff"

  page_number_in_footer_center = false
  page_number_in_footer_right  = false

  header_left = <<-HTML
    <div style="font-family: 'Segoe UI', Arial, sans-serif; color: #102a43; font-size: 7.5pt; font-weight: 700; letter-spacing: 0.09em; line-height: 1; text-transform: uppercase; white-space: nowrap;">
      {{ .vars.report_metadata.producer_name }} <span style="color: #007f82; padding: 0 5pt;">/</span> {{ .vars.report_metadata.producer_unit }}
    </div>
  HTML

  header_right = <<-HTML
    <div style="font-family: Consolas, 'Liberation Mono', monospace; color: #627586; font-size: 7pt; font-weight: 600; letter-spacing: 0.08em; line-height: 1; text-transform: uppercase; white-space: nowrap;">
      {{ .vars.report_metadata.handling }} <span style="color: #b9c6d0; padding: 0 5pt;">·</span> {{ .vars.report.probability_label }}
    </div>
  HTML

  footer_left = <<-HTML
    <div class="ctid-running-title" style="font-family: 'Segoe UI', Arial, sans-serif; color: #627586; font-size: 7pt; font-weight: 500; letter-spacing: 0.04em; line-height: 1; white-space: nowrap;"></div>
  HTML

  footer_center = <<-HTML
    <div style="font-family: Consolas, 'Liberation Mono', monospace; color: #8a9aa7; font-size: 6.5pt; letter-spacing: 0.06em; line-height: 1; text-transform: uppercase; white-space: nowrap;">
      {{ .vars.report_metadata.producer_name }} · {{ .vars.report_metadata.handling }}
    </div>
  HTML

  footer_right = <<-HTML
    <div style="font-family: Consolas, 'Liberation Mono', monospace; color: #102a43; font-size: 7pt; font-weight: 600; letter-spacing: 0.05em; line-height: 1; white-space: nowrap;">
      PAGE <span class="ctid-page-number"></span>
    </div>
  HTML

  cover_page_css = <<-CSS
    background-color: #071826;
  CSS

  cover_page_content = <<-HTML
    <div style="position: relative; display: flex; flex-direction: column; width: 100%; height: 100%; padding: 22mm 24mm 20mm; overflow: hidden; background: #071826; color: #ffffff; box-sizing: border-box; font-family: 'Segoe UI', Arial, sans-serif;">
      <div style="position: absolute; top: -35mm; right: -22mm; width: 120mm; height: 120mm; border: 1px solid rgba(124, 224, 220, 0.22); border-radius: 50%;"></div>
      <div style="position: absolute; top: 5mm; right: 18mm; width: 62mm; height: 62mm; border: 1px solid rgba(124, 224, 220, 0.16); border-radius: 50%;"></div>
      <div style="position: absolute; right: 42mm; bottom: 28mm; width: 3.2mm; height: 3.2mm; border-radius: 50%; background: #7ce0dc;"></div>

      <div style="display: flex; align-items: center; gap: 9pt; position: relative; z-index: 1;">
        <div style="position: relative; width: 23pt; height: 23pt; border: 1.5pt solid #7ce0dc; border-radius: 50%;">
          <div style="position: absolute; width: 1.5pt; height: 30pt; left: 9pt; top: -4pt; background: #7ce0dc; transform: rotate(45deg);"></div>
          <div style="position: absolute; width: 5pt; height: 5pt; right: -1pt; top: 1pt; border-radius: 50%; background: #7ce0dc;"></div>
        </div>
        <div style="font-size: 12pt; font-weight: 700; letter-spacing: 0.12em; text-transform: uppercase;">{{ .vars.report_metadata.producer_name }}</div>
      </div>

      <div style="position: relative; z-index: 1; max-width: 220mm; margin-top: 30mm;">
        <div style="margin-bottom: 10pt; color: #7ce0dc; font-family: Consolas, 'Liberation Mono', monospace; font-size: 8pt; font-weight: 600; letter-spacing: 0.14em; text-transform: uppercase;">
          {{ .vars.report_metadata.producer_unit }} · {{ .vars.report_metadata.product_type }}
        </div>
        <h1 style="max-width: 225mm; margin: 0; padding: 0; border: 0; color: #ffffff; font-size: 34pt; font-weight: 600; letter-spacing: -0.025em; line-height: 1.08;">
          {{ .vars.report.title }}
        </h1>
        <div style="width: 32mm; height: 2.5pt; margin-top: 17pt; background: #00a6a6;"></div>
        <p style="max-width: 205mm; margin: 17pt 0 0; color: #c5d3dc; font-size: 11pt; line-height: 1.45;">
          {{ .vars.report.subject }}
        </p>
      </div>

      <div style="flex-grow: 1;"></div>

      <table style="position: relative; z-index: 1; width: 100%; margin: 0; border: 0; border-top: 1px solid #365063; border-collapse: collapse; color: #ffffff; box-shadow: none; background: transparent;">
        <tr>
          <td style="width: 14%; padding: 11pt 20pt 5pt 0; border: 0; background: transparent; color: #8fa5b4; font-family: Consolas, 'Liberation Mono', monospace; font-size: 6.5pt; font-weight: 600; letter-spacing: 0.09em; text-transform: uppercase;">Audience</td>
          <td style="width: 43%; padding: 11pt 20pt 5pt 0; border: 0; background: transparent; color: #ffffff; font-size: 9pt; font-weight: 500;">{{ .vars.report.audience }}</td>
          <td style="width: 14%; padding: 11pt 20pt 5pt 0; border: 0; background: transparent; color: #8fa5b4; font-family: Consolas, 'Liberation Mono', monospace; font-size: 6.5pt; font-weight: 600; letter-spacing: 0.09em; text-transform: uppercase;">Assessment</td>
          <td style="width: 29%; padding: 11pt 0 5pt; border: 0; background: transparent; color: #7ce0dc; font-size: 9pt; font-weight: 600; text-transform: uppercase;">{{ .vars.report.probability_label }}</td>
        </tr>
        <tr>
          <td style="padding: 5pt 20pt 0 0; border: 0; background: transparent; color: #8fa5b4; font-family: Consolas, 'Liberation Mono', monospace; font-size: 6.5pt; font-weight: 600; letter-spacing: 0.09em; text-transform: uppercase;">Subject</td>
          <td style="padding: 5pt 20pt 0 0; border: 0; background: transparent; color: #ffffff; font-size: 9pt; font-weight: 500;">{{ .vars.report.subject }}</td>
          <td style="padding: 5pt 20pt 0 0; border: 0; background: transparent; color: #8fa5b4; font-family: Consolas, 'Liberation Mono', monospace; font-size: 6.5pt; font-weight: 600; letter-spacing: 0.09em; text-transform: uppercase;">Handling</td>
          <td style="padding: 5pt 0 0; border: 0; background: transparent; color: #ffffff; font-size: 9pt; font-weight: 500;">{{ .vars.report_metadata.producer_name }} · {{ .vars.report_metadata.handling }}</td>
        </tr>
      </table>
    </div>
  HTML

  document_css = <<-CSS
    .ctid-report {
      width: 100% !important;
      margin: 0 !important;
      overflow: visible !important;
      border: 0 !important;
      border-radius: 0 !important;
      box-shadow: none !important;
      background: transparent !important;
    }
    .ctid-web-header,
    .ctid-web-footer,
    .ctid-hero { display: none !important; }
    .ctid-content { padding: 0 !important; }

    body {
      color: #102a43 !important;
      font-family: "Segoe UI", Arial, sans-serif !important;
      font-size: 8.7pt !important;
      line-height: 1.47 !important;
    }
    section { margin: 18pt 0 0 !important; }
    section section { margin-top: 12pt !important; }
    h2 {
      margin: 0 0 10pt !important;
      padding: 0 0 5pt !important;
      border-bottom: 0.7pt solid #d7e0e7 !important;
      color: #071826 !important;
      font-size: 15pt !important;
      font-weight: 600 !important;
      letter-spacing: -0.01em !important;
      string-set: section-title content();
    }
    h3 { margin: 0 0 6pt !important; color: #102a43 !important; font-size: 10.5pt !important; font-weight: 600 !important; }
    h4 { margin: 0 0 5pt !important; color: #102a43 !important; font-size: 9.5pt !important; font-weight: 600 !important; }
    p { margin: 0 0 8pt !important; }
    a { color: #007f82 !important; text-decoration: none !important; }
    code { font-size: 7.2pt !important; }
    ul, ol { margin: 0 0 9pt !important; padding-left: 15pt !important; }
    li { margin: 3pt 0 !important; padding-left: 1pt !important; }

    .ctid-bluf {
      margin-top: 0 !important;
      padding: 13pt 15pt 10pt !important;
      border-left: 3pt solid #007f82 !important;
      background: #e8f5f4 !important;
      break-inside: avoid !important;
      page-break-inside: avoid !important;
    }
    .ctid-bluf h2 { margin-bottom: 7pt !important; padding: 0 !important; border: 0 !important; font-size: 12pt !important; }
    .ctid-key-points { break-inside: avoid !important; page-break-inside: avoid !important; }
    .ctid-key-points ul { display: grid !important; grid-template-columns: 1fr 1fr !important; padding: 0 !important; }
    .ctid-key-points li { min-height: 0 !important; padding: 7pt 9pt !important; }
    .ctid-probability { padding: 12pt !important; break-inside: avoid !important; page-break-inside: avoid !important; }

    .ctid-data-section {
      break-before: page !important;
      page-break-before: always !important;
    }
    .ctid-data-section section:first-child { margin-top: 0 !important; }

    .ctid-table-wrap {
      width: 100% !important;
      margin: 9pt 0 13pt !important;
      overflow: visible !important;
      border: 0.6pt solid #d7e0e7 !important;
      border-radius: 0 !important;
      break-inside: auto !important;
      page-break-inside: auto !important;
    }
    table {
      width: 100% !important;
      min-width: 0 !important;
      margin: 0 !important;
      border: 0 !important;
      border-collapse: collapse !important;
      font-size: 7.1pt !important;
      line-height: 1.28 !important;
      break-inside: auto !important;
      page-break-inside: auto !important;
      box-shadow: none !important;
    }
    thead { display: table-header-group !important; }
    tfoot { display: table-footer-group !important; }
    tr { break-inside: avoid !important; page-break-inside: avoid !important; }
    th {
      padding: 5.5pt 5pt !important;
      border-bottom: 0.8pt solid #9fb0bc !important;
      background: #e9eff3 !important;
      color: #304b5f !important;
      font-family: Consolas, "Liberation Mono", monospace !important;
      font-size: 6.2pt !important;
      font-weight: 600 !important;
      letter-spacing: 0.025em !important;
      text-align: left !important;
      text-transform: uppercase !important;
      white-space: normal !important;
    }
    td {
      padding: 5.5pt 5pt !important;
      border-bottom: 0.5pt solid #dfe6eb !important;
      background: #ffffff !important;
      color: #102a43 !important;
      font-size: 7.1pt !important;
      text-align: left !important;
      vertical-align: top !important;
    }
    tbody tr:nth-child(even) td { background: #f8fafb !important; }
    .ctid-probability td { color: #9a681a !important; font-size: 10pt !important; text-align: center !important; }
    .ctid-metadata table { width: 68% !important; }
    .ctid-metadata td:first-child { width: 31% !important; background: #f3f6f8 !important; }

    .ctid-sources { color: #627586 !important; font-size: 7.8pt !important; }
    .ctid-sources h2 { font-size: 11pt !important; }

    .pdf-running-element { margin: 0 !important; padding: 0 !important; line-height: 1 !important; }
    .ctid-running-title::after { content: string(section-title); }
    .ctid-page-number::after { content: counter(page); }
  CSS
}
