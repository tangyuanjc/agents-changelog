#!/usr/bin/env bash
set -euo pipefail

# Best-effort classifier for historical agents-changelog headings.
# Dry-run only by default: prints suggested type tags without modifying history.
# Usage: tools/tag-history.sh [CHANGELOG.md]

file="${1:-CHANGELOG.md}"
if [[ ! -f "$file" ]]; then
  echo "missing changelog: $file" >&2
  exit 1
fi

awk '
/^#{2,3} / {
  line=$0
  type="c"
  if (line ~ /AGENTS|宪法|黑板|架构|C-level|12 字段|schema|SCHEMA|协议/) type="a"
  else if (line ~ /派单|dispatch|Paperclip|issue|assignee|Codex|Opus|爱马仕/) type="b"
  print type "\t" line
}
' "$file"
