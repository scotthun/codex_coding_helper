# Codex Coding Helper (CCH)

A skill pack for [Codex](https://developers.openai.com/codex) that provides a structured, TDD-driven development workflow — from planning through PR creation. Includes built-in guidance for design patterns and clean code principles.

## Skills

| Skill | Description |
|-------|-------------|
| **cch-pr-plan** | Plan ticket implementation — analyzes codebase, proposes design patterns and notes code quality concerns, creates a structured blueprint |
| **cch-code-pr-commit** | Execute the next planned commit with TDD workflow, clean code principles, and human review |
| **cch-create-pr** | Generate a comprehensive PR description and create the pull request |
| **cch-review-pr** | Review code quality, design patterns, code smells, and SOLID principles for a pull request |
| **cch-code-all-pr-commits** | Complete all planned commits in a single session with clean code principles |

## Installation

### Method 1: Official Codex Skill Installer (recommended)

From inside Codex, use the built-in `$skill-installer`:

```
$skill-installer install https://github.com/scotthun/codex_coding_helper/tree/main/skills/cch-pr-plan
```

Install multiple skills:

```
$skill-installer install from scotthun/codex_coding_helper: cch-pr-plan, cch-code-pr-commit, cch-create-pr, cch-review-pr, cch-code-all-pr-commits
```

Pinned to a specific version:

```
$skill-installer install https://github.com/scotthun/codex_coding_helper/tree/v1.0.0/skills/cch-pr-plan
```

### Method 2: Portable Bash Installer (no Python required)

Clone the repo and run:

```bash
git clone https://github.com/scotthun/codex_coding_helper.git
cd codex_coding_helper
./tools/install.sh
```

Or install without cloning:

```bash
curl -fsSL https://raw.githubusercontent.com/scotthun/codex_coding_helper/main/tools/install.sh | bash
```

Install selected skills only:

```bash
./tools/install.sh cch-pr-plan cch-create-pr
```

Pinned to a specific version:

```bash
./tools/install.sh --ref v1.0.0
```

Overwrite existing installations:

```bash
./tools/install.sh --force
```

### After installing

Restart Codex to pick up new skills.

## Uninstalling

Remove a skill by deleting its directory:

```bash
rm -rf ~/.codex/skills/cch-pr-plan
```

Or remove all CCH skills:

```bash
rm -rf ~/.codex/skills/cch-*
```

Restart Codex after uninstalling.

## Workflow

The typical workflow using these skills:

1. **Plan** — `cch-pr-plan` analyzes the ticket and codebase, produces a blueprint
2. **Code** — `cch-code-pr-commit` executes commits one at a time with human review
3. **PR** — `cch-create-pr` generates a description and opens the pull request
4. **Review** — `cch-review-pr` performs code quality review on any PR

For faster execution, use `cch-code-all-pr-commits` to run all planned commits in a single session.

See [docs/WORKFLOW.md](docs/WORKFLOW.md) for the full diagram, including the human
review checkpoints at each stage and how review findings loop back into coding.

## Built-in References

Skills include shared reference guides that the agent loads on demand:

| Reference | Used by | Description |
|-----------|---------|-------------|
| **design-patterns.md** | cch-pr-plan | Core GoF patterns with [Refactoring Guru](https://refactoring.guru/design-patterns) links and "when to use" guidance |
| **clean-code.md** | cch-pr-plan, cch-code-pr-commit, cch-review-pr, cch-code-all-pr-commits | SOLID principles, code smells catalog, and refactoring techniques with [Refactoring Guru](https://refactoring.guru/refactoring/smells) links |

These are not rigid rules — the agent uses its judgment to apply them when relevant.

## Development

### Validate skills

```bash
./tools/validate-skills.sh
```

This checks SKILL.md frontmatter and verifies shared references are in sync.

### Shared references

Reference files like `design-patterns.md` and `clean-code.md` live in `references/` at the repo root (single source of truth) and are copied into each skill that needs them.

**After editing a shared reference:**

```bash
./tools/build-refs.sh    # copy updated refs into skills
./tools/validate-skills.sh  # verify everything is in sync
```

The validation script will warn if any skill's copy is out of date.

### Local development

Symlink skills directly for testing (no install needed):

```bash
for skill in skills/cch-*/; do
  ln -sf "$(pwd)/$skill" ~/.codex/skills/$(basename "$skill")
done
```

Restart Codex after symlinking. Edits to skill files take effect on next restart.

## License

MIT
