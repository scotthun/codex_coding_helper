---
name: cch-code-all-pr-commits
description: Run the full blueprint end-to-end. Iterates through every remaining commit — tests, implementation, checks, commit — then pushes and offers to open a PR. Use when a user wants to execute the whole blueprint without stopping between steps or says "run it all".
---

# CCH Code All PR Commits

Run the full blueprint end-to-end — test, implement, check, commit, repeat — then push and open a PR.

## When to use

Use when the user asks to:
- Complete all planned commits in one session
- Execute the full plan without stopping between commits
- Run through the remaining work end-to-end

## Inputs

- **ticket** (optional): Ticket ID (e.g., `PROJ-123`). If not provided, extracted from the current branch name.

## Prerequisites

- A blueprint must exist at `.cch/<TICKET>_blueprint.md`
- The plan must have been reviewed and approved by a human
- You must be on the correct branch

## Workflow

1. **Validate plan & branch** — read plan, confirm branch, count remaining commits
2. **Build task list** — create tasks for all remaining commits upfront
3. **Execute all commits** — for each unchecked commit:
   - Execute work (tests or implementation)
   - Run type checker (if applicable)
   - Run linter
   - Commit changes and update checklist
4. **Push all commits** to remote
5. **Create PR** — ask user if ready, then invoke cch-create-pr

## References

See [references/workflow.md](references/workflow.md) for the detailed step-by-step workflow.

## Notes

- Unlike cch-code-pr-commit, this does NOT stop for human review between commits
- Human review happens at the PR stage instead
- If any commit fails, execution stops and reports the issue
