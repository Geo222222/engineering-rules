#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: $0 /path/to/target-repo [--force]" >&2
  exit 2
fi

TARGET="$(cd "$1" && pwd)"
FORCE="${2:-}"
SOURCE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

FILES=(
  "AGENTS.md"
  ".github/copilot-instructions.md"
  ".github/instructions/code-style.instructions.md"
  ".github/instructions/safety-architecture.instructions.md"
  ".github/instructions/workflow-testing.instructions.md"
  ".vscode/settings.json"
  "docs/engineering/ARCHITECTURE.md"
  "docs/engineering/PRODUCT.md"
  "docs/engineering/TESTING.md"
  "docs/engineering/PROJECT_OVERRIDES.md"
)

for rel in "${FILES[@]}"; do
  src="$SOURCE_ROOT/$rel"
  dst="$TARGET/$rel"

  if [[ -e "$dst" && "$FORCE" != "--force" ]]; then
    echo "Refusing to overwrite existing file: $dst" >&2
    echo "Re-run with --force only after reviewing the existing project rules." >&2
    exit 1
  fi

  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  echo "Installed $rel"
done

echo "Engineering rules installed into $TARGET"
echo "Next: replace docs/engineering templates with facts derived from the target repository."
