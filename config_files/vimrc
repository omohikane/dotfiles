"#########全般#########
"文字コードUFT-8
set fenc=utf-8

" バックアップファイルを作らない
set nobackup

" スワップファイルを作らない
set noswapfile

" 変更されたら自動で読み直す
set autoread

" 入力中のコマンドをステータスに表示
set showcmd

" 履歴を10000件保存
set history=10000

" ヤンクでクリップボード
set clipboard=unnamed,autoselect

"タブ、空白、改行を可視化
set list 

"保管メニュー
set pumheight=10

"#########表示#########
"対応する括弧を表示
set showmatch matchtime=1
set showmatch

"コードの色分け
syntax on 

"ファイル名を表示
set title

" 現在の行を強調
set cursorline

" ビープ音
set visualbell

 "カーソル位置を表示
set ruler

"長くても表示
set display=lastline

"#########編集#########

"yyで1行ヤンク
nnoremap Y y$

" 不可視文字を可視化(タブが「?-」と表示される)
set list listchars=tab:\?\-

"インデントをスペース4つ
set tabstop=4 

"オートインデント
set smartindent

" コマンドラインの補完
set wildmode=list:longest

" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

"入力モード時のカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

"インクリメント、デクリメント
nnoremap + <C-a>
nnoremap - <C-x>




"#########検索設定#########
"UpLow区別なく検索
set ignorecase

"UpLow混在は区別 
set smartcase 

"最下部へ行ったら最上部へ戻る
set wrapscan 

" ハイライト表示
set hlsearch

" ESC*2　ハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
