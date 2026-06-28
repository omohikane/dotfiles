# Git commit

Read this when deciding whether to create a git commit during a task.

## Goal

Keep work recoverable without creating noisy or unrelated commits.

## Suggest a commit when

Suggest a commit when:

- one logical unit of work is complete
- the diff is becoming too large to review comfortably
- a risky operation is next
- a long task is pausing or switching context
- the user explicitly asks

Do not create a commit without user approval.

## Do not propose a commit when

Do not propose a commit when:

- the edit is still incomplete
- the tree is broken and the user did not ask for a WIP commit
- unrelated user changes are mixed in
- the commit would include files outside the task scope
- the diff has not been reviewed with `git status` and `git diff`

If unrelated changes are present, report them and ask how to proceed.

## Granularity

Use one commit for one reviewable intent.

Split before committing when:

- refactoring and behaviour changes are mixed
- unrelated changes were made for different reasons
- formatter or linter changes touched files outside the task scope
- the reviewer could not describe the commit in one sentence

Do not split into tiny commits for trivial edits unless the user asks.

## Commit message

Follow the repository convention if one exists.

If no convention is found, use:

- English
- imperative mood
- short summary, preferably under 72 characters
- no trailing period

Use a type prefix only when the repository already uses one.

Examples:

- `Fix LiteLLM model fallback`
- `Refactor OpenCode agent config`
- `Update git commit guidance`

## Before committing

Before proposing a commit, show:

- `git status`
- relevant `git diff` or `git diff --stat`
- proposed commit message
- files intended to be staged

Ask once:

`Commit?`

Do not stage or commit files outside the proposed scope.
