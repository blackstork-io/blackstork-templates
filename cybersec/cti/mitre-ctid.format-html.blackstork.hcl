format html "mitre_ctid_acme" {
  meta {
    name        = "Acme Corp MITRE CTI Blueprint HTML Format"
    description = "A professional web format for decision-oriented cyber threat intelligence reports."
    license     = "Apache License 2.0"
    tags        = ["mitre", "ctid", "html", "acme-corp"]
    updated_at  = "2026-09-02T00:00:00Z"
  }

  css_sources = [
    "https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;500;600&family=IBM+Plex+Sans:wght@400;500;600;700&display=swap"
  ]

  css_inline = <<-CSS
    :root {
      --acme-ink: #102a43;
      --acme-navy: #071826;
      --acme-teal: #007f82;
      --acme-teal-soft: #e8f5f4;
      --acme-amber: #b7791f;
      --acme-amber-soft: #fff8e8;
      --acme-paper: #ffffff;
      --acme-canvas: #eef2f5;
      --acme-subtle: #f6f8fa;
      --acme-line: #d7e0e7;
      --acme-muted: #627586;
      --acme-sans: "IBM Plex Sans", "Segoe UI", Arial, sans-serif;
      --acme-mono: "IBM Plex Mono", "SFMono-Regular", Consolas, monospace;
    }

    * { box-sizing: border-box; }
    html { scroll-behavior: smooth; }
    body {
      margin: 0;
      background: var(--acme-canvas);
      color: var(--acme-ink);
      font-family: var(--acme-sans);
      font-size: 16px;
      line-height: 1.62;
      -webkit-font-smoothing: antialiased;
      text-rendering: optimizeLegibility;
    }

    .acme-report {
      width: min(1180px, calc(100% - 40px));
      margin: 32px auto;
      overflow: hidden;
      background: var(--acme-paper);
      border: 1px solid var(--acme-line);
      border-radius: 10px;
      box-shadow: 0 18px 50px rgb(7 24 38 / 0.10);
    }

    .acme-web-header,
    .acme-web-footer {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 24px;
      background: var(--acme-navy);
      color: #fff;
      padding: 18px 52px;
    }
    .acme-wordmark { display: flex; align-items: center; gap: 12px; }
    .acme-mark {
      position: relative;
      width: 30px;
      height: 30px;
      border: 2px solid #7ce0dc;
      border-radius: 50%;
    }
    .acme-mark::before,
    .acme-mark::after {
      position: absolute;
      content: "";
      background: #7ce0dc;
    }
    .acme-mark::before { width: 2px; height: 38px; left: 12px; top: -6px; transform: rotate(45deg); }
    .acme-mark::after { width: 7px; height: 7px; right: -2px; top: 2px; border-radius: 50%; }
    .acme-name { font-size: 15px; font-weight: 700; letter-spacing: 0.09em; text-transform: uppercase; }
    .acme-practice,
    .acme-handling {
      color: #b8c8d3;
      font-family: var(--acme-mono);
      font-size: 11px;
      font-weight: 500;
      letter-spacing: 0.1em;
      text-transform: uppercase;
    }

    .acme-hero {
      position: relative;
      padding: 72px 52px 58px;
      border-bottom: 1px solid var(--acme-line);
      background:
        linear-gradient(90deg, rgb(232 245 244 / 0.9), rgb(255 255 255 / 0) 58%),
        var(--acme-paper);
    }
    .acme-hero::after {
      position: absolute;
      right: 52px;
      bottom: -1px;
      width: 180px;
      height: 4px;
      content: "";
      background: var(--acme-teal);
    }
    .acme-kicker {
      margin-bottom: 18px;
      color: var(--acme-teal);
      font-family: var(--acme-mono);
      font-size: 12px;
      font-weight: 600;
      letter-spacing: 0.12em;
      text-transform: uppercase;
    }
    .acme-hero h1 {
      max-width: 850px;
      margin: 0;
      color: var(--acme-navy);
      font-size: clamp(34px, 5vw, 58px);
      font-weight: 600;
      letter-spacing: -0.035em;
      line-height: 1.07;
    }
    .acme-hero-note { margin: 22px 0 0; color: var(--acme-muted); font-size: 17px; }
    .acme-hero-tags { display: flex; flex-wrap: wrap; gap: 8px; margin-top: 28px; }
    .acme-tag {
      padding: 5px 9px;
      border: 1px solid #afd7d5;
      border-radius: 3px;
      background: rgb(255 255 255 / 0.65);
      color: #155e61;
      font-family: var(--acme-mono);
      font-size: 10px;
      font-weight: 600;
      letter-spacing: 0.08em;
      text-transform: uppercase;
    }

    .acme-content { padding: 18px 52px 64px; }
    section { margin: 48px 0 0; }
    section section { margin-top: 30px; }
    h2, h3, h4 { color: var(--acme-navy); line-height: 1.25; }
    h2 {
      margin: 0 0 22px;
      padding: 0 0 10px;
      border-bottom: 1px solid var(--acme-line);
      font-size: 25px;
      font-weight: 600;
      letter-spacing: -0.018em;
    }
    h3 { margin: 0 0 14px; font-size: 19px; font-weight: 600; }
    h4 { margin: 0 0 10px; font-size: 16px; font-weight: 600; }
    p { margin: 0 0 18px; }
    strong { color: var(--acme-navy); font-weight: 600; }
    a { color: var(--acme-teal); font-weight: 500; text-decoration-thickness: 1px; text-underline-offset: 3px; }

    ul, ol { margin: 0 0 20px; padding-left: 24px; }
    li { margin: 7px 0; padding-left: 3px; }
    li::marker { color: var(--acme-teal); font-weight: 600; }
    code {
      padding: 2px 5px;
      border: 1px solid #dce4ea;
      border-radius: 3px;
      background: var(--acme-subtle);
      color: #274c65;
      font-family: var(--acme-mono);
      font-size: 0.86em;
    }
    pre { overflow-x: auto; padding: 20px; background: var(--acme-navy); color: #e7f0f5; border-radius: 5px; }
    pre code { padding: 0; border: 0; background: transparent; color: inherit; }

    .acme-table-wrap {
      width: 100%;
      margin: 20px 0 30px;
      overflow-x: auto;
      border: 1px solid var(--acme-line);
      border-radius: 5px;
      background: var(--acme-paper);
    }
    table { width: 100%; border-collapse: collapse; font-size: 13px; line-height: 1.45; }
    th {
      padding: 11px 12px;
      border-bottom: 1px solid #b9c6d0;
      background: #edf2f5;
      color: #304b5f;
      font-family: var(--acme-mono);
      font-size: 10px;
      font-weight: 600;
      letter-spacing: 0.045em;
      text-align: left;
      text-transform: uppercase;
      vertical-align: bottom;
      white-space: nowrap;
    }
    td { padding: 12px; border-bottom: 1px solid #e3e9ee; text-align: left; vertical-align: top; }
    tbody tr:nth-child(even) td { background: #fafcfd; }
    tbody tr:last-child td { border-bottom: 0; }
    tbody tr:hover td { background: var(--acme-teal-soft); }
    .acme-mitre-table table,
    .acme-ioc-section table { min-width: 1040px; }

    .acme-bluf {
      margin-top: 38px;
      padding: 26px 30px 22px;
      border-left: 5px solid var(--acme-teal);
      background: var(--acme-teal-soft);
    }
    .acme-bluf h2 { margin-bottom: 15px; padding: 0; border: 0; font-size: 20px; }
    .acme-bluf p:last-child { margin-bottom: 0; }

    .acme-key-points ul {
      display: grid;
      grid-template-columns: repeat(2, minmax(0, 1fr));
      gap: 0;
      padding: 0;
      border-top: 1px solid var(--acme-line);
      border-left: 1px solid var(--acme-line);
      list-style: none;
    }
    .acme-key-points li {
      min-height: 66px;
      margin: 0;
      padding: 15px 18px;
      border-right: 1px solid var(--acme-line);
      border-bottom: 1px solid var(--acme-line);
    }

    .acme-probability { padding: 24px; border: 1px solid #ead6ad; background: var(--acme-amber-soft); }
    .acme-probability h2 { margin-bottom: 12px; border-color: #ead6ad; }
    .acme-probability .acme-table-wrap { margin-bottom: 0; border-color: #ead6ad; }
    .acme-probability td { color: var(--acme-amber); font-size: 18px; font-weight: 700; text-align: center; }

    .acme-sources { color: var(--acme-muted); font-size: 14px; }
    .acme-sources h2 { font-size: 19px; }
    .acme-metadata table { width: auto; min-width: min(100%, 650px); }
    .acme-metadata td:first-child { width: 210px; background: var(--acme-subtle); }

    .acme-web-footer { padding-top: 15px; padding-bottom: 15px; }
    .acme-web-footer a { color: #d8e6ed; text-decoration: none; }

    @media (max-width: 720px) {
      .acme-report { width: 100%; margin: 0; border: 0; border-radius: 0; }
      .acme-web-header, .acme-web-footer { padding: 16px 22px; }
      .acme-practice { display: none; }
      .acme-hero { padding: 48px 22px 40px; }
      .acme-hero::after { right: 22px; }
      .acme-content { padding: 8px 22px 48px; }
      .acme-key-points ul { grid-template-columns: 1fr; }
    }

    @media print {
      body { background: #fff; }
      .acme-report { width: 100%; margin: 0; border: 0; border-radius: 0; box-shadow: none; }
    }
  CSS

  template_per_type = {
    "document" = <<-HTML
      <article class="acme-report">
        <header class="acme-web-header">
          <div class="acme-wordmark">
            <span class="acme-mark" aria-hidden="true"></span>
            <span class="acme-name">Acme Corp</span>
          </div>
          <div class="acme-practice">Threat Intelligence / Finished Intelligence</div>
        </header>
        <div class="acme-hero">
          <div class="acme-kicker">Acme Threat Intelligence · Intelligence Product</div>
          {{ .title }}
          <p class="acme-hero-note">Decision-grade intelligence for security leaders and defenders.</p>
          <div class="acme-hero-tags">
            <span class="acme-tag">Live intelligence</span>
            <span class="acme-tag">STIX 2.1</span>
            <span class="acme-tag">MITRE ATT&amp;CK</span>
          </div>
        </div>
        <main class="acme-content">{{ .content }}</main>
        <footer class="acme-web-footer">
          <span class="acme-handling">Acme Corp · Internal</span>
          <span class="acme-handling">Generated with <a href="https://blackstork.io">BlackStork</a></span>
        </footer>
      </article>
    HTML

    "content.table" = <<-HTML
      <div class="acme-table-wrap">
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
    "section.ctid_executive_summary" = <<-HTML
      <section class="acme-bluf">{{ .title }}{{ .content }}</section>
    HTML

    "section.ctid_key_points" = <<-HTML
      <section class="acme-key-points">{{ .title }}{{ .content }}</section>
    HTML

    "section.ctid_mitre_attack" = <<-HTML
      <section class="acme-data-section acme-mitre-table">{{ .title }}{{ .content }}</section>
    HTML

    "section.ctid_timeline_of_activity" = <<-HTML
      <section class="acme-data-section">{{ .title }}{{ .content }}</section>
    HTML

    "section.ctid_iocs" = <<-HTML
      <section class="acme-data-section acme-ioc-section">{{ .title }}{{ .content }}</section>
    HTML

    "section.ctid_cves" = <<-HTML
      <section class="acme-data-section">{{ .title }}{{ .content }}</section>
    HTML

    "section.ctid_probability_matrix" = <<-HTML
      <section class="acme-probability">{{ .title }}{{ .content }}</section>
    HTML

    "section.ctid_data_sources" = <<-HTML
      <section class="acme-sources">{{ .title }}{{ .content }}</section>
    HTML

    "content.table.ctid_mitre_attack" = <<-HTML
      <div class="acme-table-wrap">
        <table>
          <thead><tr>{{ range .headers_html }}<th>{{ . }}</th>{{ end }}</tr></thead>
          <tbody>{{ range .rows_html }}<tr>{{ range . }}<td>{{ .value_html }}</td>{{ end }}</tr>{{ end }}</tbody>
        </table>
      </div>
    HTML

    "content.table.ctid_metadata" = <<-HTML
      <div class="acme-table-wrap acme-metadata">
        <table>
          <tbody>{{ range .rows_html }}<tr>{{ range . }}<td>{{ .value_html }}</td>{{ end }}</tr>{{ end }}</tbody>
        </table>
      </div>
    HTML
  }
}
