# Clients Directory

This directory contains client-specific adapters for the AI prompt framework.

## Purpose

The core behavior and logic of the framework are defined in:

- profiles/
- skills/
- personas/
- common/
- profile-composition-spec.md

The `clients/` directory exists only to adapt that core logic to specific AI tools or CLI environments.

---

## Design Rules

- Do not place core behavior definitions here.
- Do not redefine profile composition logic here.
- Client-specific launch scripts, configuration notes, and thin adapters are allowed.
- All files in this directory must be replaceable without modifying the core framework.

---

## Philosophy

Core logic is tool-agnostic.

Clients are adapters.
