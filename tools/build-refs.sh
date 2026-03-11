#!/usr/bin/env bash
# Build shared references into skills that need them.
#
# Source of truth: references/ (repo root)
# Copies go into each skill's references/ directory.
#
# Run this after editing any file in references/ to keep skills in sync.
#
# Usage:
#   ./tools/build-refs.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SHARED_REFS="$REPO_ROOT/references"

# Define which shared references each skill needs.
# Format: "skill-name:filename skill-name:filename ..."
MAPPINGS=(
  "cch-pr-plan:design-patterns.md"
  "cch-pr-plan:clean-code.md"
  "cch-code-pr-commit:clean-code.md"
  "cch-review-pr:clean-code.md"
  "cch-code-all-pr-commits:clean-code.md"
)

copied=0
errors=0

for mapping in "${MAPPINGS[@]}"; do
  skill="${mapping%%:*}"
  file="${mapping##*:}"
  src="$SHARED_REFS/$file"
  dest="$REPO_ROOT/skills/$skill/references/$file"

  if [[ ! -f "$src" ]]; then
    echo "ERROR: Source not found: references/$file"
    errors=$((errors + 1))
    continue
  fi

  # Only copy if different (or missing)
  if [[ -f "$dest" ]] && diff -q "$src" "$dest" &>/dev/null; then
    echo "OK:     skills/$skill/references/$file (up to date)"
  else
    cp "$src" "$dest"
    echo "COPIED: skills/$skill/references/$file"
    copied=$((copied + 1))
  fi
done

echo ""
echo "Done. Copied: $copied, Errors: $errors"

if [[ $errors -gt 0 ]]; then
  exit 1
fi
