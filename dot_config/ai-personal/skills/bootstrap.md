# Bootstrap Skill Guidelines

## Objective
This skill ensures a thorough initialization sequence for new AI sessions. Upon activation, it scans the project environment, loads critical context, and provides a readiness summary to the user, confirming alignment with project goals and architecture before task execution begins.

## Instructions for AI Action

When this 'Bootstrap' skill is loaded, the AI must perform the following actions:

1.  **Project Overview Scan**:
    *   Search the current working directory for overview files:
        *   Prioritize `_MANIFEST.md`.
        *   If `_MANIFEST.md` is not found, look for `README.md`.
    *   If found, read and internalize the high-level description of the project's structure, goals, and conventions.

2.  **Context Restoration Scan**:
    *   Search the current working directory for `DECISION_LOG.md`.
    *   If found, read its content to understand any previously finalized decisions, pending tasks, or context snapshots from prior sessions. This information is crucial for maintaining continuity.

3.  **Acknowledge Tiering**:
    *   Refer to the `_MANIFEST.md` (if found) to understand the project's configuration loading tiers.
    *   Acknowledge the distinction between Tier 1 ('Must Read' files, like `common/`) and Tier 2 ('Load on Demand' files, like `skills/` and `personas/`). Confirm understanding of which contexts are always active and which are loaded dynamically.

4.  **Readiness Summary Report**:
    *   Based on the information gathered from the scans (overview files, decision log, tiering), generate a brief, concise 'Readiness Summary'.
    *   This summary should:
        *   Confirm that the project's foundational elements (`common/`) are understood.
        *   Acknowledge the presence and potential relevance of loaded skills and personas.
        *   Briefly state the perceived primary goals or architectural focus of the current project context, as inferred from the overview and decision logs.
        *   Conclude with a statement of readiness to proceed with the user's next task.
    *   The report should be presented directly to the user in a clear, affirmative tone.
