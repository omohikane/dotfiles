# Conventions

Guidelines for extending the AI personal framework.

## Profiles

Profiles define operational environments.

Rules:

- One domain per profile
- Profiles may include personas and skills
- Profiles should define output format and safety requirements

Examples:
- infra
- coding
- infra-panel


## Personas

Personas represent expert viewpoints.

Rules:

- Personas define thinking style, not behaviour rules
- Avoid overlapping personas


## Skills

Skills provide specialised knowledge or workflows.

Rules:

- Skills should be reusable across profiles
- Skills should represent concrete capabilities


## Tasks

Tasks define reusable instructions.

Rules:

- Add tasks only for common workflows
- Prefer using `select-and-run` instead of creating many tasks


## General principle

Keep the framework:

- modular
- predictable
- minimal
