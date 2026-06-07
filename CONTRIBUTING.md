# Contributing to BlackStork Templates

We welcome contributions from the community. Whether you are fixing a bug, improving an existing template, or submitting an entirely new report template, your input helps standardize and automate security reporting.

## Anatomy of a Great Template Submission

When submitting a new template, please ensure it adheres to the following structural and stylistic guidelines:

1. **Include metadata:** every template must include a `meta` block with a clear `name`, a concise `description`, the `authors`, and relevant `tags`.
2. **Prefer `input` blocks to env variables:** if your templates requires user's input, prefer `input` blocks to using environment variables, as `input` blocks are supported natively in BlackStork SaaS.
3. **Separate data from presentation:** do not embed complex data manipulation inside Go `{{ ... }}` template strings. Use a centralized or local `vars` block to perform data shaping and deduplication natively using `query_jq()` function.
4. **Include fallback rendering:** design templates to render cleanly in standard Markdown. If you include a `format html` block for advanced styling, ensure the base `content` blocks still output readable text without it.
5. **Provide example output:** if your template requires complex or proprietary data sources (e.g., a commercial Threat Intel Platform), please include a sanitized `.md` or `.html` example of the output in your pull request so reviewers can verify the layout.
6. **Use defensive parsing:** real-world API data is often incomplete. Use `jq` fallbacks (e.g., `// "Unknown"`) and Go template conditionals to prevent the template from crashing on null values.

## How to Submit a Pull Request

1. **Fork and branch:** fork this repository and create a new branch for your template (e.g., `feature/aws-incident-report`).
2. **Test locally:** run your template locally using `blackstork-cli` to ensure there are no BCL syntax errors, `jq` evaluation failures, or Go template panics.
3. **Document your template:** if your template requires specific environment variables or input parameters, add necessary details to `description` field in template's `meta` block.
4. **Submit the PR:** Open a pull request against the `main` branch. Include a brief summary of what the template does, the data sources it integrates with, and attach your sanitized example output.

## Reporting Issues

If you find a bug in an existing template or want to request a new one, please open an issue. Include:
* The name of the template.
* The exact error message or unexpected behavior.
* Steps to reproduce the issue.
