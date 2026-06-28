# OpenCode skills

These files are optional task-specific instructions for OpenCode.

`AGENTS.md` contains only global minimum rules.
Read a skill only when the task matches it.

## Skills

| Skill             | Use when                                                             |
| ----------------- | -------------------------------------------------------------------- |
| `investigate.md`  | Starting a large investigation, codebase exploration, or design task |
| `irreversible.md` | Before risky, destructive, or hard-to-revert operations              |
| `verify.md`       | After making code, config, or documentation changes                  |
| `git-commit.md`   | Deciding whether to create a git commit or how to split commits      |

## Policy

- Do not read every skill by default.
- Prefer the smallest relevant skill.
- If no skill matches, follow `AGENTS.md` and the user's instruction.
- If a skill conflicts with the user's explicit instruction, ask before proceeding.
