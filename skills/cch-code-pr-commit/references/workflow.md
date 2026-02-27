# How to advance a commit

**Nothing gets committed until both the code checks and the human sign-off are done.**

---

## Figure out the ticket

The ticket is optional. If not provided, pull it from the branch name.

**If given directly:**
- Use it as-is

**If not:**
1. Grab the branch name:
   ```bash
   git branch --show-current
   ```
2. Look for a ticket pattern: `[A-Z]+-[0-9]+` (e.g., `PROJ-123`, `TEAM-456`)
   - `PROJ-123-description` → `PROJ-123`
   - `feature/PROJ-123` → `PROJ-123`
   - `user/PROJ-123-some-work` → `PROJ-123`
3. If found: "Detected ticket from branch: \<ticket\>"
4. If not found: stop and surface the error

---

## Track your progress

Set up a task list:

- Figure out the ticket
- Track your progress
- Open the blueprint
- Write the code
- Run the type checker (if applicable)
- Run the linter
- Pause for sign-off
- Save your work
- What's next

Check each off as you go.

---

## Open the blueprint

- Open `./.cch/<TICKET>_blueprint.md`
- Confirm the **Branch** matches your current branch (`git branch --show-current`)
  - Mismatch? Flag it and wait for the user's call
- Find the first unchecked `[ ]` item in the **Commit checklist**
- If nothing's left, you're done: **"All commits completed."**

---

## Write the code

- Work on **only this commit**. Don't get ahead of yourself.
- If the blueprint has a **Design Patterns** section, follow the proposed patterns where they fit naturally. Don't force them if this commit doesn't call for it.
- Write clean code in every line: meaningful names, small focused functions, single responsibility, DRY. If you spot a smell in code you're touching, clean it up in the same commit if it's a quick fix.
- **If this is a test commit:**
  - Write the failing tests only
  - Run them and confirm they **fail for the expected reason** before moving on
- **If this is an implementation commit:**
  - Write the minimum code to make the tests pass
  - Refactor if it helps

---

## Run the type checker (typed languages)

- Run the type checker if the language supports it (TypeScript, Python with type hints, etc.)
- Zero type errors — that's the bar
- Only fix errors directly related to this commit's changes

---

## Run the linter

- Run the linter for code quality
- **Only fix lint errors on lines you changed in this commit**
- Leave pre-existing issues alone unless they're blocking the build

---

## Pause for sign-off

**Stop here — nothing gets committed without a thumbs-up from the human.**

They need to:
- Review the changes
- Decide what feedback to act on
- Tell you what to adjust (if anything)
- Give the go-ahead

---

## Save your work

**Only after sign-off.**

- Commit with clean git hygiene
- Mark the checklist item as `[x]` in the blueprint

---

## What's next

Check the blueprint for remaining work:

1. Open `./.cch/<TICKET>_blueprint.md`
2. Look at the **Commit checklist**
3. Any unchecked items left?

**More to do?** Pick up the next commit with **cch-code-pr-commit**.

**All done?** Compose the pull request with **cch-create-pr**.
