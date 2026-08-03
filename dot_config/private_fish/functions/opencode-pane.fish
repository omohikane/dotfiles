function opencode-pane
    if not set -q ZELLIJ
        echo "This command must be run inside Zellij."
        return 1
    end

    set direction right

    if test (count $argv) -ge 1
        switch $argv[1]
            case '-*'
            case '*'
                set direction $argv[1]
                set -e argv[1]
        end
    end

    zellij action new-pane \
        --direction $direction \
        --cwd "$PWD" \
        --name opencode \
        --close-on-exit \
        -- opencode $argv
end
