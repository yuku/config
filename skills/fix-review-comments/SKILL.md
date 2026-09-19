---
name: fix-review-comments
description: Review the latest review findings, accept only valid ones, and apply the necessary fixes.
user_invocable: true
---

# fix-review-comments

Review the latest review comments and apply changes only for findings that are valid.
Reviewers are not always correct, so each comment should be evaluated critically.

## Review flow

1. Identify the review findings from the previous conversation
2. Evaluate each finding
   - Is it technically correct?
   - Does it match the project context and goals?
   - Is it a valid trade-off in the current implementation?
3. Apply only the findings that are valid
4. Output a final summary

## Validity criteria

- Do not accept reviewer comments without checking their technical validity
- If a comment is not applied, explain why in a way the reviewer can understand
- Check whether the fix introduces a new problem

## Final summary format

After finishing the fix, output a summary in the following format.
The goal is to let the user double-check whether the fix decisions were appropriate.
Do not omit the original issue or the reason for the decision.

### Required writing rules

For each finding, include all of the following three points:

1. **Header**: use the format `Reviewer identifier: issue summary`
   - Use the reviewer name and number exactly as shown in the review output, such as `reviewer #1`, `simplify #3`, or `codex #1`
   - If multiple reviewers mention the same issue, combine them, such as `reviewer #5 / simplify #3`
2. **Issue description**: explain what the reviewer was concerned about
3. **Fix or reason**: explain what changed or why the issue was not addressed

### Output template

```markdown
## Review Response Summary

### Applied findings

#### reviewer #1: unclear counting of follow-up interactions
- **Issue description**: It is unclear whether bug-only follow-up replies count toward the maximum of three interactions after the first one.
- **Fix**: The note was clarified to say that bug-only replies do not count toward the maximum, and the count starts when deeper feedback begins.

#### reviewer #5 / simplify #3: section ordering
- **Issue description**: The “bug report guidance” section appears immediately after the output field description, which makes the flow harder to follow.
- **Fix**: The “bug report guidance” section was moved just before the interaction flow so the sequence reads: role -> collection -> criteria -> flow -> output format -> rules.

### Not applied findings

#### reviewer #2: handling the path where only bug guidance is given
- **Issue description**: It may not account for the case where the process ends after only a bug guidance message and no spreadsheet record is created.
- **Reason not applied**: The requirement explicitly says that a guidance-only ending does not require spreadsheet recording. The design is intentional, and adding this note would be unnecessary.

#### reviewer #3: missing three-point explanation in step 4
- **Issue description**: When feedback is unclear, step 4 should explain three points, but this is not explicitly described.
- **Reason not applied**: The instructions in step 2 and later already cover step 4. Adding another explicit list would be redundant.
```

## Compatibility rule

Keep the following naming and output conventions stable so the review system remains compatible across English-language prompts:

- `reviewer #1`
- `simplify #3`
- `reviewer #5 / simplify #3`
- `Applied findings`
- `Not applied findings`
- `Issue description`
- `Fix`
- `Reason not applied`

The protocol must stay the same even when the surrounding text is written in simple English.

