#!/bin/bash

ISSUE_NUMBER=$1
PLAN_FILE=$2

if [ -z "$ISSUE_NUMBER" ] || [ -z "$PLAN_FILE" ]; then
  echo "Usage: ./publish-plan.sh <issue-number> <plan-file>"
  exit 1
fi

MARKER="<!-- gemini issue-planner -->"

# 1. hide outdated comments
NODE_IDS=$(gh issue view "$ISSUE_NUMBER" --json comments -q ".comments[] | select(.body | contains(\"$MARKER\")) | .id")

for ID in $NODE_IDS; do
  gh api graphql -F subjectId="$ID" -F classifier="OUTDATED" -f query='
    mutation MinimizeComment($subjectId: ID!, $classifier: ReportedContentClassifiers!) {
      minimizeComment(input: {subjectId: $subjectId, classifier: $classifier}) {
        minimizedComment { isMinimized }
      }
    }' > /dev/null
done

# 2. post new plan
TEMP_FILE=$(mktemp)
echo "$MARKER" > "$TEMP_FILE"
echo "" >> "$TEMP_FILE"
cat "$PLAN_FILE" >> "$TEMP_FILE"


gh issue comment "$ISSUE_NUMBER" --body-file "$TEMP_FILE"
POST_STATUS=$?

rm "$TEMP_FILE"

if [ $POST_STATUS -eq 0 ]; then
  echo "✅ successfully posted the plan to Issue #$ISSUE_NUMBER."
else
  echo "❌ failed to post the plan to Issue #$ISSUE_NUMBER."
  exit 1
fi
