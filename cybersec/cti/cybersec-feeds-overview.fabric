section "feeds_summary" {

  vars {
    total_articles = query_jq("[(.vars.feeds_with_articles // {})[] | .items // [] | .[]] | length")
  }

  content blockquote "section_intro" {
    is_included = query_jq(".vars.total_articles > 0")
    value = "The following points represent the highest-priority trends and critical alerts synthesized from **{{ .vars.total_articles }}** recent articles in the {{ .vars.feeds_category | title }} category. Routine updates and marketing materials have been filtered out."
  }

  content llm_text {
    config = config.content.llm_text.gemini
 
    prompt = <<-EOT
      Write a situational awareness summary of the following cybersecurity
      articles. The summary must be clear and actionable brief for CTI
      engineers, security engineers, and cybersecurity researchers. Focus on
      consolidating main points from all articles into a unified set of up to
      5-9 brief key takeaways. Prioritize most discussed items, new threats,
      new vulnerabilities, attack trends, policy changes and significant
      developments relevant to cybersecurity threat landscape and industry
      processess. Deprioritize vendor marketing, promotional content, or
      irrelevant information.

      Use the category of the feed to provide context and appropriately weight
      the insights during summarization, ensuring the most relevant and
      actionable information is emphasized.

      Style specification:
      - Use Bottom Line Up Front: begin with the most important updates. Do not mark it explicitely.
      - Write in active voice and keep sentences brief.
      - Use short, conventional plain English words. Avoiding jargon, filler
        words or vague statements. Do not use "crucial", "essential",
        "ensuring", "enhanced", etc. Be precise, like it is military.
      - Focus on accuracy, credibility, and completeness. DO NOT PROVIDE ADVICE.

      Task specification:
      - Some articles might lack full descriptions or content, use what is available.
      - Avoid per-article summaries, additional analysis, or interpretation. Group insights from
        multiple articles into one take away point, if appropriate.
      - Reference the source articles at the end of each takeaway in the format
        ([Article title](Article link), [Article title](Article link)).
      - Provide ONLY the UNORDERED markdown list of takeaways with no additional
        formatting or introductory text.

      ===

      FEEDS CATEGORY: {{ .vars.feeds_category }}

      {{ range $key, $value := .vars.feeds_with_articles }}
      == FEED ==
      {{ if gt (len $value.items) 0 }}
      FEED SLUG: {{ $key }}
      FEED TITLE: {{ $value.title }}
      NEW ARTICLES: {{ len $value.items }}

      {{ range $value.items }}
      ==== FEED ARTICLE ====
      ARTICLE TITLE: {{ .title }}
      ARTICLE URL: {{ .link }}
      DESCRIPTION: {{ printf "%.5000s" .description }}
      CONTENT: {{ printf "%.5000s" .content }}
      {{ end -}}
      {{ end -}}
      {{ end -}}
    EOT
  }

  section "articles" {
    is_included = query_jq(".vars.total_articles > 0")
    title = "Source Articles ({{ .vars.total_articles }})"

    content list "articles_list" {
      items = query_jq(<<-EOT
        .vars.feeds_with_articles
        | [
          to_entries[]
          | .value as $feed
          | $feed.items[]
          | . + {
            feed_title: $feed.title,
            feed_link: $feed.link,
          }
        ]
      EOT
      )
      item_template = "[{{ (default \"Untitled\" .title) }}]({{ .link }}) by [{{ .feed_title }}]({{ .feed_link }}) on {{ .pub_date }}"
      format = "unordered"
    }
  }

}

