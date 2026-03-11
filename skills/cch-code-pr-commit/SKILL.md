---
name: cch-code-pr-commit
description: Advance the blueprint by one commit. Picks up the next unchecked item, writes the tests or implementation, runs checks, and pauses for your sign-off before committing. Use when a user wants to work through the blueprint one step at a time.
---

# CCH Code PR Commit

Advance the blueprint by one commit — write tests or code, run checks, and pause for your sign-off.

## When to use

Use when the user asks to:
- Code the next commit from a plan
- Continue implementation work on a ticket
- Execute the next step in a blueprint

## Inputs

- **ticket** (optional): Ticket ID (e.g., `PROJ-123`). If not provided, extracted from the current branch name.

## Prerequisites

- A blueprint must exist at `.cch/<TICKET>_blueprint.md`
- The plan must have been reviewed and approved
- You must be on the correct branch

## Workflow

1. **Resolve ticket ID** from argument or branch name
2. **Read blueprint** and confirm branch matches
3. **Find next unchecked commit** in the commit checklist
4. **Execute the commit work** (write tests or implementation)
5. **Run type checker** (if applicable) and fix related errors
6. **Run linter** and fix related errors
7. **Wait for human review** before committing
8. **Commit changes** and update the plan checklist

## References

See [references/workflow.md](references/workflow.md) for the detailed step-by-step workflow.

## Notes

- Only one commit is executed per invocation
- Human review is required before each commit
- After committing, check if more commits remain or if it's time to create a PR
