---
name: cch-create-pr
description: Compose a pull request from your branch. Reads the commit history and diffs to build a description with a high-level summary, technical notes, QA test scenarios, and context-aware sections for UI, screenshots, or infrastructure changes. Use when a user is ready to open a PR or says "ship it".
---

# CCH Create PR

Compose a pull request — summary, technical notes, QA scenarios, and context-aware sections — from your branch's commits.

## When to use

Use when the user asks to:
- Create a pull request
- Open a PR for their current branch
- Generate a PR description from their commits

## Inputs

- **ticket** (optional): Ticket ID (e.g., `PROJ-123`). If not provided, extracted from the current branch name. PR can be created without a ticket.

## Prerequisites

- Changes must be committed and ready for review
- GitHub CLI (`gh`) must be authenticated
- Current branch should have commits ahead of the base branch

## Workflow

1. **Resolve ticket ID** from argument or branch name (optional)
2. **Read blueprint** if available for context
3. **Gather changes** — commits, diffs, and file modifications
4. **Generate smart description** — high-level overview and technical dev notes
5. **Generate QA test cases** — comprehensive test scenarios
6. **Add conditional sections** — UI checklist, screenshots, infrastructure (only if relevant)
7. **Write PR description** to `.cch/<TICKET>_pr.md`
8. **Wait for human review** of the description
9. **Create the PR** via `gh pr create`

## References

See [references/workflow.md](references/workflow.md) for the detailed step-by-step workflow.

## Notes

- This is NOT a code review — it generates a PR description, not code feedback
- Sections are conditionally included based on the type of changes detected
- Supports both draft and ready-for-review PRs
