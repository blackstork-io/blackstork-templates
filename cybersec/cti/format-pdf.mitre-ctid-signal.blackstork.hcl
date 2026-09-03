format pdf "mitre_ctid_signal" {
  meta {
    name        = "MITRE CTI Blueprint PDF Format — Signal"
    description = "A warm editorial A4 landscape PDF format for professional cyber threat intelligence reports."
    license     = "Apache License 2.0"
    authors     = ["Sergey Polzunov <sergey@blackstork.io>"]
    tags        = ["mitre", "ctid", "pdf", "signal", "threat-intelligence"]
    updated_at  = "2026-09-03T00:00:00Z"
  }

  page_size             = "A4 landscape"
  page_margins          = "17mm 16mm 18mm 16mm"
  page_background_color = "#ffffff"

  page_number_in_footer_center = false
  page_number_in_footer_right  = false

  header_left = <<-HTML
    <div style="font-family: Georgia, 'Times New Roman', serif; color: #482536; font-size: 8pt; font-weight: 700; letter-spacing: 0.06em; line-height: 1; text-transform: uppercase; white-space: nowrap;">
      {{ .vars.report_metadata.producer_name }} <span style="color: #bd4b32; padding: 0 5pt;">/</span> {{ .vars.report_metadata.producer_unit }}
    </div>
  HTML

  header_right = <<-HTML
    <div style="font-family: Consolas, 'Liberation Mono', monospace; color: #71685f; font-size: 7pt; font-weight: 600; letter-spacing: 0.08em; line-height: 1; text-transform: uppercase; white-space: nowrap;">
      {{ .vars.report.handling }} <span style="color: #d9cfc1; padding: 0 5pt;">·</span> {{ .vars.report.probability_label }}
    </div>
  HTML

  footer_left = <<-HTML
    <div class="ctid-running-title" style="font-family: Georgia, 'Times New Roman', serif; color: #71685f; font-size: 7pt; font-weight: 500; letter-spacing: 0.03em; line-height: 1; white-space: nowrap;"></div>
  HTML

  footer_center = <<-HTML
    <div style="font-family: Consolas, 'Liberation Mono', monospace; color: #8d8177; font-size: 6.5pt; letter-spacing: 0.06em; line-height: 1; text-transform: uppercase; white-space: nowrap;">
      {{ .vars.report_metadata.producer_name }} · {{ .vars.report.handling }}
    </div>
  HTML

  footer_right = <<-HTML
    <div style="font-family: Consolas, 'Liberation Mono', monospace; color: #482536; font-size: 7pt; font-weight: 600; letter-spacing: 0.05em; line-height: 1; white-space: nowrap;">
      PAGE <span class="ctid-page-number"></span>
    </div>
  HTML

  cover_page_css = <<-CSS
    background-color: #f6f0e7;
  CSS

  cover_page_content = <<-HTML
    <div style="position: relative; display: flex; flex-direction: column; width: 100%; height: 100%; padding: 22mm 24mm 20mm 30mm; overflow: hidden; background: #f6f0e7; color: #292521; box-sizing: border-box; font-family: 'Segoe UI', Arial, sans-serif;">
      <div style="position: absolute; inset: 0 auto 0 0; width: 9mm; background: #482536;"></div>
      <div style="position: absolute; top: -42mm; right: -18mm; width: 125mm; height: 125mm; border: 1px solid rgba(189, 75, 50, 0.25); border-radius: 50%;"></div>
      <div style="position: absolute; top: 10mm; right: 22mm; width: 58mm; height: 58mm; border: 1px solid rgba(72, 37, 54, 0.18); border-radius: 50%;"></div>
      <div style="position: absolute; right: 42mm; bottom: 28mm; width: 3.2mm; height: 3.2mm; border-radius: 50%; background: #bd4b32;"></div>

      <div style="display: flex; align-items: center; gap: 9pt; position: relative; z-index: 1;">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" style="width: 23pt; height: 23pt; flex: 0 0 auto; color: #bd4b32;">
          <path stroke-linecap="round" stroke-linejoin="round" d="M12 21a9.004 9.004 0 0 0 8.716-6.747M12 21a9.004 9.004 0 0 1-8.716-6.747M12 21c2.485 0 4.5-4.03 4.5-9S14.485 3 12 3m0 18c-2.485 0-4.5-4.03-4.5-9S9.515 3 12 3m0 0a8.997 8.997 0 0 1 7.843 4.582M12 3a8.997 8.997 0 0 0-7.843 4.582m15.686 0A11.953 11.953 0 0 1 12 10.5c-2.998 0-5.74-1.1-7.843-2.918m15.686 0A8.959 8.959 0 0 1 21 12c0 .778-.099 1.533-.284 2.253m0 0A17.919 17.919 0 0 1 12 16.5c-3.162 0-6.133-.815-8.716-2.247m0 0A9.015 9.015 0 0 1 3 12c0-1.605.42-3.113 1.157-4.418" />
        </svg>
        <div style="color: #482536; font-family: Georgia, 'Times New Roman', serif; font-size: 13pt; font-weight: 700; letter-spacing: 0.09em; text-transform: uppercase;">{{ .vars.report_metadata.producer_name }}</div>
      </div>

      <div style="position: relative; z-index: 1; max-width: 220mm; margin-top: 30mm;">
        <div style="margin-bottom: 10pt; color: #bd4b32; font-family: Consolas, 'Liberation Mono', monospace; font-size: 8pt; font-weight: 600; letter-spacing: 0.14em; text-transform: uppercase;">
          {{ .vars.report_metadata.producer_unit }} · {{ .vars.report_metadata.product_type }}
        </div>
        <h1 style="max-width: 225mm; margin: 0; padding: 0; border: 0; color: #482536; font-family: Georgia, 'Times New Roman', serif; font-size: 36pt; font-weight: 500; letter-spacing: -0.025em; line-height: 1.05;">
          {{ .vars.report.title }}
        </h1>
        <div style="width: 32mm; height: 2.5pt; margin-top: 17pt; background: #bd4b32;"></div>
        <p style="max-width: 205mm; margin: 17pt 0 0; color: #71685f; font-size: 11pt; line-height: 1.45;">
          {{ .vars.report.subject }}
        </p>
      </div>

      <div style="flex-grow: 1;"></div>

      <table style="position: relative; z-index: 1; width: 100%; margin: 0; border: 0; border-top: 1px solid #cbbdac; border-collapse: collapse; color: #292521; box-shadow: none; background: transparent;">
        <tr>
          <td style="width: 14%; padding: 11pt 20pt 5pt 0; border: 0; background: transparent; color: #8d8177; font-family: Consolas, 'Liberation Mono', monospace; font-size: 6.5pt; font-weight: 600; letter-spacing: 0.09em; text-transform: uppercase;">Audience</td>
          <td style="width: 43%; padding: 11pt 20pt 5pt 0; border: 0; background: transparent; color: #292521; font-size: 9pt; font-weight: 500;">{{ .vars.report.audience }}</td>
          <td style="width: 14%; padding: 11pt 20pt 5pt 0; border: 0; background: transparent; color: #8d8177; font-family: Consolas, 'Liberation Mono', monospace; font-size: 6.5pt; font-weight: 600; letter-spacing: 0.09em; text-transform: uppercase;">Assessment</td>
          <td style="width: 29%; padding: 11pt 0 5pt; border: 0; background: transparent; color: #bd4b32; font-size: 9pt; font-weight: 600; text-transform: uppercase;">{{ .vars.report.probability_label }}</td>
        </tr>
        <tr>
          <td style="padding: 5pt 20pt 0 0; border: 0; background: transparent; color: #8d8177; font-family: Consolas, 'Liberation Mono', monospace; font-size: 6.5pt; font-weight: 600; letter-spacing: 0.09em; text-transform: uppercase;">Subject</td>
          <td style="padding: 5pt 20pt 0 0; border: 0; background: transparent; color: #292521; font-size: 9pt; font-weight: 500;">{{ .vars.report.subject }}</td>
          <td style="padding: 5pt 20pt 0 0; border: 0; background: transparent; color: #8d8177; font-family: Consolas, 'Liberation Mono', monospace; font-size: 6.5pt; font-weight: 600; letter-spacing: 0.09em; text-transform: uppercase;">Handling</td>
          <td style="padding: 5pt 0 0; border: 0; background: transparent; color: #292521; font-size: 9pt; font-weight: 500;">{{ .vars.report_metadata.producer_name }} · {{ .vars.report.handling }}</td>
        </tr>
      </table>
    </div>
  HTML

  document_css = <<-CSS
    .pdf-cover {
      width: 297mm !important;
      height: 210mm !important;
      min-height: 210mm !important;
      background: #f6f0e7 !important;
    }
    .pdf-cover > div {
      width: 100% !important;
      height: 100% !important;
      min-height: 100% !important;
    }

    .ctid-report {
      width: 100% !important;
      margin: 0 !important;
      padding-top: 10px;
      padding-bottom: 10px;
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
      color: #292521 !important;
      font-family: "Segoe UI", Arial, sans-serif !important;
      font-size: 8.7pt !important;
      line-height: 1.47 !important;
    }
    section { margin: 18pt 0 0 !important; }
    section section { margin-top: 12pt !important; }
    h2 {
      margin: 0 0 10pt !important;
      padding: 0 0 5pt !important;
      border-bottom: 0.7pt solid #d9cfc1 !important;
      color: #482536 !important;
      font-family: Georgia, "Times New Roman", serif !important;
      font-size: 15pt !important;
      font-weight: 600 !important;
      letter-spacing: -0.01em !important;
      string-set: section-title content();
    }
    h3 { margin: 0 0 6pt !important; color: #482536 !important; font-family: Georgia, "Times New Roman", serif !important; font-size: 10.5pt !important; font-weight: 600 !important; }
    h4 { margin: 0 0 5pt !important; color: #482536 !important; font-family: Georgia, "Times New Roman", serif !important; font-size: 9.5pt !important; font-weight: 600 !important; }
    p { margin: 0 0 8pt !important; }
    a { color: #bd4b32 !important; text-decoration: none !important; }
    code { font-size: 7.2pt !important; }
    ul, ol { margin: 0 0 9pt !important; padding-left: 15pt !important; }
    li { margin: 3pt 0 !important; padding-left: 1pt !important; }

    .ctid-bluf {
      margin-top: 0 !important;
      padding: 13pt 15pt 10pt !important;
      border-left: 3pt solid #bd4b32 !important;
      background: #faeee7 !important;
      break-inside: avoid !important;
      page-break-inside: avoid !important;
    }
    .ctid-bluf h2 { margin-bottom: 7pt !important; padding: 0 !important; border: 0 !important; font-size: 12pt !important; }
    .ctid-key-points { break-inside: avoid !important; page-break-inside: avoid !important; }
    .ctid-key-points ul { display: grid !important; grid-template-columns: 1fr 1fr !important; padding: 0 !important; }
    .ctid-key-points li { min-height: 0 !important; padding: 7pt 9pt !important; }
    .ctid-probability { padding: 12pt !important; break-inside: avoid !important; page-break-inside: avoid !important; }

    .ctid-table-wrap {
      width: 100% !important;
      margin: 9pt 0 13pt !important;
      overflow: visible !important;
      border: 0.6pt solid #d9cfc1 !important;
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
      background: #f1e9df !important;
      color: #5b403d !important;
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
      color: #292521 !important;
      font-size: 7.1pt !important;
      text-align: left !important;
      vertical-align: top !important;
    }
    tbody tr:nth-child(even) td { background: #fbf7f1 !important; }
    .ctid-probability td { color: #8b651d !important; font-size: 10pt !important; text-align: center !important; }
    .ctid-metadata table { width: 68% !important; }
    .ctid-metadata td:first-child { width: 31% !important; background: #f6f1e8 !important; }

    .ctid-sources { color: #71685f !important; font-size: 7.8pt !important; }
    .ctid-sources h2 { font-size: 11pt !important; }

    .pdf-running-element { margin: 0 !important; padding: 0 !important; line-height: 1 !important; }
    .ctid-running-title::after { content: string(section-title); }
    .ctid-page-number::after { content: counter(page); }
  CSS
}
