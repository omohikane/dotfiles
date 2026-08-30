# Termux Phone Setup (razr 50 + Clicks) - minimal

PC側で用意、スマホ側は `git clone + setup.sh` だけでSSHクライアントとして使える。

## 最小構成

- Termux側に必要なのは `git` + `openssh` (+任意で `mosh`) のみ
- `fish`/`zellij`/`starship` は不要（自宅PC側のzellijに繋ぐため）
- 重いdotfiles全体はクローン不要、浅いcloneでOK

## PC側（済）

- `termux/termux.properties` : 最小 extra-keys のみ
- `termux/setup.sh` : `git/openssh/mosh` だけを `pkg install` + symlink + 鍵生成
- `termux/aliases.sh` : `hs`/`hsp` 等のbashエイリアス（fish不要）
- `termux/ssh-config.example` : `endeavour`/`fuchu` 雛形
- `dot_config/zellij/layouts/phone.kdl` : サーバ側の狭幅レイアウト

`fish-termux.fish` はフル構成用に残置（今回は使わない）。

## スマホ側（Termux）

```bash
pkg update -y && pkg install -y git openssh
# 軽量clone（履歴不要）
git clone --depth 1 https://github.com/omohikane/dotfiles.git ~/dotfiles
cd ~/dotfiles/termux
bash setup.sh
cat ~/.ssh/id_ed25519.pub  # これをPCの ~/.ssh/authorized_keys に追記

# お好みでエイリアス有効化（bash）
echo 'source ~/dotfiles/termux/aliases.sh' >> ~/.bashrc
source ~/.bashrc

# NetBird Androidアプリで接続後
ssh endeavour
ssh -t endeavour "zellij --layout phone attach -c phone"  # or hsp
```

フル構成が必要になったら `bash setup-full.sh`（旧setup）を用意するので声をかけてください。
