# How to review a pull request

**This is about code quality and design. Focus on architecture, patterns, and whether the code is built to last.**

---

## Track your progress

Set up a task list:

- Map the changes
- Read through the code
- Write up your findings
- Present the report

Check each off as you go.

---

## Map the changes

- Pull the PR diff and metadata with `gh`:
  ```bash
  gh pr diff <PR_NUMBER>
  gh pr view <PR_NUMBER> --json title,body,baseRefName,headRefName,files
  ```
- Walk through the diff — what's being added, removed, and modified
- Write a plain-language summary for someone who's never seen this codebase

---

## Read through the code

Go through the changes with clean code principles and code smell detection in mind. Reference [the code smells catalog](https://refactoring.guru/refactoring/smells) for categories and fixes.

### Architecture & design
- **Separation of concerns**: Are responsibilities properly divided? (Single Responsibility Principle)
- **Design patterns**: Does it follow the patterns already in the codebase?
- **DRY**: Any unnecessary duplication?
- **SOLID**: Are any SOLID principles being bent or broken?

### Code quality
- **Readability**: Could someone unfamiliar with this code follow it?
- **Extractable logic**: Any dense blocks that deserve their own well-named method?
- **Naming**: Do variables, functions, and classes reveal their intent?
- **Error handling**: Are edge cases covered? Exceptions over error codes?
- **Type safety**: Are types pulling their weight? (for typed languages)

### Code smells
- **Bloaters**: Long methods, oversized classes, long parameter lists?
- **Couplers**: Feature envy, message chains, classes reaching into each other's internals?
- **Dispensables**: Dead code, copy-paste duplication, abstractions built for imaginary futures?
- **Change preventers**: Will this change cause ripple edits across the codebase later?

### Testing
- **Coverage**: Are the important paths tested?
- **Quality**: Are the tests meaningful and easy to maintain?

### Performance & security
- **Performance**: Any obvious bottlenecks?
- **Security**: Injection, XSS, or other vulnerabilities?
- **Resources**: Are connections, memory, and handles managed properly?

### Maintainability
- **Documentation**: Is tricky logic explained?
- **Dependencies**: Are they appropriate and minimal?
- **Tech debt**: Does this introduce debt that'll need paying off later?

---

## Write up your findings

Save the report. If a ticket ID can be detected from the branch, write to `./.cch/<TICKET>_review.md`. Otherwise `./.cch/pr_review.md`.

```markdown
# Review: <TICKET or PR title>

**Reviewer**: AI Agent
**Date**: [Date]
**Changes**: [Commit hash or description]

## At a glance
[1–2 sentence take on the changes and overall quality]

## What's working well
- [Good decisions and patterns]
- [Things worth calling out positively]

## Findings

### Must fix 🔴
[Blocking issues — these need to be resolved before merging]
- **[Issue]** (File:Line)
  - Problem: [What's wrong]
  - Impact: [Why it matters]
  - Suggestion: [How to fix it]

### Should fix 🟡
[Important issues worth addressing]
- **[Issue]** (File:Line)
  - Problem: [What's wrong]
  - Suggestion: [How to fix it]

### Worth considering 🔵
[Minor improvements — nice to have]
- **[Issue]** (File:Line)
  - Suggestion: [How to improve it]

## Overall take
[Big-picture suggestions and recommendations]

## Verdict
- [ ] Good to merge (no blocking issues)
- [ ] Good to merge with minor tweaks
- [ ] Needs changes (blocking issues found)
```

---

## Present the report

Walk the user through the findings:
- Clear severity categories (must fix, should fix, worth considering)
- Specific file and line references
- Actionable suggestions — not just "this is bad"
- Your overall recommendation

---

## Adjust your focus

Tailor the review based on what changed:

- **Frontend**: Component structure, state management, accessibility, render performance
- **Backend**: API design, query efficiency, security, error handling
- **Tests**: Coverage gaps, test quality, maintainability
- **Infrastructure**: Config correctness, security, scalability
