#!/usr/bin/env bash
# Keep the newest N non-draft GitHub Releases; delete older ones and their tags.
set -euo pipefail

REPO="${1:?repo owner/name required}"
KEEP_COUNT="${2:-3}"
if ! [[ "$KEEP_COUNT" =~ ^[1-9][0-9]*$ ]]; then
  echo "KEEP_COUNT must be a positive integer (got: $KEEP_COUNT)" >&2
  exit 1
fi
if [[ -z "${GH_TOKEN:-}" ]]; then
  echo "GH_TOKEN is not set; cannot clean $REPO" >&2
  exit 1
fi

echo "Cleaning $REPO (keep $KEEP_COUNT non-draft releases)..."

mapfile -t tags < <(
  gh release list -R "$REPO" --limit 100 --json tagName,isDraft,createdAt \
    --jq 'sort_by(.createdAt) | reverse | .[] | select(.isDraft|not) | .tagName'
)

total=${#tags[@]}
echo "Found $total non-draft release(s)."
if (( total <= KEEP_COUNT )); then
  echo "Nothing to delete."
  exit 0
fi

for (( i=KEEP_COUNT; i<total; i++ )); do
  tag="${tags[$i]}"
  echo "Deleting $REPO@$tag"
  gh release delete "$tag" -R "$REPO" --yes --cleanup-tag
done

echo "Done. Remaining:"
gh release list -R "$REPO" --limit "$KEEP_COUNT"
