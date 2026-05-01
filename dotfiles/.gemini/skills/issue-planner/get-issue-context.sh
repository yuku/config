#!/bin/bash

ISSUE_NUMBER=$1

if [ -z "$ISSUE_NUMBER" ]; then
  echo "Usage: ./get-issue-context.sh <issue-number>"
  exit 1
fi

MARKER="<!-- gemini issue-planner -->"

ISSUE_JSON=$(gh issue view "$ISSUE_NUMBER" --json title,body,comments,author)

echo "$ISSUE_JSON" | jq -r --arg marker "$MARKER" '
  "# Title: \(.title)\n\n## Body\n\(.body)\n\n## Comments\n" as $header |
  .comments as $all_comments |
  
  # Find the latest comment that contains the marker and get its ID
  ($all_comments | map(select(.body | contains($marker))) | last | .id) as $latest_plan_id |
  
  ($all_comments | map(
    select((.body | contains($marker) | not) or .id == $latest_plan_id) |
    "### Comment by \(.author.login)\n\(.body)\n"
  ) | join("\n")) as $formatted_comments |
  
  $header + $formatted_comments
'
