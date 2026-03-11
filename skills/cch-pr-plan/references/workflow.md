# How to draft a blueprint

## Track your progress

Before you begin, set up a task list so nothing falls through the cracks:

- Lay the groundwork
- Branch off
- Explore the code
- Clarify anything fuzzy
- Draft the blueprint
- Pause for sign-off
- Next steps

Check each off as you go.

---

## Lay the groundwork

Figure out what you're building and why.

**If a ticket ID is provided:**
- Pull details from the issue tracker (Jira, Linear, GitHub Issues, etc.) if available
- Grab: summary, description, acceptance criteria, specified files

**If there's no ticket:**
- Ask the user to describe the work
- Use that description as your starting point

---

## Branch off

Set up a feature branch for this work:

1. Find the base branch:
   ```bash
   git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'
   ```
2. Pull the latest
3. Create a branch following the repo's naming conventions:
   - Look in `CLAUDE.md` or similar docs for patterns
   - Fall back to recent branch names: `git branch -r --sort=-committerdate | head -20`
   - Common patterns: `feature/TICKET-123-short-description`, `TICKET-123-short-description`
4. Check it out

---

## Explore the code

Dig into the codebase to understand what you're working with:

- **Existing patterns**: What similar implementations already exist?
- **State management**: How are temporary flags and states typically handled?
- **Error handling**: What exception-safety patterns are in use?
- **Test coverage**: What testing patterns exist? Are tests preserved or replaced?

### Where to look first
1. **Files called out in the ticket** (if any)
2. **Related files** with similar naming or functionality
3. **Test files** for existing patterns
4. **Config files** for flags and settings

---

## Clarify anything fuzzy

If requirements are ambiguous, ask before drafting the blueprint.

**Keep it tight:**
- 1–4 questions max
- 2–4 options per question
- Short headers (12 characters or less)
- The user can always write in a custom answer

**Don't move forward until you have answers.**

---

## Draft the blueprint

Write the blueprint to `./.cch/<TICKET>_blueprint.md` using this structure:

```markdown
# <TICKET> Blueprint

## What we're building
Plain-language description of the work in your own words.

## Branch
<branchName> (created earlier)

## Design Patterns
Read [references/design-patterns.md](design-patterns.md) and consider:
1. What patterns are already in use in the relevant areas of the codebase
2. Which patterns (if any) would benefit the planned work
3. For each proposed pattern: name it, explain why it fits, and show how it maps to the task

Only propose patterns that solve a real problem. Don't force them.

## Code Quality Notes
Read [references/clean-code.md](clean-code.md) and note:
1. Any code smells in the areas you'll be touching
2. Refactoring opportunities that directly support the task
3. SOLID principle considerations for the planned architecture

Don't plan large refactoring detours unless the ticket calls for it.

## Commits

Break the work into atomic, test-driven commits. Each unit of functionality follows the pattern: write tests first, then implement to make them pass.

**Example:**
- **Commit N**: [Tests for Feature X] — write failing tests
- **Commit N+1**: [Implement Feature X] — make tests pass

Each pair is one complete unit of functionality.

### What we're building (by component)

- **[Component/Feature Name]**
  - Tests:
    - test description 1
    - test description 2
  - Implementation:
    - task description 1
    - task description 2

### Commit checklist

Work through these in order:

- [ ] Commit 1: [Tests for Feature X] — write failing tests
- [ ] Commit 2: [Implement Feature X] — make tests pass
- [ ] Commit 3: [Tests for Feature Y] — write failing tests
- [ ] Commit 4: [Implement Feature Y] — make tests pass

## Test Strategy
Every change needs test coverage, following TDD.
Before writing a new test, check if an existing one already fails due to the change. Don't over-test.

**Requirements:**
- Preserve all existing test coverage
- Add targeted tests for new functionality
- Cover both success and failure scenarios
- Make test intent obvious

## Scope
- **Files to modify**: [from ticket if specified]
- **Patterns already in use**: [list what you found]
- **Test approach**: [preserve vs replace, coverage expectations]
```

### Quality bar

**Testing:**
- Preserve existing coverage — always
- Tests first, implementation second
- Cover the happy path and the sad path

**Commits:**
- One logical change per commit
- Commit messages explain the *why*, not just the *what*
- Include technical details

### Definition of done
- [ ] Every commit follows TDD (tests first, then implementation)
- [ ] Each commit stands on its own
- [ ] The original issue is resolved
- [ ] No regressions in related functionality
- [ ] Code follows existing patterns
- [ ] Commit history tells a clear story
- [ ] Test coverage is preserved or improved

### Risk check
- **Complexity**: [High / Medium / Low]
- **Regression risk**: [what could break]
- **Key test scenarios**: [what to validate]
- **Style consistency**: [how well it fits the codebase]

---

## Pause for sign-off

**Stop here — no code gets written until the human approves the blueprint.**

They need to:
- Read through the blueprint
- Flag anything to change
- Give an explicit go-ahead

---

## Next steps

Once the blueprint is approved, advance to the first commit with **cch-code-pr-commit**.
