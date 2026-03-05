# ai-personal

A modular prompt framework for AI tools.

This repository defines reusable components that control AI behaviour in a
structured and predictable way.

It is designed for use with command-line AI tools such as:

- Gemini CLI
- aider
- other LLM clients

The framework separates **behaviour**, **expert roles**, and **task templates**
so that AI responses become consistent and easier to control.

---

# Structure


ai-personal/
├── common/
│ Base behaviour and communication style
│
├── profiles/
│ Operational environments (infra, coding, etc.)
│
├── personas/
│ Expert roles and thinking styles
│
├── skills/
│ Specialised capabilities
│
├── tasks/
│ Reusable task templates that guide AI behaviour
│
├── clients/
│ Client-specific integrations (fish helpers, CLI adapters)
│
└── tools/
Utility scripts used by the framework


---

# Core Concept

The framework works by combining three elements:

### Profile
Defines the **environment and rules** for the task.

Examples:

- infrastructure operations
- coding tasks
- architecture reviews

### Persona
Defines the **perspective or role** the AI should adopt.

Examples:

- software architect
- SRE expert
- devil’s advocate

### Skill
Provides **specialised knowledge or behaviour**.

Examples:

- Arch Linux troubleshooting
- Git worktree workflows
- autonomous agent workflows

---

# Task Templates

`tasks/` provides reusable instructions that help the AI select the correct
profiles, personas and skills automatically.

Example:


tasks/select-and-run.md


This task allows the AI to:

1. read `AI_INDEX.md`
2. choose appropriate profiles/personas
3. execute the task using the selected configuration

---

# Example Workflow

Example prompt:


Use tasks/select-and-run.md and AI_INDEX.md.

Task:
Design a network change plan for adding a new VLAN to a Proxmox cluster.


The AI will:

1. select `infra-panel`
2. add personas such as `sre-expert`
3. generate a structured response including impact analysis and rollback.

---

# Goals

This framework aims to make AI interactions:

- predictable
- modular
- reusable
- safe for infrastructure and development work

---

# Status

Personal framework used for:

- infrastructure design
- automation development
- AI-assisted coding
- architecture review