document "cybersec-feeds-overview" {

  meta {
    name = "Cybersec Feeds Overview template"

    description = <<-EOT
      The overview summarizes key updates from 100+ RSS feeds, published in a specified period.
      It relies on LLM for prioritisation and summarisation of the articles.
    EOT

    url = "https://ctichef.com/cybersec-feeds/"

    license = "Apache License 2.0"
    tags = ["cti", "osint", "cybersec"]

    updated_at = "2025-01-12T10:00:01+01:00"
  }

  input "start_date" {
    label         = "Start Date (%Y-%m-%dT%H:%M:%S%Z)"
    type          = "string"
    default_value = "2026-05-04T00:00:00Z"
  }

  input "end_date" {
    label         = "End Date (%Y-%m-%dT%H:%M:%S%Z)"
    type          = "string"
    default_value = "2026-05-10T23:59:59Z"
  }

  # Government

  data rss gov_cis_advisories {
    url = "https://www.cisecurity.org/feed/advisories"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss gov_cisa_advisories {
    url = "https://www.cisa.gov/cybersecurity-advisories/all.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss gov_cisa_alerts {
    url = "https://www.cisa.gov/cybersecurity-advisories/alerts.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss gov_nist_insights {
    url = "https://www.nist.gov/blogs/cybersecurity-insights/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss gov_cto_ncsc {
    url = "https://ctoatncsc.substack.com/feed"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss gov_circ_lu {
    url = "https://circl.lu/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss gov_health_isac {
    url = "https://health-isac.org/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss gov_fsisac {
    url = "https://www.fsisac.com/newsroom/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss gov_automotive_isac {
    url = "https://automotiveisac.com/press-news?format=rss"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss gov_ms_isac {
    // Cyber Security Advisories - MS-ISAC
    url = "https://www.cisecurity.org/feed/advisories"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss gov_cert_at {
    url = "https://www.cert.at/cert-at.de.warnings.rss_2.0.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss gov_cert_au {
    url = "https://www.cyber.gov.au/rss/alerts"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss gov_cert_ca {
    url = "https://www.cyber.gc.ca/api/cccs/atom/v1/get?feed=alerts_advisories"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss gov_cert_de {
    url = "https://wid.cert-bund.de/content/public/securityAdvisory/rss"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss gov_cert_eu {
    url = "https://cert.europa.eu/publications/threat-intelligence-rss"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss gov_cert_jp {
    url = "https://www.jpcert.or.jp/rss/jpcert.rdf"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss gov_cert_ee {
    url = "https://www.ria.ee/et/news-feed/all/feed"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss gov_ncscnl {
    url = "https://advisories.ncsc.nl/rss/advisories"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }


  // Newsletters

  data rss news_securityweek {
    url = "https://www.securityweek.com/feed/"
    ignore_failures = true
  }

  data rss news_arstechnica_security {
    url = "https://arstechnica.com/tag/security/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss news_bleeping_computer {
    url = "https://www.bleepingcomputer.com/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss news_cio_magazine {
    url = "https://www.cio.com/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss news_dark_reading {
    url = "https://www.darkreading.com/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    // Somehow still empty?
    fill_in_content = true
  }

  data rss news_guardian_data_computer_security {
    url = "https://www.theguardian.com/technology/data-computer-security/rss"
    fill_in_content = true
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss news_hackread {
    url = "https://hackread.com/feed/"
    fill_in_content = true
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss news_threatpost {
    url = "https://threatpost.com/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss news_zdnet {
    url = "https://www.zdnet.com/topic/security/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss news_cybersecuritynews {
    url = "https://feeds.feedburner.com/cyber-security-news"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss news_cyberscoop {
    url = "https://cyberscoop.com/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss news_gbhackers {
    url = "https://gbhackers.com/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss news_thecyberexpress {
    url = "https://thecyberexpress.com/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss news_thecyberwire {
    url = "https://thecyberwire.com/feeds/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  // Vendors

  data rss vendor_elastic {
    url = "https://www.elastic.co/security-labs/rss/feed.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_wiz {
    url = "https://www.wiz.io/api/feed/cloud-threat-landscape/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss vendor_huntress {
    url = "https://www.huntress.com/blog/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss vendor_greynoise {
    url = "https://www.greynoise.io/blog/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss vendor_datadog {
    url = "https://securitylabs.datadoghq.com/rss/feed.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss vendor_ossprey {
    url = "https://www.ossprey.com/blog/index.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss vendor_rapid7 {
    url = "https://blog.rapid7.com/rss/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_socradar {
    url = "https://socradar.io/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_sysdig {
    url = "https://sysdig.com/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_anyrun {
    url = "https://medium.com/feed/@anyrun"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_quarkslab {
    url = "https://blog.quarkslab.com/feeds/all.rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_exodusintel {
    url = "https://blog.exodusintel.com/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_intezer {
    url = "https://intezer.com/blog/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_0patch {
    url = "https://blog.0patch.com/feeds/posts/default?alt=rss"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }


  data rss vendor_levelblue {
    url = "https://www.levelblue.com/blogs/spiderlabs-blog/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_bitdefender {
    url = "https://www.bitdefender.com/nuxt/api/en-us/rss/labs/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_broadcom_symantec {
    url = "https://sed-cms.broadcom.com/rss/v1/blogs/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss vendor_checkpoint {
    url = "https://research.checkpoint.com/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_cisco {
    url = "https://blogs.cisco.com/security/feed"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss vendor_cloudflare {
    url = "https://blog.cloudflare.com/tag/security/rss"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_crowdstrike {
    url = "https://www.crowdstrike.com/en-us/blog/feed"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_eclecticiq {
    url = "https://blog.eclecticiq.com/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_eset {
    url = "https://feeds.feedburner.com/eset/blog?format=xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_fortinet {
    url = "https://feeds.fortinet.com/fortinet/blog/threat-research"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_fortinet_fortiguard {
    url = "https://filestore.fortinet.com/fortiguard/rss/threatsignal.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_google_online_security {
    url = "https://feeds.feedburner.com/GoogleOnlineSecurityBlog"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_google_threat_intel {
    url = "https://feeds.feedburner.com/threatintelligence/pvexyqv7v0v"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_google_threat_analysis_group {
    url = "https://blog.google/threat-analysis-group/rss/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss vendor_malware_bytes {
    url = "https://www.malwarebytes.com/blog/feed/index.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_groupib {
    url = "https://blog.group-ib.com/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss vendor_knowbe4 {
    url = "https://blog.knowbe4.com/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss vendor_microsoft_security_blog {
    url = "https://www.microsoft.com/en-us/security/blog/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_microsoft_security_update_guide {
    url = "https://api.msrc.microsoft.com/update-guide/rss"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss vendor_proofpoint {
    url = "https://www.proofpoint.com/us/rss.xml"
    fill_in_content = true
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_recorded_future_therecord {
    url = "https://therecord.media/feed"
    fill_in_content = true
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_exatrack {
    url = "https://blog.exatrack.com/index.xml"
    fill_in_content = true
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  // Returns 404 randomly
  data rss vendor_recorded_future_blog {
    url = "https://www.recordedfuture.com/feed"
    use_browser_user_agent = true
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_kaspersky_securelist {
    url = "https://securelist.com/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_orange_sensepost {
    url = "https://sensepost.com/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_sentinelone_labs {
    url = "https://sentinelone.com/labs/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_dogesec {
    url = "https://www.dogesec.com/feed.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_spected_ops {
    url = "https://specterops.io/feed"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_paloaltonetworks_blog {
    url = "https://www.paloaltonetworks.com/blog/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_paloaltonetworks_unit42 {
    url = "https://unit42.paloaltonetworks.com/feed/"
    fill_in_content = true
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_upguard_breaches {
    url = "https://www.upguard.com/breaches/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_veracode {
    url = "https://www.veracode.com/blog/feed"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_virus_bulletin {
    url = "https://www.virusbulletin.com/rss"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_virustotal_blog {
    url = "https://blog.virustotal.com/feeds/posts/default"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_breaches_cloud {
    url = "https://www.breaches.cloud/index.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_thezdi {
    url = "https://www.thezdi.com/blog?format=rss"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_ahnlab {
    url = "https://asec.ahnlab.com/en/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss vendor_morphisec {
    url = "https://www.morphisec.com/blog/?feed=rss2"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss vendor_aquasec {
    url = "http://blog.aquasec.com/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_arcticwolf {
    url = "https://arcticwolf.com/resources/category/blog/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }


  data rss vendor_badsectorlabs {
    url = "https://blog.badsectorlabs.com/feeds/all.atom.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss vendor_barracuda {
    url = "https://blog.barracuda.com/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_bishopfox {
    url = "https://bishopfox.com/feeds/blog.rss"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss vendor_pulsedive {
    url = "https://blog.pulsedive.com/rss/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_rstcloud {
    url = "https://medium.com/feed/@rst_cloud"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_reliaquest {
    url = "https://reliaquest.com/rss.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss vendor_tenable_blog {
    url = "https://feeds.feedburner.com/tenable/qaXL"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  // Personalities

  data rss personal_anton_chuvakin {
    url = "https://medium.com/feed/anton-on-security"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_graham_cluley {
    url = "https://grahamcluley.com/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
    fill_in_content = true
  }

  data rss personal_schneier_on_security {
    url = "https://www.schneier.com/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_dan_lohrmann {
    url = "https://feeds.feedburner.com/govtech/blogs/lohrmann_on_infrastructure"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_brad_malware_traffic_analysis {
    url = "https://www.malware-traffic-analysis.net/blog-entries.rss"
    fill_in_content = true
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_pierluigi_paganini {
    url = "https://securityaffairs.com/feed"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_troy_hunt {
    url = "https://www.troyhunt.com/rss/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_bartblaze {
    url = "https://bartblaze.blogspot.com/feeds/posts/default"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_bushidotoken {
    url = "https://blog.bushidotoken.net/feeds/posts/default"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_connormcgarr {
    url = "https://connormcgarr.github.io/feed.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_blockthreat {
    url = "https://newsletter.blockthreat.io/feed"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_cybercrimediaries {
    url = "https://www.cybercrimediaries.com/blog-feed.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_sebdraven {
    url = "https://medium.com/feed/@sebdraven"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_cisotradecraft {
    url = "https://cisotradecraft.substack.com/feed"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_thecybersecuritypulse {
    url = "https://www.cybersecuritypulse.net/feed"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_detection_at_scale {
    url = "https://jacknaglieri.substack.com/feed"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_stiennon {
    url = "https://stiennon.substack.com/feed"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_ecapuano {
    url = "https://blog.ecapuano.com/feed"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_krebsonsecurity {
    url = "https://krebsonsecurity.com/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_0x434b {
    url = "https://0x434b.dev/rss/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss personal_willsroot {
    url = "https://www.willsroot.io/feeds/posts/default?alt=rss"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  // Community

  data rss community_curatedintel {
    url = "https://www.curatedintel.org/feeds/posts/default"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss community_nao_sec {
    url = "https://nao-sec.org/feed"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss community_netblocks {
    url = "https://mastodon.social/@netblocks.rss"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss community_darknet {
    url = "http://www.darknet.org.uk/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss community_reddit_cybersecurity {
    url = "https://www.reddit.com/r/cybersecurity/.rss"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss community_reddit_netsec {
    url = "https://www.reddit.com/r/netsec/.rss"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }
 
  data rss community_sans_isc {
    url = "https://isc.sans.edu/rssfeed_full.xml"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss community_asec {
    url = "https://asec.ahnlab.com/ko/feed/"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  data rss community_cert_org {
    url = "https://www.kb.cert.org/vulfeed"
    items_after = inputs.start_date
    items_before = inputs.end_date
    ignore_failures = true
  }

  vars {
    gov_feeds = query_jq(<<-EOT
      .data.rss | to_entries | map(select(.key | startswith("gov_"))) | from_entries
    EOT
    )

    vendor_feeds = query_jq(<<-EOT
      .data.rss | to_entries | map(select(.key | startswith("vendor_"))) | from_entries
    EOT
    )

    news_feeds = query_jq(<<-EOT
      .data.rss | to_entries | map(select(.key | startswith("news_"))) | from_entries
    EOT
    )

    personal_feeds = query_jq(<<-EOT
      .data.rss | to_entries | map(select(.key | startswith("personal_"))) | from_entries
    EOT
    )

    community_feeds = query_jq(<<-EOT
      .data.rss | to_entries | map(select(.key | startswith("community_"))) | from_entries
    EOT
    )
  }

  title = <<-EOT
    Cybersec Feeds Overview, {{ toDate "2006-01-02T15:04:05Z" .inputs.start_date | date "Jan 2" }} - {{ toDate "2006-01-02T15:04:05Z" .inputs.end_date | date "Jan 2, 2006" }}
  EOT

  content text {
    value = <<-EOT
    This brief consolidates key updates from 100+ sources, including
    government organizations, cybersecurity vendors, threat intelligence teams,
    security research labs, and blogs from cybersecurity communities and
    professionals. It highlights the most significant threats, vulnerabilities,
    and developments from the past week to keep you informed.
    EOT
  }

  section ref {
    base = section.feeds_summary

    title = "Gov Feeds"

    vars {
      feeds_all = query_jq(".vars.gov_feeds")
      feeds_with_articles = query_jq(".vars.feeds_all | to_entries | map(select((.value.items | length) > 0)) | from_entries")
      feeds_category = query_jq(".vars.feeds_all | to_entries | .[0].key | split(\"_\")[0]")
    }
  }

  section ref {
    base = section.feeds_summary

    title = "Vendor Feeds"

    vars {
      feeds_all = query_jq(".vars.vendor_feeds")
      feeds_with_articles = query_jq(".vars.feeds_all | to_entries | map(select((.value.items | length) > 0)) | from_entries")
      feeds_category = query_jq(".vars.feeds_all | to_entries | .[0].key | split(\"_\")[0]")
    }
  }

  section ref {
    base = section.feeds_summary

    title = "News Feeds"

    vars {
      feeds_all = query_jq(".vars.news_feeds")
      feeds_with_articles = query_jq(".vars.feeds_all | to_entries | map(select((.value.items | length) > 0)) | from_entries")
      feeds_category = query_jq(".vars.feeds_all | to_entries | .[0].key | split(\"_\")[0]")
    }
  }

  section ref {
    base = section.feeds_summary

    title = "Personal Feeds"

    vars {
      feeds_all = query_jq(".vars.personal_feeds")
      feeds_with_articles = query_jq(".vars.feeds_all | to_entries | map(select((.value.items | length) > 0)) | from_entries")
      feeds_category = query_jq(".vars.feeds_all | to_entries | .[0].key | split(\"_\")[0]")
    }
  }

  section ref {
    base = section.feeds_summary

    title = "Community Feeds"

    vars {
      feeds_all = query_jq(".vars.community_feeds")
      feeds_with_articles = query_jq(".vars.feeds_all | to_entries | map(select((.value.items | length) > 0)) | from_entries")
      feeds_category = query_jq(".vars.feeds_all | to_entries | .[0].key | split(\"_\")[0]")
    }
  }

  section {
    title = "Disclaimer"

    content text {
      value = <<-EOT
      The summaries in this brief are generated autonomously by LLM
      based on the provided system and user prompts. While every effort
      is made to consolidate accurate and relevant insights, the model may
      occasionally misinterpret, misrepresent, or hallucinate information.
      Readers are strongly advised to verify all key points by consulting the
      original sources linked in the brief for complete context and accuracy.

      This document is created with [BlackStork](https://blackstork.io) and is based
      on the template available [on GitHub](https://github.com/blackstork-io/fabric-templates/blob/main/cybersec/cti/cybersec-feeds-overview.fabric).

      [Reach out](mailto:sergey@blackstork.io) if you have questions or suggestions.
      EOT
    }

  }
}

