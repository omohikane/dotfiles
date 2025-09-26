# Hikari Vim README (for plain Vim)

“光のvim” = **plugin-free, portable, low-friction** Vim profile.
この README は `.vimrc`（完成版）に対応した**使い方メモ＆チートシート**です。

---

## 1. 概要

* **目的**: どこでも同じ手触り（SSH/最小環境でもOK）、Neovim は重装備 IDE、Vim は軽快な常備刀。
* **特徴**:

  * 低彩度ダーク配色（TrueColor/256色両対応）
  * ステータスライン: `Git branch` + `IME (EN/JP)` 表示
  * 日本語入力: 挿入/コマンド終了で IME 自動OFF、`jj`/`jk` で IME cancel + Normal
  * Markdown: 文末半角スペース2つ（強制改行）を自動着色
  * netrw ベースの軽量ファイラ + 便利コマンド

---

## 2. 導入（chezmoi 運用）

```bash
chezmoi edit ~/.vimrc   # 完成版を貼り付け
chezmoi apply           # 反映
```

* 既に運用中なら: `chezmoi add ~/.vimrc` → 以後は `chezmoi edit ~/.vimrc` → `apply`。
* 共有運用したい場合は `shared/vimrc.tmpl` を作り、`dot_vimrc.tmpl` から `{{ include "shared/vimrc.tmpl" }}` 参照に統一。

---

## 3. キーマップ（主要）

### ファイル / ファイラ（netrw）

| Key   | Action                |
| ----- | --------------------- |
| `,e`  | Explore（カレントディレクトリ）   |
| `,fe` | Explore（編集中ファイルのある場所） |
| `,ft` | Texplore（新規タブでファイラ）   |
| `,E`  | netrw 表示トグル（列⇄ツリー）    |
| `,nf` | 同階層に新規ファイル（名前入力待ち）    |
| `,o`  | 最近使ったファイル一覧（番号で開く）    |

### 保存/終了

| Key  | Action       |
| ---- | ------------ |
| `,w` | write        |
| `,q` | quit         |
| `,x` | xit（保存して閉じる） |

### ウィンドウ / タブ

| Key           | Action              |
| ------------- | ------------------- |
| `,sv` / `,sh` | 縦 / 横 分割            |
| `<C-h/j/k/l>` | 分割間移動               |
| `,←/→/↑/↓`    | リサイズ（Alt が効かない端末向け） |
| `,st` / `,tc` | 新規タブ / タブを閉じる       |
| `gt` / `gT`   | タブ巡回（標準）            |

### バッファ / パス

| Key           | Action               |
| ------------- | -------------------- |
| `,bn` / `,bp` | 次 / 前 バッファ           |
| `,bd`         | バッファを閉じる             |
| `,yp`         | 現在ファイルの絶対パスをクリップボードへ |

### 検索・置換

| Key                                 | Action                      |
| ----------------------------------- | --------------------------- |
| `/` / `?`                           | 既定で **very magic**（正規表現が短く） |
| `n` / `N` / `*` / `#` / `g*` / `g#` | 結果を**中央寄せ + フォールド展開**       |
| `<C-l>`                             | 再描画 + ハイライト解除               |
| `,s`                                | ファイル全体で**単語置換**（`/gce` 安全型） |
| `,S`                                | 行内で**単語置換**（`/gce`）         |

### クイックフィックス / ロケーション

| Key         | Action               |
| ----------- | -------------------- |
| `]q` / `[q` | 次 / 前（quickfix）      |
| `]l` / `[l` | 次 / 前（location list） |

### 行移動・誤爆防止

| Key       | Action         |
| --------- | -------------- |
| `H` / `L` | 行頭 / 行末へ       |
| `Q`       | 無効（Ex モード誤爆防止） |

### 挿入モードの脱出 + IME cancel

| Key         | Action                                        |
| ----------- | --------------------------------------------- |
| `jj` / `jk` | `<Esc>` + IME OFF（fcitx5/fcitx/im-select 検出時） |

---

## 4. 便利コマンド

| Command             | Description                                     |
| ------------------- | ----------------------------------------------- |
| `:Rename {newpath}` | 現在ファイルをリネーム（安全動作、旧名を削除）                         |
| `:Remove`           | 現在ファイルを削除（確認あり、バッファも掃除）                         |
| `:Mkdir [dir]`      | ディレクトリ作成。引数なしで現バッファのディレクトリ                      |
| `:CleanSpaces`      | 末尾半角/全角スペースを一括除去                                |
| `:grep {pat}`       | `rg` があれば `--vimgrep --smart-case --hidden` を使用 |

---

## 5. 日本語入力（IME）

* **自動OFF**: Insert/Cmdline を抜けると `iminsert=0`。fcitx5/fcitx があれば `*-remote -c`、macOS で `im-select` があれば `ABC` へ。
* **手動トグル**: 標準 `<C-^>`（挿入中の IM 切替）。
* **ステータスライン**: `EN` / `JP` を右側に表示。

> `im-select` 未導入の macOS では Vim 側のフラグのみ切替（実IMEは手元操作）。

---

## 6. Markdown 補助

* 文末の**半角スペース2つ**（強制改行）を `MarkdownLineBreak` で着色。
* 必要に応じて `highlight MarkdownLineBreak ...` の色を微調整（低彩度配色に合わせた控えめトーン）。

---

## 7. 表示と配色

* ベース: `colorscheme desert`（内蔵）+ 低彩度の手当て（TrueColor/cterm 両対応）。
* 重要点（暗背景に最適化）:

  * カーソル行背景を軽い灰（視線誘導）
  * 現在行番号は落ち着いた黄緑で強調
  * Search/IncSearch は黄土系、Visual は低彩度の青
  * 非アクティブ StatusLine は沈めて情報の主従を明確化

---

## 8. オプション・トグル

| Setting/Map | Default                        |
| ----------- | ------------------------------ |
| 相対行番号       | Normal: ON / Insert: OFF（自動切替） |
| `,n` / `,r` | 行番号 / 相対行番号の手動トグル              |
| `,E`        | netrw 表示（列⇄ツリー）                |
| `wrapscan`  | ON（末尾→先頭に回り込み）                 |

---

## 9. ディレクトリと履歴

* `~/.vim/backup` / `~/.vim/swap` / `~/.vim/undo` を自動作成。作業ツリーを汚さない。
* `undofile` 有効（Vim8 以降）。

---

## 10. よくある質問（FAQ）

**Q. Git ブランチが出ない**
A. `git` がない or 非リポジトリです。`git -C <dir> rev-parse --is-inside-work-tree` の結果をご確認ください。

**Q. IME が自動で切れない**
A. Vim 側フラグは確実に OFF になります。実IMEも切りたい場合は Linux: `fcitx5-remote`/`fcitx-remote`、macOS: `im-select` を導入してください。

**Q. Markdown のスペース2つが見えづらい**
A. `highlight MarkdownLineBreak ...` の `guibg/guifg`（または cterm）を濃いめに調整してください。

---

## 11. 小さな流儀（運用のコツ）

* `,p` / `,P`（挿入箇所へ戻るペースト）は必要に応じて追加可。
* Alt でのリサイズが効かない端末では `,←/→/↑/↓` を使う。
* 迷ったら `<C-l>`（再描画+ハイライト解除）。

---

Happy hacking.

