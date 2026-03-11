# How to compose a pull request

**This is about writing a great PR description — not reviewing the code. Don't critique or suggest changes to the implementation.**

---

## Figure out the ticket

Optional. If not provided, pull it from the branch name.

**If given directly:**
- Use it as-is

**If not:**
1. Grab the branch name:
   ```bash
   git branch --show-current
   ```
2. Look for a ticket pattern: `[A-Z]+-[0-9]+`
   - Common formats: `PROJ-123-description`, `feature/PROJ-123`, `user/PROJ-123-work`
3. If found: "Detected ticket from branch: \<ticket\>"
4. If not found: set ticket to null and keep going — a ticket isn't required for PR creation

---

## Track your progress

Set up a task list:

- Figure out the ticket
- Track your progress
- Read the blueprint
- Gather the changes
- Write the story
- Write QA scenarios
- Check for UI sections
- Check for screenshot sections
- Check for infrastructure sections
- Pause for sign-off
- Ship it
- Share the link

Check each off as you go.

---

## PR template

Use this as the output format:

```markdown
## Type of change
- [ ] Bug fix (change which fixes an issue)
- [ ] New feature (change which adds functionality)
- [ ] Maintenance/update chore

## Description
[High-level overview — see "Write the story"]

### Dev notes
[Technical details — see "Write the story"]

## QA Test Cases
[Test scenarios — see "Write QA scenarios"]

[UI Checklist — if applicable]
[Screenshots section — if applicable]
[Infrastructure section — if applicable]

## Checklist
- [ ] My code follows the style guidelines of this project
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have satisfied all story requirements
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] New and existing unit tests pass locally with my changes
```

---

## Read the blueprint

**If a ticket was detected:**
- Open `./.cch/<TICKET>_blueprint.md` for context
- Let the blueprint guide the PR description

**If there's no ticket:**
- Skip this — rely on git commits and diffs

---

## Gather the changes

Find the base branch:
```bash
git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'
```

Pull the commit history and diff:
```bash
git log --oneline <base-branch>..HEAD
git diff <base-branch>...HEAD
```

Write the PR description to:
- **With ticket:** `./.cch/<TICKET>_pr.md`
- **Without ticket:** `./.cch/pr_description.md`

---

## Write the story

### The headline
A concise, human-readable summary (1–2 sentences) of **what** changed and **why** it matters.

### The technical details (dev notes)
Detailed notes for reviewers. **Only include what's relevant:**
- **Architecture/approach**: Key design decisions
- **Key files modified**: The important changes
- **Technical challenges**: Complexity or gotchas worth knowing
- **Dependencies**: New libraries, APIs, or services
- **Database changes**: Migrations, schema updates, data changes
- **Breaking changes**: API or interface changes

---

## Write QA scenarios

Create thorough test cases:

**Test: [Clear, descriptive name]**
- **Objective**: What's being tested and why
- **Preconditions**: Setup or state needed
- **Steps**: Numbered, specific actions
- **Expected Result**: What should happen
- **Edge Cases** (if relevant): Alternative scenarios

### Guidelines
- As many test cases as the functionality demands
- Cover the happy path
- Cover edge cases and error scenarios
- For bug fixes: verify the original bug is gone
- For UI changes: visual checks across browsers
- For API changes: different request scenarios

---

## Check for UI sections

If frontend changes were made, include:

```markdown
## UI Checklist
- [ ] I have included screenshots and/or a video of any front end changes made
- [ ] I verified visual consistency across supported browsers
- [ ] I have verified keyboard navigation and/or screen reader accessibility
- [ ] I have evaluated UI performance (render tree, memoization, re-renders)
- [ ] I reviewed UI for alignment with design system components
```

---

## Check for screenshot sections

If UI changes were made, add smart placeholder suggestions based on what actually changed:

```markdown
## Screenshots/Demo Video
*Please add screenshots or a demo video showing the changes*

**Before:**
[Specific description based on what changed]

**After:**
[Specific description based on what changed]
```

---

## Check for infrastructure sections

If the changes depend on infrastructure (message queues, new services, AWS resources, env vars), include:

```markdown
## Infrastructure Updates
My code requires infrastructure updates and the PRs have been created:
- [ ] [Link to infrastructure PR]
```

---

## Pause for sign-off

**Stop here — don't create the PR until the human reviews the description.**

Point them to the description file and wait for feedback or a go-ahead.

---

## Ship it

**Only after sign-off.**

### Preflight checks
1. `gh` CLI available? `which gh`
2. Check the remote: `git remote -v`

### Draft or ready?

Ask: "Want this as a draft PR?"
- **Draft** — no notifications sent
- **Ready** — notifications go out if configured

### Create the PR

Title format:
- **With ticket:** `[<TICKET>] Brief descriptive title`
- **Without ticket:** `Brief descriptive title`

```bash
gh pr create [--draft] --title "TITLE" --body "$(cat PR_FILE)"
```

---

## Share the link

Output the PR URL so the user can see it.

---

## Keep in mind

- **Check the change type** from the diff before filling out the template
- **Only include relevant sections** — skip the UI checklist for backend-only work
- **Write specific, actionable QA scenarios** — not "test the feature"
- **Use real file paths and line numbers** in technical notes
- **Keep it concise but complete** — enough for reviewers to understand without reading every line
