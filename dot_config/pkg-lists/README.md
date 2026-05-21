# pkglists — モジュラー Arch Linux パッケージ管理

Arch Linux (EndeavourOS) 環境のパッケージを、用途別のリストファイルで管理し、
選択的にインストールするための仕組み。

## ディレクトリ構成

chezmoi で `~/.config/pkglists/` に配置される。

```
~/.config/pkglists/
├── install-pkgs.sh          # インストールスクリプト
├── pkglist-core.txt         # 基盤・シェル・エディタ
├── pkglist-utils.txt        # システム監視・雑多ユーティリティ
├── pkglist-dev.txt          # 開発ツール (LSP, linter, runtime)
├── pkglist-ai.txt           # AI / ローカル推論
├── pkglist-container.txt    # Podman / Buildah
├── pkglist-vm.txt           # QEMU / libvirt       (opt-in)
├── pkglist-k8s.txt          # Kubernetes
├── pkglist-netutils.txt     # ネットワーク診断・リモート
├── pkglist-secutils.txt     # セキュリティ・ペンテスト
├── pkglist-media.txt        # 画像編集・メタデータ
├── pkglist-laptop.txt       # 電源管理・ノートPC用  (opt-in)
├── pkglist-fonts.txt        # フォント (AUR)
├── pkglist-sway.txt         # Sway WM 環境
└── README.md
```

## リストファイルのフォーマット

```text
## セクション名（コメント。無視される）

package-name              ← 公式リポジトリ
# (AUR) aur-package-name  ← AUR パッケージ
```

- `##` で始まる行 → セクションヘッダ（スクリプトでは無視）
- `# (AUR) ` で始まる行 → AUR パッケージとして `yay` で処理
- その他のコメント（`#`）→ 無視
- 空行 → 無視
- それ以外 → 公式パッケージとして `pacman` で処理

## 利用可能なリスト

| リスト | 用途 | opt-in |
|--------|------|--------|
| `core` | base, shell, editor, input method, font | |
| `utils` | glances, inxi, lnav, obsidian 等 | |
| `dev` | LSP, linter, formatter, runtime, ops | |
| `ai` | ollama, 計算ライブラリ | |
| `container` | podman, buildah, skopeo | |
| `vm` | qemu, libvirt, virt-manager | ✓ |
| `k8s` | kubectl, helm, k9s, stern | |
| `netutils` | mtr, tcpdump, nmap, remmina 等 | |
| `secutils` | wireshark, hashcat, sqlmap, ghidra 等 | |
| `media` | gimp, ffmpegthumbnailer 等 | |
| `laptop` | tlp, acpi_call, brightnessctl | ✓ |
| `fonts` | Cica, HackGen, Twemoji 等 (AUR) | |
| `sway` | sway, waybar, grim, blueman 等 | |

`opt-in` のリストは `all` 指定時に含まれない。明示的な指定か `all+` が必要。

## 使い方

```bash
# 対話メニューで選択
~/.config/pkglists/install-pkgs.sh

# リストを直接指定してインストール
./install-pkgs.sh core dev ai fonts

# ドライラン（何が入るか確認）
./install-pkgs.sh --dry-run core dev

# 差分表示（未インストールのパッケージを確認）
./install-pkgs.sh --diff core

# opt-in を除く全リスト
./install-pkgs.sh all

# opt-in を含む全リスト
./install-pkgs.sh all+

# all + 特定の opt-in を追加
./install-pkgs.sh all laptop

# ヘルプ
./install-pkgs.sh -h
```

### モード

| フラグ | 動作 |
|--------|------|
| `--install` | インストール実行（デフォルト） |
| `--dry-run` | インストールせず対象を表示 |
| `--diff` | 現在のシステムとの差分を表示 |

### パッケージマネージャの振り分け

```
公式パッケージ  → sudo pacman -S --needed
AUR パッケージ → yay -S --needed
```

`yay` が未インストールの場合、AUR パッケージはスキップされ一覧が警告として表示される。

## マシン別の構成例

```bash
# デスクトップ (EndeavourOS KDE)
./install-pkgs.sh core utils dev ai fonts sway

# 業務ノート
./install-pkgs.sh core utils dev netutils secutils laptop

# インフラ検証機
./install-pkgs.sh core dev container vm k8s netutils

# ペンテスト用
./install-pkgs.sh core netutils secutils

# 最小構成
./install-pkgs.sh core
```

## リストの追加

`pkglist-*.txt` の命名規則でファイルを置くだけで自動検出される。

```bash
# 例: GPU / 科学計算用リストを追加
vim ~/.config/pkglists/pkglist-science.txt
```

次回 `install-pkgs.sh` を実行すると対話メニューに自動的に表示される。
スクリプトの修正は不要。

### opt-in にする場合

スクリプト内の `OPTIN` 配列にカテゴリ名を追加する。

```bash
OPTIN=("laptop" "vm" "science")
```

## chezmoi での管理

### ソース側の構成

```
~/.local/share/chezmoi/
└── dot_config/
    └── pkglists/
        ├── executable_install-pkgs.sh
        ├── pkglist-core.txt
        ├── pkglist-dev.txt
        └── ...
```

- `executable_` プレフィックスでスクリプトに実行権限が付与される
- `run_once_` / `run_onchange_` は使わない（意図しないインストールを防ぐ）

### 初回セットアップ

```bash
chezmoi cd
mkdir -p dot_config/pkglists
cp /path/to/install-pkgs.sh dot_config/pkglists/executable_install-pkgs.sh
cp /path/to/pkglist-*.txt dot_config/pkglists/
cp /path/to/README.md dot_config/pkglists/
chezmoi apply

# 新マシンで
chezmoi init <repo>
chezmoi apply
~/.config/pkglists/install-pkgs.sh
```

## ログ

インストールログは以下に保存される:

```
~/.local/log/pkg-install-YYYY-MM-DD_HHMMSS.log
```

## 注意事項

- AUR パッケージのインストールには `yay` が必要。`base-devel` と `yay` は事前に入れておくこと
- `--needed` フラグにより、既にインストール済みのパッケージはスキップされる（冪等）
- `--install` 実行時は確認プロンプトが出る（`--noconfirm` は pacman/yay 側で付与）
- リストファイルに重複があっても `--needed` で吸収されるが、意図的に避けること
