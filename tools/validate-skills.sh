#!/usr/bin/env bash
# Validate SKILL.md files in all skill directories.
# Checks for: existence, YAML frontmatter, required name/description fields.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/skills"

FAIL=0
CHECKED=0

for dir in "$SKILLS_DIR"/*/; do
  [ -d "$dir" ] || continue
  skill_name=$(basename "$dir")
  skill_md="$dir/SKILL.md"
  CHECKED=$((CHECKED + 1))

  # Check SKILL.md exists
  if [ ! -f "$skill_md" ]; then
    echo "FAIL: Missing SKILL.md in skills/$skill_name"
    FAIL=1
    continue
  fi

  # Check frontmatter delimiters
  if ! head -1 "$skill_md" | grep -q '^---'; then
    echo "FAIL: Missing opening frontmatter (---) in skills/$skill_name/SKILL.md"
    FAIL=1
    continue
  fi

  # Extract frontmatter (between first and second ---)
  frontmatter=$(sed -n '2,/^---$/p' "$skill_md" | sed '$d')

  # Check name field
  if ! echo "$frontmatter" | grep -q '^name:'; then
    echo "FAIL: Missing 'name:' in frontmatter of skills/$skill_name/SKILL.md"
    FAIL=1
  fi

  # Check description field
  if ! echo "$frontmatter" | grep -q '^description:'; then
    echo "FAIL: Missing 'description:' in frontmatter of skills/$skill_name/SKILL.md"
    FAIL=1
  fi

  # Validate name matches directory name
  actual_name=$(echo "$frontmatter" | grep '^name:' | sed 's/^name:[[:space:]]*//')
  if [ "$actual_name" != "$skill_name" ]; then
    echo "FAIL: Name mismatch in skills/$skill_name/SKILL.md — frontmatter says '$actual_name'"
    FAIL=1
  fi

  if [ $FAIL -eq 0 ]; then
    echo "OK:   skills/$skill_name"
  fi
done

echo ""
echo "Checked $CHECKED skill(s)."

# Check shared references are in sync
SHARED_REFS="$REPO_ROOT/references"
if [ -d "$SHARED_REFS" ]; then
  echo ""
  echo "Checking shared references..."
  for src in "$SHARED_REFS"/*.md; do
    [ -f "$src" ] || continue
    filename=$(basename "$src")
    for skill_ref in "$SKILLS_DIR"/*/references/"$filename"; do
      [ -f "$skill_ref" ] || continue
      skill_name=$(echo "$skill_ref" | sed "s|$SKILLS_DIR/||" | cut -d/ -f1)
      if ! diff -q "$src" "$skill_ref" &>/dev/null; then
        echo "WARN: skills/$skill_name/references/$filename is out of sync with references/$filename"
        echo "      Run ./tools/build-refs.sh to fix."
        FAIL=1
      fi
    done
  done
fi

echo ""
if [ $FAIL -ne 0 ]; then
  echo "Validation FAILED."
  exit 1
else
  echo "All skills valid."
  exit 0
fi
