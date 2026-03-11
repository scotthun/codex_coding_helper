---
name: cch-review-pr
description: Give a pull request a thorough second look. Examines architecture, design patterns, SOLID principles, code smells, test quality, performance, and security. Delivers a ranked report — critical, important, minor — with file references and suggested fixes. Use when a user wants a code review or shares a PR link.
---

# CCH Review PR

Give a pull request a thorough second look and deliver a ranked report of findings with actionable suggestions.

## When to use

Use when the user asks to:
- Review a pull request
- Analyze code quality for a PR
- Get feedback on PR changes before merging

## Inputs

- **pr_url** (required): The pull request URL to review (e.g., `https://github.com/org/repo/pull/123`)

## Prerequisites

- GitHub CLI (`gh`) must be authenticated
- The PR must be accessible

## Workflow

1. **Identify changes** — fetch PR diff and analyze modified files
2. **Code quality review** — check architecture, design patterns, readability, naming, error handling, type safety
3. **Testing review** — evaluate test coverage and test quality
4. **Performance & security review** — identify performance issues and security vulnerabilities
5. **Generate review report** with categorized findings (Critical, Important, Minor)
6. **Present findings** with specific file/line references and actionable suggestions

## References

See [references/workflow.md](references/workflow.md) for the detailed step-by-step workflow.

## Notes

- Focus is on code quality and design, not on generating a PR description
- Findings are categorized by severity: Critical (must fix), Important (should fix), Minor (nice to have)
- Review adapts focus based on the type of changes (frontend, backend, tests, infrastructure)
