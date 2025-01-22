# env
set -gx EDITOR nvim
set -gx PATH $HOME/.local/bin $PATH

# keybind
#bind \cf 'fzf'  # Ctrl+Fでfzfを起動


if status is-interactive
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
    abbr -a vim 'nvim'
    abbr -a nv 'nvim'

    # ディレクトリ移動の略語
    abbr -a home 'cd ~'
    abbr -a dl 'cd ~/Downloads'

    # システム管理の略語
    abbr -a update 'sudo pacman -Syu'  # Arch Linuxの場合
    abbr -a sysinfo 'fastfetch'

    # ネットワーク関連の略語
    abbr -a myip 'curl ifconfig.me'
    abbr -a ports 'netstat -tulanp'

    # プロセス管理の略語
    abbr -a psa 'ps aux'
    abbr -a psg 'ps aux | rg'

    # ファイル操作の略語
    abbr -a rm 'rm -i'
    abbr -a cp 'cp -i'
    abbr -a mv 'mv -i'
end

# plugin
fzf_configure_bindings --history=ctrl-r


starship init fish | source
