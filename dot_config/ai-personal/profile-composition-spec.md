# AI Profile Composition Specification

## 1. Overview
This document defines the formal rules and mechanisms governing the composition of AI profiles within a tool-agnostic AI prompt framework. Its purpose is to ensure consistent, predictable, and extensible behavior when multiple profiles are applied, dictating how their individual components (e.g., includes, safety, output preferences) are resolved into a final operational context.

## 2. Terminology
*   **Profile**: A declarative configuration file defining AI behavior, includes, safety, and output preferences.
*   **YAML Front Matter**: Metadata section at the beginning of a profile file, structured in YAML format.
*   **Priority**: An integer value assigned to a profile, indicating its relative importance or precedence. Higher values denote higher priority.
*   **Stable Unique Merge**: A merging strategy for arrays where the order of the first occurrence of an element is preserved, and duplicate elements are removed.
*   **Intermediate Representation (IR)**: The final, consolidated prompt context or configuration derived from applying one or more profiles, prior to execution by an AI model.

## 3. Profile Loading Rules
Profiles are loaded based on specified criteria (e.g., user selection, context triggers). Once loaded, they are collectively processed to form a single, coherent operational context.

## 4. Priority Resolution
When multiple profiles are active, their resolution order is determined by their `priority` field.
*   **Rule**: Profiles are sorted in descending order of their `priority` value. In cases of identical `priority` values, the loading order or an internal stable sort mechanism will resolve ties.

## 5. Field Merge Rules
*   **Tags**: All `tags` from active profiles are merged using a stable unique strategy.
*   **Includes**:
    *   `includes.common`: Merged via stable unique.
    *   `includes.skills`: Merged via stable unique.
    *   `includes.personas`: Merged via stable unique.
*   **Checklist**: Merged via stable unique. The logical grouping (`global` → `execution` → `rollback`) should be preserved implicitly by design or explicitly enforced by the client.

## 6. Safety Resolution Rules
Safety parameters are critical and resolved to ensure the most restrictive posture is maintained.
*   **Level**: The `safety.level` is determined by the most restrictive level among all active profiles.
    *   **Hierarchy**: `strict` > `balanced` > `relaxed`. If any active profile specifies `strict`, the effective level is `strict`.
*   **Require**: The `safety.require` array is merged via a stable unique strategy.

## 7. Output Resolution Rules
Output preferences are resolved to ensure clarity and adherence to critical formatting requirements.
*   **Format**:
    *   If any active profile specifies `output.format: patch_first`, then `patch_first` takes precedence for the final output format.
    *   Otherwise, the `output.format` from the highest-priority active profile is selected.
*   **Verbosity**: The `output.verbosity` is determined by the most restrictive level among all active profiles.
    *   **Hierarchy**: `minimal` < `medium` < `detailed`. The effective verbosity will be `minimal` if any profile specifies it, then `medium`, then `detailed`. (`minimal` wins over `medium` and `detailed`).

## 8. Intermediate Representation (IR) Construction Order
The final prompt or context (IR) for the AI model is constructed by sequentially incorporating elements in the following order:
1.  Content derived from `includes.common`.
2.  A summary or enforcement of profile constraints.
3.  Content derived from `includes.skills`.
4.  Content derived from `includes.personas`.
5.  A summary or enforcement of merged safety and output preferences.
6.  The user's direct message or query.

## 9. Future Extension Guidelines
*   New top-level YAML keys should be introduced with clear documentation and a defined merge strategy.
*   New enum values for existing fields (e.g., `safety.level`, `output.format`) must be explicitly documented with their precedence rules.
*   Profiles should remain self-contained and avoid implicit dependencies outside their `includes` declarations.
