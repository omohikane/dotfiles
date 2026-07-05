function goose-pane
    if not set -q ZELLIJ
        echo "This command must be run inside Zellij."
        return 1
    end

    set direction right

    if test (count $argv) -ge 1
        set direction $argv[1]
    end

    zellij action new-pane \
        --direction $direction \
        --cwd "$PWD" \
        --name goose \
        --close-on-exit \
        -- fish -lc 'goose session'
end
