# ~/.config/ai-personal/clients/fish-loader.fish
set -l root "$HOME/.config/ai-personal"

# Client adapters (Fish)
for f in \
    "$root/clients/gemini/fish/commands.fish" \
    "$root/clients/aider/fish/commands.fish"
    if test -f "$f"
        source "$f"
    end
end
