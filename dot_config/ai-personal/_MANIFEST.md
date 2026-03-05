# AI Personal Configuration Manifest

This document provides an overview of the AI personal configuration directory structure and the loading hierarchy of its components.

## Directory Structure Overview

The AI personal configuration is organized into the following primary directories:

*   **`common/`**:
    *   Contains foundational rules and personal identity documents that apply universally to all AI interactions.
    *   Includes core working style guidelines and brand voice definitions.

*   **`personas/`**:
    *   Houses various persona definitions, each representing a distinct role or character that the AI can adopt.
    *   These personas are further categorized into subdirectories (e.g., `business/`, `philosophy/`, `mind/`, `strategy/`) for better organization.

*   **`skills/`**:
    *   Contains specific instructions and guides for executing technical tasks or specialized functions.
    *   These are designed to augment the AI's capabilities for particular domains.

*   **`tools/`**:
    *   Includes shell scripts and integration utilities that provide convenient command-line access to AI functionalities.

## Configuration Loading Tiers

To manage complexity and optimize performance, configurations are loaded according to the following tiers:

*   **Tier 1: Must Read (Always Loaded)**
    *   **`common/` directory**: All files within `common/` (e.g., `working-style.md`, `brand-voice.md`) are considered essential and are loaded by default at the beginning of most AI interactions. These establish the AI's fundamental operating principles and communication style.

*   **Tier 2: Load on Demand (Contextual Loading)**
    *   **`personas/`**: Specific persona files are loaded when an AI is instructed to adopt a particular role or when a persona-based interaction is initiated. Subdirectories allow for selective loading of relevant personas.
    *   **`skills/`**: Skill instruction files are loaded when the AI is directed to perform a task that requires a specific skill set or technical procedure.
    *   **`tools/`**: Shell integration scripts are typically sourced by the user's shell environment and are not directly loaded by the AI core, but they orchestrate AI calls that *do* load specific system prompts (skills/personas).

This tiered approach ensures that the AI always operates with its core identity and rules, while dynamically incorporating specialized knowledge and roles as needed for specific tasks.
