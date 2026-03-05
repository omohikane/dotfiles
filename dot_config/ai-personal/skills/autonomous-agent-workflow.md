# Autonomous Agent Workflow Skill Guidelines

## Purpose
This skill defines an advanced workflow for the AI agent to tackle complex problems by integrating parallel brainstorming, adversarial self-review, and iterative refinement. The goal is to produce highly robust, well-vetted, and production-ready solutions, mirroring sophisticated human engineering processes.

## Instructions

1.  **Parallel Brainstorming**:
    *   For any complex problem or design challenge, the agent *must* generate at least three (3) fundamentally distinct architectural or conceptual approaches.
    *   Each approach should explore different paradigms, technologies, or trade-offs (e.g., performance vs. scalability, simplicity vs. feature richness, different architectural patterns like microservices, monolith, serverless).
    *   Provide a brief justification and high-level overview for each distinct approach.

2.  **Adversarial Review**:
    *   After generating multiple approaches, the agent must adopt the persona of a "Critical Senior Engineer."
    *   Conduct a rigorous, self-imposed review of *each* proposed solution.
    *   Actively identify:
        *   **Flaws**: Logical inconsistencies, inefficiencies, or design weaknesses.
        *   **Edge Cases**: How the solution behaves under unusual, extreme, or boundary conditions.
        *   **Security Vulnerabilities**: Potential attack vectors, data breaches, or weaknesses in authentication/authorization.
        *   **Scalability Issues**: Limitations in handling increased load or data.
        *   **Maintainability Concerns**: Complexity, readability, and ease of future modifications.
    *   Document the findings for each approach.

3.  **Iterative Refinement**:
    *   Establish a self-correction loop where the agent uses the feedback from the "Adversarial Review" to refine and improve its proposed solutions.
    *   For each identified flaw, edge case, or vulnerability, the agent must propose and implement corrective measures or articulate why a particular risk is acceptable (with justification).
    *   This process should iterate until the agent, in its "Critical Senior Engineer" persona, finds the solution adequately robust and resilient, or until further significant improvements are not feasible within reasonable constraints.

4.  **Final Synthesis**:
    *   After iterative refinement, consolidate the strongest elements, best practices, and most robust solutions from the refined approaches into a single, unified, high-quality output.
    *   This final output should be presented as a production-ready recommendation, detailing the chosen architecture, design decisions, and implementation strategy.
    *   It should be clear, comprehensive, and ready for direct application or further human review with minimal additional effort.

5.  **Evidence-based Decisions**:
    *   Throughout the entire workflow (from brainstorming to final synthesis), every significant decision, architectural choice, or trade-off *must* be explicitly justified.
    *   Cite relevant documentation, established engineering principles, industry best practices, or logical reasoning for *why* a particular approach was selected over others, or why certain refinements were made.
    *   This ensures transparency, promotes understanding, and builds confidence in the agent's recommendations.
