# How to run the full blueprint

This runs every remaining commit from an approved blueprint in one pass.

---

## Before you start

- A blueprint must exist at `./.cch/<TICKET>_blueprint.md`
- It must already be reviewed and approved by a human
- You must be on the correct branch

**No blueprint yet? Draft one first with cch-pr-plan.**

---

## Confirm the setup

1. **Figure out the ticket** — from the argument or the branch name (same logic as cch-code-pr-commit)
2. **Open the blueprint**: `./.cch/<TICKET>_blueprint.md`
3. **Verify the branch**: `git branch --show-current` should match the blueprint's **Branch**
   - Mismatch? Flag it and wait for the user's call
4. **Count what's left**: check the **Commit checklist** for unchecked `[ ]` items
5. **Show the summary**:
   ```
   Blueprint: <TICKET>_blueprint.md
   Branch: <branch name>
   Remaining: X of Y commits
   ```

If everything's already checked off, skip straight to pushing.

---

## Map out the work

Before writing any code, build a full task list for every remaining commit.

### Read the checklist

Go through the blueprint's **Commit checklist** and identify all unchecked items.

### Create the tasks

For each remaining commit:
- `Commit N: Write the code` — tests or implementation
- `Commit N: Run type checker` — fix type errors (if applicable)
- `Commit N: Run linter` — fix lint issues
- `Commit N: Save your work` — stage, commit, update checklist

Plus:
- `Push everything`
- `Compose the PR`

Check each off as you complete it.

---

## Run the full sequence

For **every unchecked commit**, cycle through:

### Write the code
- **Test commit:**
  - Write the failing tests
  - Run them — confirm they **fail for the expected reason**
- **Implementation commit:**
  - Write the minimum code to make tests pass
  - Refactor if it helps

### Run the type checker (typed languages)
- Run it if the language supports it
- Only fix errors from this commit's changes

### Run the linter
- Only fix lint issues on lines you changed in this commit

### Save your work
- Commit with clean git hygiene
- Mark the checklist item as `[x]` in the blueprint

### Keep going
- More unchecked commits? **Loop back** to "Write the code"
- All done? Move on to pushing

---

## Push everything

Once every commit is saved, push it all at once:
```bash
git push -u origin <branch-name>
```

---

## Wrap up

1. **Show the summary**:
   ```
   All commits completed for <TICKET>

   Commits:
   - [x] Commit 1: description
   - [x] Commit 2: description
   ...
   ```

2. **Ask the user**: "Everything's committed and pushed. Ready to compose the PR?"
   - "Let's go" — compose the PR with **cch-create-pr**
   - "Let me look first" — give them time to review before opening the PR
