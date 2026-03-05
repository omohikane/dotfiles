# AI Personal Framework Index

This repository defines reusable prompts and behavioural modules for AI tools.
Use this index to understand which component to load for a given task.

The system is composed of:

- **profiles** → task environments
- **personas** → thinking styles / roles
- **skills** → specialised capabilities
- **common** → base behaviour and voice

When solving a task, select:

1. the appropriate **profile**
2. optional **personas**
3. optional **skills**

---

# Profiles

Profiles define the **operational environment** and output expectations.

### infra
Infrastructure work.

Use when the task involves:

- servers
- networking
- ansible
- system configuration
- operations

Characteristics:

- stability focused
- safe changes
- verification and rollback required

---

### infra-panel
Architecture and infrastructure design review.

Use when the task involves:

- system architecture
- network design
- infrastructure planning
- failure analysis

Characteristics:

- multi-perspective review
- risk assessment
- blast radius analysis

---

### coding
Software development and automation.

Use when the task involves:

- writing code
- editing code
- refactoring
- scripting
- development tooling

Characteristics:

- patch-first responses
- verification steps
- rollback procedures

---

# Skills

Skills provide **specialised expertise** that can be combined with profiles.

### arch-system-doctor
Troubleshooting and repairing Arch Linux systems.

### git-worktree-manager
Advanced Git workflows using worktrees.

### autonomous-agent-workflow
Running structured multi-step AI workflows.

### bootstrap
Environment setup and initialisation tasks.

### session-logger
Tracking and summarising task sessions.

### ctf-solver
Security analysis and CTF-style problem solving.

---

# Personas

Personas define **thinking styles or expert roles**.

## Professionals

### software-architect
System architecture and design decisions.

### sre-expert
Reliability, operations, and infrastructure expertise.

### logical-critic
Critical analysis and logical validation.

### devils-advocate
Identify risks, weaknesses, and hidden assumptions.

### expert-panel
Combine multiple expert viewpoints.

### performance-coach
Efficiency and optimisation advice.

### ux-pm-expert
Product thinking and user experience.

### blue-team-lead
Defensive security and monitoring.

### creative-director
Creative framing and communication.

### content-planner
Content structure and narrative planning.

---

## Security

### code-exploiter
Code vulnerability analysis.

### shadow-architect
Security-focused system design.

### social-imposter
Adversarial thinking about social engineering.

---

## Strategy

### sun-tzu
Strategic thinking and planning.

### oda-nobunaga
Aggressive execution strategy.

---

## Philosophy / Mind

### miyamoto-musashi
Discipline, focus, and mastery.

### yoshida-shoin
Radical strategic thinking.

### laozi
Minimalism and simplicity.

### nietzsche
Critical and philosophical reflection.

---

# Common Context

These files are always loaded as base behaviour.

common/working-style.md  
Defines working principles and behaviour.

common/brand-voice.md  
Defines tone and communication style.

_MANIFEST.md  
Defines framework structure.

---

# Selection Guidelines

When a task is given:

1. Identify the **domain**
2. Select the appropriate **profile**
3. Add **personas** if a specific perspective is useful
4. Add **skills** if specialised knowledge is needed

Example:

Infrastructure change review:

profile:
- infra-panel

personas:
- sre-expert
- devils-advocate

skills:
- session-logger

---

# Goal

This framework exists to make AI behaviour:

- predictable
- reusable
- modular
- safe for infrastructure and development tasks
