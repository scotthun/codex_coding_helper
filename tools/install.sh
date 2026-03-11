#!/usr/bin/env bash
# CCH Skill Pack Installer
# Portable installer — requires only curl+unzip or git. No Python needed.
#
# Usage:
#   ./tools/install.sh                              # install all skills
#   ./tools/install.sh cch-pr-plan cch-create-pr # install selected
#   ./tools/install.sh --ref v1.0.0                 # pinned version
#   ./tools/install.sh --ref v1.0.0 cch-pr-plan  # pinned + selected
#   ./tools/install.sh --force                       # overwrite existing
#
# Remote one-liner (install all skills without cloning):
#   curl -fsSL https://raw.githubusercontent.com/scotthun/codex_coding_helper/main/tools/install.sh | bash
#
# Environment:
#   CODEX_HOME   — override skill install location (default: ~/.codex)
#   GITHUB_TOKEN — for private repo access (also accepts GH_TOKEN)

set -euo pipefail

REPO="scotthun/codex_coding_helper"
DEFAULT_REF="main"
ALL_SKILLS=(cch-pr-plan cch-code-pr-commit cch-create-pr cch-review-pr cch-code-all-pr-commits)

# --- Parse arguments ---
REF="$DEFAULT_REF"
FORCE=false
SKILLS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --ref)
      REF="${2:?'--ref requires a value (e.g., v1.0.0, main)'}"
      shift 2
      ;;
    --force|-f)
      FORCE=true
      shift
      ;;
    --help|-h)
      echo "Usage: $0 [--ref <tag/branch>] [--force] [skill-name ...]"
      echo ""
      echo "Install CCH skills into \${CODEX_HOME:-~/.codex}/skills/"
      echo ""
      echo "Options:"
      echo "  --ref <ref>   Git ref to install from (default: main)"
      echo "  --force, -f   Overwrite existing skills"
      echo "  --help, -h    Show this help"
      echo ""
      echo "Available skills:"
      for s in "${ALL_SKILLS[@]}"; do echo "  $s"; done
      echo ""
      echo "Examples:"
      echo "  $0                              # install all skills"
      echo "  $0 cch-pr-plan cch-create-pr # install selected"
      echo "  $0 --ref v1.0.0                 # pinned version"
      exit 0
      ;;
    -*)
      echo "Error: Unknown option: $1" >&2
      echo "Run '$0 --help' for usage." >&2
      exit 1
      ;;
    *)
      SKILLS+=("$1")
      shift
      ;;
  esac
done

# Default to all skills if none specified
if [[ ${#SKILLS[@]} -eq 0 ]]; then
  SKILLS=("${ALL_SKILLS[@]}")
fi

# Validate skill names
for skill in "${SKILLS[@]}"; do
  found=false
  for valid in "${ALL_SKILLS[@]}"; do
    if [[ "$skill" == "$valid" ]]; then
      found=true
      break
    fi
  done
  if [[ "$found" == "false" ]]; then
    echo "Error: Unknown skill '$skill'" >&2
    echo "Available skills: ${ALL_SKILLS[*]}" >&2
    exit 1
  fi
done

# --- Resolve paths ---
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
SKILLS_DIR="$CODEX_HOME/skills"
TMPDIR_BASE="${TMPDIR:-/tmp}"
WORK_DIR=$(mktemp -d "$TMPDIR_BASE/cch-install.XXXXXX")

cleanup() {
  rm -rf "$WORK_DIR"
}
trap cleanup EXIT

# --- Auth header ---
TOKEN="${GITHUB_TOKEN:-${GH_TOKEN:-}}"
auth_header() {
  if [[ -n "$TOKEN" ]]; then
    echo "Authorization: token $TOKEN"
  fi
}

# --- Download methods ---
download_zip() {
  local zip_url="https://codeload.github.com/$REPO/zip/$REF"
  local zip_path="$WORK_DIR/repo.zip"

  echo "Downloading $REPO@$REF..."

  local curl_args=(-fsSL -o "$zip_path")
  if [[ -n "$TOKEN" ]]; then
    curl_args+=(-H "Authorization: token $TOKEN")
  fi

  if curl "${curl_args[@]}" "$zip_url"; then
    echo "Extracting..."
    unzip -q "$zip_path" -d "$WORK_DIR"
    # GitHub zips have a top-level dir like repo-name-ref/
    REPO_ROOT=$(find "$WORK_DIR" -mindepth 1 -maxdepth 1 -type d ! -name "*.zip" | head -1)
    return 0
  else
    return 1
  fi
}

clone_repo() {
  echo "Falling back to git clone..."
  local repo_url="https://github.com/$REPO.git"
  if [[ -n "$TOKEN" ]]; then
    repo_url="https://x-access-token:$TOKEN@github.com/$REPO.git"
  fi

  REPO_ROOT="$WORK_DIR/repo"
  if git clone --depth 1 --branch "$REF" "$repo_url" "$REPO_ROOT" 2>/dev/null; then
    return 0
  fi

  # Try SSH as last resort
  echo "HTTPS clone failed, trying SSH..."
  if git clone --depth 1 --branch "$REF" "git@github.com:$REPO.git" "$REPO_ROOT" 2>/dev/null; then
    return 0
  fi

  return 1
}

# --- Install ---
echo "CCH Skill Pack Installer"
echo "========================"
echo "Skills to install: ${SKILLS[*]}"
echo "Version: $REF"
echo "Target: $SKILLS_DIR"
echo ""

# Download repo
REPO_ROOT=""
if command -v curl &>/dev/null && command -v unzip &>/dev/null; then
  download_zip || clone_repo || { echo "Error: Failed to download skills." >&2; exit 1; }
elif command -v git &>/dev/null; then
  clone_repo || { echo "Error: Failed to clone repo." >&2; exit 1; }
else
  echo "Error: Need either curl+unzip or git installed." >&2
  exit 1
fi

# Install each skill
mkdir -p "$SKILLS_DIR"
installed=0
skipped=0

for skill in "${SKILLS[@]}"; do
  src="$REPO_ROOT/skills/$skill"
  dest="$SKILLS_DIR/$skill"

  if [[ ! -d "$src" ]]; then
    echo "Warning: Skill directory not found in repo: skills/$skill" >&2
    continue
  fi

  if [[ ! -f "$src/SKILL.md" ]]; then
    echo "Warning: No SKILL.md found in $skill — skipping" >&2
    continue
  fi

  if [[ -d "$dest" ]]; then
    if [[ "$FORCE" == "true" ]]; then
      echo "Overwriting $skill..."
      rm -rf "$dest"
    else
      echo "Skipping $skill (already installed). Use --force to overwrite."
      skipped=$((skipped + 1))
      continue
    fi
  fi

  cp -R "$src" "$dest"
  echo "Installed $skill -> $dest"
  installed=$((installed + 1))
done

echo ""
echo "Done! Installed: $installed, Skipped: $skipped"

if [[ $installed -gt 0 ]]; then
  echo ""
  echo "Restart Codex to pick up new skills."
fi
