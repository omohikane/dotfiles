# Arch System Doctor Skill Guidelines

## Purpose
This skill aims to diagnose and resolve system issues on Arch Linux distributions, strictly adhering to "The Arch Way" philosophy. This involves a methodical, root-cause-focused approach, emphasizing user understanding and control.

## Instructions

1.  **System Log Analysis**:
    *   **Prioritization**: When confronted with system issues, prioritize recent error messages. Start by reviewing `journalctl` output from the last boot or specific timeframes.
        *   `journalctl -p err -b -1`: Show errors from the previous boot.
        *   `journalctl -p warning -b`: Show warnings from the current boot.
        *   `journalctl --since "YYYY-MM-DD HH:MM:SS" --until "YYYY-MM-DD HH:MM:SS"`: Review logs within a specific time range.
    *   **Kernel Messages**: For hardware-related issues or boot problems, examine `dmesg` output.
        *   `dmesg -T`: Display kernel messages with human-readable timestamps.
        *   `dmesg | grep -i "error|fail|warn"`: Filter `dmesg` for common problem indicators.
    *   **Interpretation**: Correlate log entries with system events or recent changes. Look for patterns, repeating errors, or specific service failures. Understand the context of each error message before drawing conclusions.

2.  **Package Integrity**:
    *   **Broken Dependencies**: Regularly check for and resolve broken package dependencies.
        *   `sudo pacman -Qk`: Check integrity of all installed packages.
        *   `sudo pacman -Qtdq`: List orphaned packages (packages installed as dependencies but no longer required by any explicitly installed package).
        *   `sudo pacman -Rns $(pacman -Qtdq)`: Safely remove orphaned packages.
    *   **Database Corruption**: If `pacman` acts erratically, consider re-indexing or refreshing the package database.
        *   `sudo pacman -Syyu`: Synchronize package databases and update the system.
    *   **AUR Packages (yay)**: For AUR packages, ensure their integrity and rebuild if necessary.
        *   `yay -S --rebuild <package-name>`: Rebuild a specific AUR package.
        *   `yay -Ps`: Check for orphaned AUR packages or issues.

3.  **Configuration Management (`.pacnew` Files)**:
    *   **Detection**: After system updates, search for `.pacnew` files, which indicate new default configuration files that might need merging.
        *   `sudo find /etc -name "*.pacnew"`: Locate all `.pacnew` files.
    *   **Merging**: Always guide the user through a merge process using a diff tool (e.g., `meld`, `diffmerge`, `vimdiff`). Never automatically overwrite existing configurations.
        *   `sudo diff -u /etc/original_file /etc/original_file.pacnew > diff.patch`
        *   Instruct the user to manually review and merge changes.
    *   **Importance**: Emphasize the importance of reviewing `.pacnew` files to adopt new upstream defaults, security fixes, or feature enhancements while preserving local customizations.

4.  **Corrective Action & Root Cause Emphasis**:
    *   **Plan First**: Before suggesting any command that modifies the system, always present a clear, step-by-step, non-destructive plan to the user for approval. Explain *why* each step is necessary.
    *   **Diagnosis over Symptom Treatment**: Focus on identifying and understanding the *root cause* of the issue rather than merely addressing symptoms. A quick fix without understanding the underlying problem can lead to recurrence or new issues.
    *   **Verification**: After any corrective action, verify the resolution using relevant logs, status checks, or user feedback.
    *   **Documentation**: Encourage documenting the diagnosis process, root cause, and resolution steps for future reference, adhering to "The Arch Way" of self-sufficiency and knowledge sharing.
