# Git Worktree Manager Skill Guidelines

## Purpose
This document serves as a procedural guide for AI to effectively utilize `git worktree`, enabling parallel execution of multiple tasks (e.g., feature development, hotfixes, code reviews) in isolated environments.

## Instructions

1.  **Worktree Creation Rule**:
    *   New worktrees shall be created under `~/temp/worktree/` or within the project's root directory, depending on the user's preference or project structure.
    *   The directory name for each worktree must be derived directly from the task name (e.g., for a task "feature/add-login", the worktree directory might be `~/temp/worktree/feature/add-login`).
    *   Command example: `git worktree add -b <branch-name> <path/to/new/worktree>`

2.  **Context Isolation**:
    *   Each git worktree must be treated as an independent development session.
    *   Ensure that changes made within one worktree do not inadvertently affect or conflict with other active worktrees.
    *   This isolation guarantees a clean environment for each task, preventing inter-task interference.

3.  **Cleanup Procedures**:
    *   Upon successful completion and merging/closing of a task, the corresponding worktree must be safely removed.
    *   **Step 1: Delete the worktree.** Navigate to the main repository (not within the worktree itself) and execute: `git worktree remove <path/to/worktree>`
    *   **Step 2: Delete the associated branch.** After confirming the branch has been merged and is no longer needed, delete the local and remote branch:
        *   Local: `git branch -d <branch-name>`
        *   Remote: `git push origin --delete <branch-name>`
    *   Periodically review and prune any stale or unused worktrees and branches.

4.  **Naming Convention**:
    *   Maintain strict synchronization between the git branch name and the worktree directory name.
    *   The worktree directory should ideally mirror the branch name for easy identification and management. For instance, a branch named `feature/user-profile-page` should correspond to a worktree directory like `~/temp/worktree/feature/user-profile-page`.
    *   This consistency simplifies navigation and reduces ambiguity across parallel tasks.
