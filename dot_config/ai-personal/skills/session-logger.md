# Session Logger Skill Guidelines

## Objective
To standardize the process of summarizing AI sessions, capturing key decisions, pending tasks, and essential context for seamless handover to future AI interactions. This ensures continuity and preserves the state of complex decision-making processes.

## Instructions for AI Action

When invoked to log a session, the AI must perform the following steps and output the result in a clean Markdown format:

1.  **Identify Final Decisions**:
    *   Review the current session's interaction history and explicitly identify all significant technical or strategic decisions that were finalized during this session.
    *   Present these decisions clearly and concisely, ideally as a bulleted list. Each decision should state what was decided and why (if context is available).
    *   Example format:
        *   Decision: Selected [Architecture/Technology X] for [Problem Y] due to [Reason Z].
        *   Decision: Implemented [Feature A] with [Scope B] after considering alternatives.

2.  **List Pending Tasks**:
    *   Identify any tasks that remain unfinished at the end of the session.
    *   List any next steps for the user or the AI in subsequent interactions.
    *   This section should be actionable and clear.
    *   Example format:
        *   Pending Task: User to review and approve the implementation plan for [Feature A].
        *   Next Step: AI to research [Specific technical aspect] for the next session.

3.  **Context Snapshot (System Prompt Fragment)**:
    *   Generate a concise fragment suitable for use as a system prompt in a subsequent AI session. This fragment should capture the essential "mental state" of the AI, including key personas, active skills, and critical context established during the session.
    *   The goal is to provide enough information for the AI to recall its current role, active directives, and critical context without needing to re-process the entire session history.
    *   This should be formatted as a series of statements or directives that can be prepended to the next prompt.
    *   Example format:
        ```
        [Previous Session Context Restored]
        Current Personas: Software Architect, Security Specialist
        Active Skills: Arch System Doctor, Session Logger
        Key Context: Decision made to use [Technology X] for [Problem Y]. Current focus is on refining [Feature A].
        ```

4.  **Output Format**:
    *   The entire output must be structured using clean Markdown.
    *   Use clear headings for each section (e.g., `## Final Decisions`, `## Pending Tasks`, `## Context Snapshot`).
    *   Ensure readability and easy parsing.

5.  **Location Agnostic Output**:
    *   The AI must *output* the generated Markdown text directly. It should *not* attempt to save the file itself.
    *   The user will be responsible for redirecting this output to a file (e.g., `DECISION_LOG.md`) in their current working directory.
