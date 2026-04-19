# env
set -gx EDITOR nvim
set -gx PATH $HOME/.local/bin $PATH
set -g fish_auto_cd true
set -g fish_color_autosuggestion brblack
set -g fish_color_command green
set -x NVIM_LOG_FILE /tmp/nvim/log
mkdir -p /tmp/nvim; and chmod 700 /tmp/nvim
set -g fzf_preview_file_cmd bat --color=always --line-range :500
set -g fzf_fd_opts --hidden --exclude .git

# keybind
#bind \cf 'fzf'  # Ctrl+Fでfzfを起動
bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste

function fish_user_key_bindings
  # fish vim mode
  fish_vi_key_bindings --no-erase

  # Emacs key bindings 
  bind -M insert  \cf forward-char
  bind -M insert  \ce end-of-line
  bind -M insert  \el forward-word
  
  # set mode cursor 
  # 1: block (█), 2: underscore (_), 3: line (|), 4: block (blink), 5: underscore (blink), 6: line (blink)
  set -g fish_cursor_default block
  set -g fish_cursor_insert line
  set -g fish_cursor_replace_one underscore
  set -g fish_cursor_visual block
end

if status is-interactive

  if type -q zoxide
    zoxide init fish | source 
  end

    # Commands to run in interactive sessions can go here
    # よく使うコマンドの略語
    abbr -a g git
    abbr -a gia 'git add'
    abbr -a gic 'git commit'
    abbr -a gicm 'git commit -m "'
    abbr -a gip 'git push'
    abbr -a gipo 'git push origin master'
    abbr -a gist 'git status'

    # システムコマンドの略語
    abbr -a l ls
    abbr -a ll 'ls -lah'
    abbr -a .. 'cd ..'
    abbr -a ... 'cd ../..'
    abbr -a hisg 'history | rg '

    # アプリケーション特有の略語
    abbr -a k kubectl
    abbr -a ran ranger

    # 編集用の略語
    abbr -a e $EDITOR
    abbr -a nv 'nvim'

    # ディレクトリ移動の略語
    abbr -a home 'cd ~'
    abbr -a dl 'cd ~/Downloads'

    # システム管理の略語
    abbr -a sysinfo 'fastfetch'

    # ネットワーク関連の略語
    abbr -a myip 'curl ifconfig.me'
    abbr -a ports 'netstat -tulanp'

    # プロセス管理の略語
    abbr -a psa 'ps aux'
    abbr -a psg 'ps aux | rg'

    # kubernetes
    abbr -a k 'kubectl'
    abbr -a kgp 'kubectl get pods'
    abbr -a kgpa 'kubectl get pods -A'
    abbr -a kga 'kubectl get all'
    abbr -a kaf 'kubectl apply -f'
    abbr -a ktx 'kubectx'
    abbr -a kns 'kubens'
    abbr -a kd 'kubectl describe'
    abbr -a kl 'kubectl logs'
    abbr -a klf 'kubectl logs -f'
    abbr -a kdel 'kubectl delete'
    abbr -a ke 'kubectl edit'

    # Chezmoi
    abbr -a cz 'chezmoi'

    # Wireguard
    abbr -a wgu 'sudo wg-quick up '
    abbr -a wgd 'sudo wg-quick down '

    # Aider
    abbr -a aig3f 'aider --model gemini/gemini-3-flash-preview'
    abbr -a aigp 'aider --model gemini/gemini-1.5-pro-latest'
    abbr -a aig2f 'aider --model gemini/gemini-2.0-flash-exp'

    # AI Personal adapters (client-specific Fish helpers)
    if test -f "$HOME/.config/ai-personal/clients/fish-loader.fish"
        source "$HOME/.config/ai-personal/clients/fish-loader.fish"
    end
end


# plugin
fzf_configure_bindings --history=ctrl-r

# --- Fisher Automatic Setup ---
if status is-interactive
    set -f fisher_path $__fish_config_dir/functions/fisher.fish
    if not test -e $fisher_path
        echo "Installing fisher..."
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update
    end
end


starship init fish | source
