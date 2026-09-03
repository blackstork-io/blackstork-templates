format html "mitre_ctid_signal" {
  meta {
    name        = "MITRE CTI Blueprint HTML Format — Signal"
    description = "A warm editorial web format for decision-oriented cyber threat intelligence reports."
    license     = "Apache License 2.0"
    authors     = ["Sergey Polzunov <sergey@blackstork.io>"]
    tags        = ["mitre", "ctid", "html", "signal", "threat-intelligence"]
    updated_at  = "2026-09-03T00:00:00Z"
  }

  css_inline = <<-CSS
    :root {
      --ctid-ink: #292521;
      --ctid-navy: #482536;
      --ctid-teal: #bd4b32;
      --ctid-teal-soft: #faeee7;
      --ctid-amber: #8b651d;
      --ctid-amber-soft: #fbf3dd;
      --ctid-paper: #fffdf8;
      --ctid-canvas: #e9e3d9;
      --ctid-subtle: #f6f1e8;
      --ctid-line: #d9cfc1;
      --ctid-muted: #71685f;
      --ctid-sans: -apple-system, BlinkMacSystemFont, "Segoe UI", Arial, sans-serif;
      --ctid-mono: "SFMono-Regular", Consolas, "Liberation Mono", monospace;
    }

    * { box-sizing: border-box; }
    html { scroll-behavior: smooth; }
    body {
      margin: 0;
      background: var(--ctid-canvas);
      color: var(--ctid-ink);
      font-family: var(--ctid-sans);
      font-size: 16px;
      line-height: 1.62;
      -webkit-font-smoothing: antialiased;
    }

    .ctid-report {
      width: min(1180px, calc(100% - 40px));
      margin: 32px auto;
      overflow: hidden;
      background: var(--ctid-paper);
      border: 1px solid var(--ctid-line);
      border-radius: 2px;
      box-shadow: 0 18px 50px rgb(72 37 54 / 0.10);
    }

    .ctid-web-header,
    .ctid-web-footer {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 24px;
      background: var(--ctid-paper);
      border-top: 6px solid var(--ctid-navy);
      border-bottom: 1px solid var(--ctid-line);
      color: #fff;
      padding: 18px 52px;
    }
    .ctid-wordmark { display: flex; align-items: center; gap: 12px; }
    .ctid-mark {
      width: 30px;
      height: 30px;
      flex: 0 0 auto;
      color: var(--ctid-teal);
    }
    .ctid-name { color: var(--ctid-navy); font-family: Georgia, "Times New Roman", serif; font-size: 18px; font-weight: 700; letter-spacing: 0.035em; text-transform: uppercase; }
    .ctid-practice,
    .ctid-handling {
      color: var(--ctid-muted);
      font-family: var(--ctid-mono);
      font-size: 11px;
      font-weight: 500;
      letter-spacing: 0.1em;
      text-transform: uppercase;
    }

    .ctid-hero {
      position: relative;
      padding: 72px 52px 58px;
      border-bottom: 1px solid var(--ctid-line);
      background:
        linear-gradient(110deg, rgb(250 238 231 / 0.95), rgb(255 253 248 / 0) 65%),
        var(--ctid-paper);
    }
    .ctid-hero::after {
      position: absolute;
      left: 52px;
      bottom: -1px;
      width: 96px;
      height: 4px;
      content: "";
      background: var(--ctid-teal);
    }
    .ctid-kicker {
      margin-bottom: 18px;
      color: var(--ctid-teal);
      font-family: var(--ctid-mono);
      font-size: 12px;
      font-weight: 600;
      letter-spacing: 0.12em;
      text-transform: uppercase;
    }
    .ctid-hero h1 {
      max-width: 850px;
      margin: 0;
      color: var(--ctid-navy);
      font-family: Georgia, "Times New Roman", serif;
      font-size: clamp(38px, 5vw, 58px);
      font-weight: 500;
      letter-spacing: -0.025em;
      line-height: 1.04;
    }
    .ctid-hero-note { margin: 22px 0 0; color: var(--ctid-muted); font-size: 17px; }
    .ctid-hero-tags { display: flex; flex-wrap: wrap; gap: 8px; margin-top: 28px; }
    .ctid-tag {
      padding: 5px 9px;
      border: 1px solid #dfb7aa;
      border-radius: 3px;
      background: rgb(255 255 255 / 0.65);
      color: #7d3427;
      font-family: var(--ctid-mono);
      font-size: 10px;
      font-weight: 600;
      letter-spacing: 0.08em;
      text-transform: uppercase;
    }

    .ctid-content { padding: 18px 52px 64px; }
    .ctid-content > .ctid-web-header { margin: -18px -52px 0; }
    .ctid-content > .ctid-hero { margin: 0 -52px; }
    section { margin: 48px 0 0; }
    section section { margin-top: 30px; }
    h2, h3, h4 { color: var(--ctid-navy); font-family: Georgia, "Times New Roman", serif; line-height: 1.25; }
    h2 {
      margin: 0 0 22px;
      padding: 0 0 10px;
      border-bottom: 1px solid var(--ctid-line);
      font-size: 25px;
      font-weight: 500;
      letter-spacing: -0.018em;
    }
    h3 { margin: 0 0 14px; font-size: 19px; font-weight: 600; }
    h4 { margin: 0 0 10px; font-size: 16px; font-weight: 600; }
    p { margin: 0 0 18px; }
    strong { color: var(--ctid-navy); font-weight: 600; }
    a { color: var(--ctid-teal); font-weight: 500; text-decoration-thickness: 1px; text-underline-offset: 3px; }

    ul, ol { margin: 0 0 20px; padding-left: 24px; }
    li { margin: 7px 0; padding-left: 3px; }
    li::marker { color: var(--ctid-teal); font-weight: 600; }
    code {
      padding: 2px 5px;
      border: 1px solid #dce4ea;
      border-radius: 3px;
      background: var(--ctid-subtle);
      color: #274c65;
      font-family: var(--ctid-mono);
      font-size: 0.86em;
    }
    pre { overflow-x: auto; padding: 20px; background: var(--ctid-navy); color: #e7f0f5; border-radius: 5px; }
    pre code { padding: 0; border: 0; background: transparent; color: inherit; }

    .ctid-table-wrap {
      width: 100%;
      margin: 20px 0 30px;
      overflow-x: auto;
      border: 1px solid var(--ctid-line);
      border-radius: 5px;
      background: var(--ctid-paper);
    }
    table { width: 100%; border-collapse: collapse; font-size: 13px; line-height: 1.45; }
    th {
      padding: 11px 12px;
      border-bottom: 1px solid #b9c6d0;
      background: #f1e9df;
      color: #5b403d;
      font-family: var(--ctid-mono);
      font-size: 10px;
      font-weight: 600;
      letter-spacing: 0.045em;
      text-align: left;
      text-transform: uppercase;
      vertical-align: bottom;
      white-space: nowrap;
    }
    td { padding: 12px; border-bottom: 1px solid #e7ded2; text-align: left; vertical-align: top; }
    tbody tr:nth-child(even) td { background: #fcf8f2; }
    tbody tr:last-child td { border-bottom: 0; }
    .ctid-mitre-table table,
    .ctid-ioc-section table { min-width: 1040px; }

    .ctid-bluf {
      margin-top: 38px;
      padding: 26px 30px 22px;
      border-left: 5px solid var(--ctid-teal);
      background: var(--ctid-teal-soft);
    }
    .ctid-bluf h2 { margin-bottom: 15px; padding: 0; border: 0; font-size: 20px; }
    .ctid-bluf p:last-child { margin-bottom: 0; }

    .ctid-key-points ul {
      display: grid;
      grid-template-columns: repeat(2, minmax(0, 1fr));
      gap: 0;
      padding: 0;
      border-top: 1px solid var(--ctid-line);
      border-left: 1px solid var(--ctid-line);
      list-style: none;
    }
    .ctid-key-points li {
      min-height: 66px;
      margin: 0;
      padding: 15px 18px;
      border-right: 1px solid var(--ctid-line);
      border-bottom: 1px solid var(--ctid-line);
    }

    .ctid-probability { padding: 24px; border: 1px solid #ead6ad; background: var(--ctid-amber-soft); }
    .ctid-probability h2 { margin-bottom: 12px; border-color: #ead6ad; }
    .ctid-probability .ctid-table-wrap { margin-bottom: 0; border-color: #ead6ad; }
    .ctid-probability td { color: var(--ctid-amber); font-size: 18px; font-weight: 700; text-align: center; }

    .ctid-sources { color: var(--ctid-muted); font-size: 14px; }
    .ctid-sources h2 { font-size: 19px; }
    .ctid-metadata table { width: auto; min-width: min(100%, 650px); }
    .ctid-metadata td:first-child { width: 210px; background: var(--ctid-subtle); }

    .ctid-web-footer { background: var(--ctid-navy); border: 0; padding-top: 15px; padding-bottom: 15px; }
    .ctid-web-footer .ctid-handling { color: #eadde1; }
    .ctid-web-footer a { color: #f5e9dc; text-decoration: none; }

    @media (max-width: 720px) {
      .ctid-report { width: 100%; margin: 0; border: 0; border-radius: 0; }
      .ctid-web-header, .ctid-web-footer { padding: 16px 22px; }
      .ctid-practice { display: none; }
      .ctid-hero { padding: 48px 22px 40px; }
      .ctid-hero::after { left: 22px; }
      .ctid-content { padding: 8px 22px 48px; }
      .ctid-content > .ctid-web-header { margin: -8px -22px 0; }
      .ctid-content > .ctid-hero { margin: 0 -22px; }
      .ctid-key-points ul { grid-template-columns: 1fr; }
    }

    @media print {
      body { background: #fff; }
      .ctid-report { width: 100%; margin: 0; border: 0; border-radius: 0; box-shadow: none; }
    }
  CSS

  template_per_type = {
    "document" = <<-HTML
      <article class="ctid-report">
        <main class="ctid-content">{{ .content }}</main>
        <footer class="ctid-web-footer">
          <span class="ctid-handling">Cyber Threat Intelligence</span>
        </footer>
      </article>
    HTML

    "content.table" = <<-HTML
      <div class="ctid-table-wrap pdf-splittable">
        <table>
          {{ if .headers_html }}
          <thead><tr>{{ range .headers_html }}<th>{{ . }}</th>{{ end }}</tr></thead>
          {{ end }}
          <tbody>
            {{ range .rows_html }}
            <tr>{{ range . }}<td>{{ .value_html }}</td>{{ end }}</tr>
            {{ end }}
          </tbody>
        </table>
      </div>
    HTML
  }

  template_per_block = {
    "content.table.mitre_ctid_report_identity" = <<-HTML
      <header class="ctid-web-header">
        <div class="ctid-wordmark">
          <svg class="ctid-mark" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 21a9.004 9.004 0 0 0 8.716-6.747M12 21a9.004 9.004 0 0 1-8.716-6.747M12 21c2.485 0 4.5-4.03 4.5-9S14.485 3 12 3m0 18c-2.485 0-4.5-4.03-4.5-9S9.515 3 12 3m0 0a8.997 8.997 0 0 1 7.843 4.582M12 3a8.997 8.997 0 0 0-7.843 4.582m15.686 0A11.953 11.953 0 0 1 12 10.5c-2.998 0-5.74-1.1-7.843-2.918m15.686 0A8.959 8.959 0 0 1 21 12c0 .778-.099 1.533-.284 2.253m0 0A17.919 17.919 0 0 1 12 16.5c-3.162 0-6.133-.815-8.716-2.247m0 0A9.015 9.015 0 0 1 3 12c0-1.605.42-3.113 1.157-4.418" />
          </svg>
          <span class="ctid-name">{{ (index (index .rows_html 1) 1).value_html }}</span>
        </div>
        <div class="ctid-practice">{{ (index (index .rows_html 2) 1).value_html }} / {{ (index (index .rows_html 3) 1).value_html }}</div>
      </header>
      <div class="ctid-hero">
        <div class="ctid-kicker">{{ (index (index .rows_html 2) 1).value_html }} · {{ (index (index .rows_html 3) 1).value_html }}</div>
        <h1>{{ (index (index .rows_html 0) 1).value_html }}</h1>
        <p class="ctid-hero-note">{{ (index (index .rows_html 5) 1).value_html }}</p>
        <div class="ctid-hero-tags">
          <span class="ctid-tag">{{ (index (index .rows_html 4) 1).value_html }}</span>
          <span class="ctid-tag">{{ (index (index .rows_html 3) 1).value_html }}</span>
        </div>
      </div>
    HTML

    "section.mitre_ctid_executive_summary" = <<-HTML
      <section class="ctid-bluf pdf-splittable">{{ .title }}{{ .content }}</section>
    HTML

    "section.mitre_ctid_key_points" = <<-HTML
      <section class="ctid-key-points pdf-keep-together">{{ .title }}{{ .content }}</section>
    HTML

    "section.mitre_ctid_attack" = <<-HTML
      <section class="ctid-data-section ctid-mitre-table">{{ .title }}{{ .content }}</section>
    HTML

    "section.mitre_ctid_timeline_of_activity" = <<-HTML
      <section class="ctid-data-section">{{ .title }}{{ .content }}</section>
    HTML

    "section.mitre_ctid_iocs" = <<-HTML
      <section class="ctid-data-section ctid-ioc-section">{{ .title }}{{ .content }}</section>
    HTML

    "section.mitre_ctid_cves" = <<-HTML
      <section class="ctid-data-section">{{ .title }}{{ .content }}</section>
    HTML

    "section.mitre_ctid_probability_matrix" = <<-HTML
      <section class="ctid-probability pdf-keep-together">{{ .title }}{{ .content }}</section>
    HTML

    "section.mitre_ctid_data_sources" = <<-HTML
      <section class="ctid-sources">{{ .title }}{{ .content }}</section>
    HTML

    "content.table.mitre_ctid_attack" = <<-HTML
      <div class="ctid-table-wrap pdf-splittable">
        <table>
          <thead><tr>{{ range .headers_html }}<th>{{ . }}</th>{{ end }}</tr></thead>
          <tbody>{{ range .rows_html }}<tr>{{ range . }}<td>{{ .value_html }}</td>{{ end }}</tr>{{ end }}</tbody>
        </table>
      </div>
    HTML

    "content.table.mitre_ctid_metadata" = <<-HTML
      <div class="ctid-table-wrap ctid-metadata pdf-splittable">
        <table>
          <tbody>{{ range .rows_html }}<tr>{{ range . }}<td>{{ .value_html }}</td>{{ end }}</tr>{{ end }}</tbody>
        </table>
      </div>
    HTML
  }
}
