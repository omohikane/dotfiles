# termux/aliases.sh - minimal ssh aliases for Termux (bash/zsh) - source from ~/.bashrc
# Usage: echo 'source ~/dotfiles/termux/aliases.sh' >> ~/.bashrc

# NetBird経由の自宅PC
alias hs='ssh -t endeavour "zellij attach -c main"'
alias hsp='ssh -t endeavour "zellij --layout phone attach -c phone"'
alias hssh='ssh endeavour'
alias fssh='ssh fuchu'
# mosh版（切断に強い）
alias hs-mosh='mosh endeavour -- zellij attach -c main'
