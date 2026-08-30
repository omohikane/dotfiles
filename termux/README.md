# Termux Phone Setup (razr 50 + Clicks)

PC側で準備済み。スマホ側はクローンして `setup.sh` を叩くだけ。

## PC側（済）

- `termux/termux.properties` : Clicks物理キーボード向け extra-keys / enforce-char-based-input
- `termux/setup.sh` : pkg一括導入 + symlink + SSH鍵生成
- `termux/fish-termux.fish` : NetBird経由 `hs`/`hsp` エイリアス
- `dot_config/zellij/layouts/phone.kdl` : 狭幅1ペイン用レイアウト
- `termux/ssh-config.example` : `endeavour`/`fuchu` ホスト雛形

## スマホ側（Termux）

```bash
pkg update -y && pkg install -y git openssh
git clone https://github.com/omohikane/dotfiles.git ~/dotfiles
cd ~/dotfiles/termux
bash setup.sh
# 出力された id_ed25519.pub を自宅PCの ~/.ssh/authorized_keys に追記
cat ~/.ssh/id_ed25519.pub  # これをコピー

# NetBird Androidアプリで接続後
ssh endeavour          # or ssh r1ppl3@endeavour-desktop-ryzen.netbird.cloud
ssh -t endeavour "zellij attach -c main"          # PCと同じセッション
ssh -t endeavour "zellij --layout phone attach -c phone"  # スマホ用狭幅レイアウト
```

Fishを常用するなら:
```bash
chsh -s fish
# 再起動後、hs / hsp が使える
hs    # = ssh -t endeavour "zellij attach -c main"
hsp   # = phone layout
```

## NetBird補足

- NetBird Setup Keyはダッシュボードで発行 (https://app.netbird.io)
- `endeavour-desktop-ryzen.netbird.cloud` は `~/.ssh/conf.d/personal.conf` の `ThinkpadX13g6`/`Fuchu-LLM-Server` と同様にMagicDNSで解決

## mosh（任意）

モバイル回線で切断が多い場合:
```bash
pkg install mosh
mosh endeavour -- zellij attach -c main
```
サーバ側は `sudo pacman -S mosh` が必要。
