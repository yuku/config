---
name: self-review
description: Run a self-review of local code with reviewer agents and apply fixes only for valid findings.
argument-hint: [review target] [reviewer name]
user-invocable: true
---

Follow these steps in order.

## Step 1: Parse the arguments

Interpret $ARGUMENTS using these rules:

- First argument: review target. If omitted, use `diff` = current unstaged changes + untracked files.
- Second argument: reviewer name. If omitted, run all reviewers in parallel.

### Review target formats

- No argument or `diff`: use `git diff` + `git ls-files --others --exclude-standard` to include new files
- `staged`: use `git diff --cached`
- `branch`: use `git diff origin/main...HEAD`
- `PR #123` or `pr 123`: use `gh pr diff 123`
- Any other value: pass it through as-is

### Available reviewer names

- `reviewer` - general review of quality, security, and performance
- `simplify-reviewer` - review focused on readability, consistency, and maintainability
- `code-comment-reviewer` - review focused on comments that are useless, stale, harmful, or noisy

If the reviewer name does not match one of the names above, return an error and tell the user which reviewer names are valid.

## Step 2: Run the review

- If a reviewer name is specified: start that reviewer agent and pass it the review target.
- If the reviewer name is omitted: start all reviewer agents in parallel and pass them the same review target.

## Step 3: Apply the review feedback

After all reviews finish, run the `/fix-review-comments` skill and apply only the valid review findings.

## Compatibility rule

Keep the following names and values stable across the full review flow:

- `reviewer`
- `simplify-reviewer`
- `code-comment-reviewer`
- `diff`
- `staged`
- `branch`
- `PR #123`
- `fix-review-comments`

The protocol must remain compatible even when the surrounding text is written in English.
