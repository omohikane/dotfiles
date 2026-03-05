# Tools Directory

## Overview
This `tools/` directory contains helper scripts designed to facilitate interaction with AI clients. These scripts provide operational convenience only and do NOT define the core AI behavior.

The authoritative behavior logic is defined in:
- `profiles/`
- `profile-composition-spec.md`

Tools are adapters. Profiles and specifications are the source of truth.

---

## Loader and Command Scripts

- **`loader.sh`**  
  A shell script that prepares the environment and invokes profile loading workflows.  
  It does not implement profile composition logic itself; it relies on the framework rules defined in `profile-composition-spec.md`.

- **`gemini-commands.fish`**  
  A Fish shell helper script providing command-line utilities for interacting with AI clients.  
  It acts as a thin adapter layer and does not contain behavioral definitions.

---

## Path Handling Rules

Do not use `~` (tilde) in file path instructions.

Always use either:
- Absolute paths (e.g., `/home/user/.config/ai-personal/...`)
- The `$HOME` environment variable (e.g., `$HOME/.config/ai-personal/...`)

Some AI clients and execution environments do not expand `~`, which can cause unintended directory creation or path errors.

---

## Design Principle

The tools in this directory are intentionally replaceable.

As long as a tool respects:
- The structure of `profiles/`
- The rules defined in `profile-composition-spec.md`

it can be swapped without affecting the framework's behavior.
