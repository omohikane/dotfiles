# ~/.config/ai-personal/tools/ai-commands.fish
# Gemini CLI (official) helpers for Fish
# - No eval
# - Common prompt caching
# - Personas/skills loader
# - Safe approval-mode presets

set -gx AI_CONFIG_DIR "$HOME/.config/ai-personal"

set -gx GEMINI_BIN "gemini"
set -gx GEMINI_APPROVAL_DEFAULT "default"

# Cache bundle for common prompts
set -gx GEMINI_CACHE_DIR "$XDG_CACHE_HOME/ai-personal"
if test -z "$XDG_CACHE_HOME"
    set -gx GEMINI_CACHE_DIR "$HOME/.cache/ai-personal"
else
    set -gx GEMINI_CACHE_DIR "$XDG_CACHE_HOME/ai-personal"
end
test -n "$GEMINI_CACHE_DIR"; or set -gx GEMINI_CACHE_DIR "$HOME/.cache/ai-personal"
set -gx GEMINI_COMMON_CACHE "$GEMINI_CACHE_DIR/gemini.common.bundle.txt"

function __die --argument-names msg
    echo $msg >&2
    return 1
end

function __read_file_or_die --argument-names path
    test -f "$path"; or __die "Error: file not found: $path"
    cat "$path"
end

function __ensure_common_cache
    mkdir -p "$GEMINI_CACHE_DIR"; or return 1

    set -l common1 "$AI_CONFIG_DIR/common/working-style.md"
    set -l common2 "$AI_CONFIG_DIR/common/brand-voice.md"
    set -l manifest "$AI_CONFIG_DIR/_MANIFEST.md"

    for f in "$common1" "$common2" "$manifest"
        test -f "$f"; or __die "Error: required file missing: $f"
    end

    set -l rebuild 0
    if not test -f "$GEMINI_COMMON_CACHE"
        set rebuild 1
    else
        for f in "$common1" "$common2" "$manifest"
            if test "$f" -nt "$GEMINI_COMMON_CACHE"
                set rebuild 1
                break
            end
        end
    end

    if test $rebuild -eq 1
        begin
            echo "## Common working style"
            echo (__read_file_or_die "$common1")
            echo
            echo "## Brand voice"
            echo (__read_file_or_die "$common2")
            echo
            echo "## Manifest"
            echo (__read_file_or_die "$manifest")
            echo
        end > "$GEMINI_COMMON_CACHE"
    end
end

function __build_prompt
    __ensure_common_cache; or return 1

    # Accepts:
    #   --system-prompt/-s <file> ... <user message...>
    set -l extra_parts
    set -l user_parts

    set -l i 1
    while test $i -le (count $argv)
        set -l arg $argv[$i]
        switch $arg
            case --system-prompt -s
                set -l nexti (math $i + 1)
                test $nexti -le (count $argv); or __die "Error: $arg requires a file path"
                set -l f $argv[$nexti]
                test -f "$f"; or __die "Error: prompt file not found: $f"
                set extra_parts $extra_parts "## Additional prompt ($f)\n"(cat "$f")"\n"
                set i (math $i + 2)
                continue
            case '*'
                set user_parts $user_parts $arg
        end
        set i (math $i + 1)
    end

    set -l user_message (string join " " -- $user_parts)

    set -l header "You are an AI assistant. Follow the instructions below."
    set -l common (cat "$GEMINI_COMMON_CACHE")
    set -l extra (string join "\n" -- $extra_parts)

    string join "\n" -- \
        $header \
        "" \
        $common \
        $extra \
        "## User request" \
        $user_message
end

function __gemini_run --argument-names approval_mode
    set -l prompt (__build_prompt $argv[2..-1])
    or return 1
    command $GEMINI_BIN --approval-mode $approval_mode $prompt
end

# ---- Main commands ----

function gem
    __gemini_run $GEMINI_APPROVAL_DEFAULT $argv
end

function gem-edit
    __gemini_run auto_edit $argv
end

function gem-yolo
    __gemini_run yolo $argv
end

# ---- Skills ----

function gem-skill --argument-names skill_name
    set -l skill_file "$AI_CONFIG_DIR/skills/$skill_name.md"
    test -f "$skill_file"; or __die "Error: skill file not found: $skill_file"
    gem --system-prompt "$skill_file" $argv[2..-1]
end

function gem-doctor
    gem-skill arch-system-doctor $argv
end

function gem-worktree
    gem-skill git-worktree-manager $argv
end

function gem-agent
    gem-skill autonomous-agent-workflow $argv
end

# ---- Personas ----

function __find_persona --argument-names folder name
    set -l p ""

    if test -n "$folder"
        if test -f "$AI_CONFIG_DIR/personas/$folder/$name.md"
            set p "$AI_CONFIG_DIR/personas/$folder/$name.md"
        end
    end

    if test -z "$p"
        if test -f "$AI_CONFIG_DIR/personas/$name.md"
            set p "$AI_CONFIG_DIR/personas/$name.md"
        end
    end

    echo $p
end

function gem-summon
    # Usage: gem-summon <folder> <name> [message...]
    set -l folder $argv[1]
    set -l name $argv[2]
    test -n "$name"; or __die "Usage: gem-summon <folder> <name> [message...]"

    set -l persona_path (__find_persona "$folder" "$name")
    test -n "$persona_path"; or __die "Error: persona not found: $folder/$name.md (or personas/$name.md)"

    gem --system-prompt "$persona_path" $argv[3..-1]
end

function gem-panel
    # Usage:
    #   gem-panel persona1 persona2 -- message...
    #   gem-panel -- message...   (panel base only)
    set -l panel_base "$AI_CONFIG_DIR/personas/expert-panel.md"
    test -f "$panel_base"; or __die "Error: panel base prompt not found: $panel_base"

    set -l prompts "--system-prompt" "$panel_base"

    set -l seen_sep 0
    set -l message_parts

    for arg in $argv
        if test $seen_sep -eq 0
            if test "$arg" = "--"
                set seen_sep 1
                continue
            end

            # persona lookup order: root + subfolders
            set -l p ""
            if test -f "$AI_CONFIG_DIR/personas/$arg.md"
                set p "$AI_CONFIG_DIR/personas/$arg.md"
            else if test -f "$AI_CONFIG_DIR/personas/strategy/$arg.md"
                set p "$AI_CONFIG_DIR/personas/strategy/$arg.md"
            else if test -f "$AI_CONFIG_DIR/personas/philosophy/$arg.md"
                set p "$AI_CONFIG_DIR/personas/philosophy/$arg.md"
            else if test -f "$AI_CONFIG_DIR/personas/mind/$arg.md"
                set p "$AI_CONFIG_DIR/personas/mind/$arg.md"
            else if test -f "$AI_CONFIG_DIR/personas/business/$arg.md"
                set p "$AI_CONFIG_DIR/personas/business/$arg.md"
            end

            if test -n "$p"
                set prompts $prompts "--system-prompt" "$p"
            else
                # If not found as persona and no -- separator, treat as message
                set seen_sep 1
                set message_parts $message_parts $arg
            end
        else
            set message_parts $message_parts $arg
        end
    end

    # Merge: prompts are passed as "-s file" to gem (we'll read file contents in builder)
    # So we convert each "--system-prompt <path>" pair to gem args directly.
    # We already do that by calling `gem` and passing the same flags.
    gem $prompts $message_parts
end

# ---- Abbrs (optional, remove if you prefer explicit funcs) ----
abbr -a gem 'gem'
abbr -a gedit 'gem-edit'
abbr -a gyolo 'gem-yolo'
