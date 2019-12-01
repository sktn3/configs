
scriptencoding utf-8 "これ入れないと下記が反映されない
augroup highlightZenkakuSpace "全角スペースを赤色にする
  autocmd!
  autocmd VimEnter,ColorScheme * highlight ZenkakuSpace term=underline ctermbg=Red guibg=Red
  autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
augroup END

""Display
colorscheme desert
set background=dark
syntax on "シンタックスカラーリングを設定する
set number "行番号を表示する
set title "編集中のファイル名を表示する
set showcmd "入力中のコマンドを表示する
set ruler "座標を表示する
set showmatch "閉じ括弧の入力時に対応する括弧を表示する
set matchtime=3 "showmatchの表示時間
set laststatus=2 "ステータスラインを常に表示する。
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}[%Y]%=%l,%c%V%8P[%L]
set showmode
set ambiwidth=double
set cursorline   " 現在行に下線を引く
set nowrap    " はみ出しの折り返し設定
"" 空白文字を表示
set nolist "タブ、行末等の不可視文字を表示しない
"set list "タブ、行末等の不可視文字を表示する
"set listchars=tab:> ,trail:_,eol:$


""Input
set cindent "C言語のインデントに従って自動インデントを行う
set shiftwidth=2 "行頭での<Tab>の幅
set tabstop=2 "行頭以外での<Tab>の幅
set softtabstop=2 "expandtabで<Tab>が対応する<Space>の数
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,] "カーソルを行頭、行末で止まらないようにする
set clipboard=unnamed "クリップボードを利用する
set expandtab "<Tab>の代わりに<Space>を挿入する

""Search
set incsearch "インクリメンタルサーチを行う
set hlsearch "検索結果をハイライトする
set ignorecase "検索時に文字の大小を区別しない
set smartcase "検索時に大文字を含んでいたら大小を区別する
set wrapscan "検索をファイルの先頭へループする


""カーソル位置などの設定保存 
autocmd BufWinLeave ?* silent mkview
autocmd BufWinEnter ?* silent loadview
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" | endif
augroup END

""" 挿入モード中に'Ctr-*'でコマンドモードでの移動を可能にする
""カーソルを右へ（foward）
inoremap <c-f> <right>
""カーソルを左へ（backward）
inoremap <c-b> <left>


""delete キーを押すと、 ^? と出た
noremap! <C-?> <C-h>


"" vim-go
call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
call plug#end()








