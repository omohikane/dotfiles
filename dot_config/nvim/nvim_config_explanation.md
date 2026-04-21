# Neovim設定解説 (完全版)

あなたのNeovim設定は、プラグインマネージャー`dpp.vim`を核とし、設定の本体を `toml/dein.toml` に、そして使い勝手を高めるカスタム設定を `lua/core/` ディレクトリに集約させた、非常に体系的な構成です。

---

## 1. 主要なカスタム設定 (`lua/core/`より)

エディタの挙動や使い勝手を決定づける、あなた独自のカスタマイズです。

### `options.lua`の主要な設定 (エディタの基本動作)

- **表示と操作感**:
    - `scrolloff = 999`: カーソル行が常に画面中央に来るように設定。コードの全体像を把握しやすくなります。
    - `relativenumber = true`: 相対行番号表示。`5j`のような行移動が直感的に行えます。
    - `cursorline = true`: カーソル行をハイライトし、現在の編集位置を明確にします。
- **編集効率**:
    - `tabstop = 2`, `shiftwidth = 2`, `expandtab = true`: インデントをスペース2つに統一し、コーディングスタイルを規律化します。
    - `undofile = true`: アンドゥ履歴をファイルに保存。Neovimを再起動してもアンドゥが可能です。
- **パフォーマンス**:
    - `updatetime = 300`: 各種自動化イベントの発火間隔を短くし、LSPの反応などを高速化します。
    - `lazyredraw = true`: スクロール中の再描画を抑制し、動作を軽快にします。

### `keymaps.lua`の便利なキーマップ

- **モード切り替え**:
    - `jj`, `kk`: インサートモード中に連続で入力すると`ESC`キーとして機能。ホームポジションから手を動かさずにノーマルモードへ移行できます。
- **ウィンドウ操作**:
    - `Ctrl + h/j/k/l`: `Ctrl`キーとVimの移動キーを組み合わせ、ウィンドウ間をシームレスに移動します。
    - `<Leader> v`, `<Leader> h`: 画面を縦横に分割します。
- **ツール連携**:
    - `<Leader> e`: ファイルエクスプローラー `Neotree` をトグル表示。
    - `<Leader> tt`: フローティングウィンドウでターミナルを起動 (`toggleterm`)。
    - `<Leader> mdp`: Markdownファイルのプレビューを起動。

### `autocmds.lua`の賢い自動化設定

- **コーディング支援**:
    - **自動フォーマット**: Python, Go, TypeScriptなどのファイルを保存する際に、LSP経由でコードを自動整形します。
    - **日本語入力制御**: インサートモードを抜ける際に、日本語入力メソッド(Fcitx5)を自動でOFFにし、ノーマルモードでの誤入力を防ぎます。
- **UI/UXの最適化**:
    - **セッション管理**: Neovim終了時に現在の作業状態（開いているファイル、ウィンドウ分割など）を自動保存し、次回起動時に復元します。
    - **動的なハイライト**: 使用中のカラースキーム（Catppuccin, TokyoNightなど）を判別し、それに馴染む色で余分なスペースをハイライト表示します。非常に高度なカスタマイズです。
- **ファイル管理**:
    - `checktime`: ファイルが外部で変更された場合、Neovimがフォーカスを得たタイミングで自動的にリロードします。

---

## 2. プラグイン解説 (`toml/dein.toml`より)

カテゴリごとに、導入されているプラグインの役割を解説します。

### 基盤システム (Core System)

- **`dpp.vim`, `denops.vim`**: `dpp.vim`はプラグインマネージャー、`denops.vim`はDenoランタイムとの連携を可能にする基盤。設定全体の心臓部です。
- **`plenary.nvim`, `nui.nvim`**: 多くのLua製プラグインが依存する共通ライブラリ。`plenary`は便利な関数群を、`nui`はUIコンポーネントを提供します。

### UI/UX (ユーザーインターフェース)

- **テーマ**: `tokyonight`, `catppuccin`, `kanagawa`など、多数のカラースキームを導入。気分に合わせて変更可能です。
- **アイコン**: `nvim-web-devicons`がファイルやUIの各所にアイコンを表示し、視認性を高めます。
- **画面要素**:
    - `lualine.nvim`: 高機能なステータスライン。
    - `barbar.nvim`: バッファをモダンなタブとして表示。
    - `neo-tree.nvim`: 高速で多機能なファイルエクスプローラー。
    - `fidget.nvim`: LSPの進捗を右下に表示。
    - `which-key.nvim`: キーマップのヒントを表示。
- **見た目の補助**:
    - `indent-blankline.nvim`: インデントの深さを可視化。
    - `rainbow-delimiters.nvim`: 対応する括弧を色付け。
    - `nvim-treesitter-context`: 現在地の関数名などを画面上部に表示。

### コーディング支援 (Coding Assistance)

- **補完エンジン**: `nvim-cmp`をメインに採用。
    - **補完ソース**: `cmp-nvim-lsp` (LSP), `cmp-buffer` (バッファ内の単語), `cmp-path` (ファイルパス) などを利用。
    - **スニペット**: `LuaSnip` (エンジン) と `friendly-snippets` (スニペット集) を連携。
- **構文解析**: `nvim-treesitter`がコードを構造的に解析し、正確なハイライトや操作を実現します。
- **LSP**: `nvim-lspconfig`が各言語サーバーとの連携を管理します。
- **フォーマット & リント**: `conform.nvim` (フォーマッター) と `nvim-lint` (リンター) がコード品質を維持します。

### 編集機能 (Editing Enhancements)

- **操作補助**:
    - `Comment.nvim`: コードのコメントアウトをトグル。
    - `mini.surround`: 括弧や引用符の追加・置換・削除を簡単に行う。
    - `nvim-ts-autotag`: HTMLタグなどを自動で閉じる、または名前を同時に変更する。
- **移動 (Motion)**:
    - `quick-scope`: `f`, `t`などでの移動時に、移動先の文字をハイライトして目的の場所へジャンプしやすくします。
- **検索 (Search)**:
    - `telescope.nvim`: ファイル、コンテンツ、バッファなどを曖昧検索（ファジーファインド）する最強のツール。

### 特定用途プラグイン (Specialized Plugins)

- **Git**:
    - `gitsigns.nvim`: 行の横に変更状態（追加/変更/削除）を表示。
    - `gin.vim`: Neovim内で `git` コマンドを快適に実行するためのUIを提供。
- **言語特化**: `go.nvim` (Go), `rustaceanvim` (Rust), `elixir-tools.nvim` (Elixir), `typescript-tools.nvim` (TypeScript) など、言語ごとに強力な開発支援を導入。
- **ターミナル**: `toggleterm.nvim`がフローティングや分割ウィンドウでターミナルを瞬時に呼び出します。
- **診断情報**: `trouble.nvim`がエラーや警告の一覧を分かりやすく表示します。
- **AI**: `codecompanion.nvim`, `sidekick.nvim` を導入し、AIによるコーディング支援を活用。
- **日本語入力**: `skkeleton` (SKKエンジン) と `kensaku.vim` (日本語検索) を導入し、日本語環境を整備。
- **メモ**: `obsidian.nvim`を導入し、高機能メモアプリObsidianとの連携を実現。

---

以上が、あなたのNeovim設定の全体像です。非常に多機能でありながら、`lua`と`toml`によって体系的に管理された、素晴らしい設定と言えるでしょう。