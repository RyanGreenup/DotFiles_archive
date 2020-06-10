#!/usr/bin/env bash
set -euo pipefail

command -v highlight >/dev/null 2>&1 || { echo >&2 "The highlight package is a required dependency"; exit 1; }

echo Enter the Search Query
read -p 'Search: ' query
echo searching for $query

# recoll -b -t -q "ext:md $query" | cut -c 8- |  fzf --preview "highlight -O ansi -l {}" | xargs code -a
# recoll -b -t -q "ext:md $query" | cut -c 8- |  fzf --bind up:preview-up,down:preview-down --preview "mdcat {}" | xargs code -a
recoll -b -t -q "ext:md $query" | cut -c 8- |  fzf --bind pgup:preview-page-up,pgdn:preview-page-down --preview "mdcat {}" | xargs code -a
