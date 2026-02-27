---
name: cch-pr-plan
description: Draft an implementation blueprint before writing code. Explores the codebase, surfaces relevant design patterns and code quality concerns, and maps out a sequence of atomic, test-driven commits. Use when a user wants to plan work for a ticket, scope a feature, or says "blueprint".
---

# CCH PR Plan

Explore the codebase and draft an implementation blueprint — a sequence of atomic, test-driven commits — before any code is written.

## When to use

Use when the user asks to:
- Begin implementation planning for a ticket
- Create a blueprint for a feature or bug fix
- Start working on a ticket (planning phase)
- Analyze a ticket before coding

## Inputs

- **ticket** (optional): Ticket ID (e.g., `PROJ-123`). If not provided, extracted from the current branch name.

## Workflow

1. **Resolve ticket ID** from argument or branch name
2. **Gather ticket context** (from issue tracker if available, or user-provided context)
3. **Create a feature branch** following repository naming conventions
4. **Analyze relevant code** and existing patterns in the codebase
5. **Identify design patterns** — propose applicable patterns when they solve a real problem (see [references/design-patterns.md](references/design-patterns.md))
6. **Ask clarifying questions** if requirements are ambiguous
7. **Write blueprint** to `.cch/<TICKET>_blueprint.md`
8. **Stop and wait** for human review before any coding begins

## References

See [references/workflow.md](references/workflow.md) for the detailed step-by-step workflow.

## Notes

- The blueprint is the contract between planning and coding phases
- No code changes are made during planning — only the blueprint is created
- Human approval is required before moving to the coding phase
