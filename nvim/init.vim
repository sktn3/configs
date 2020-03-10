

set number

set clipboard+=unnamedplus   " クリップボードの使用
set visualbell               " ビープ音を可視化
"set laststatus=2            " ステータスラインを常に表示

" cursorl setting
set ruler                    " カーソルの位置表示
set cursorline               " カーソルハイライト
set cursorcolumn             " 現在の行を強調表示（縦）

" tab
set expandtab                " tabを複数のspaceに置き換え
set tabstop=4                " tabは半角2文字
set shiftwidth=4             " tabの幅
set softtabstop=4            " number of spaces in tab when editing
set autoindent
set list listchars=tab:\>\-    " 不可視文字を可視化(タブが「?-」と表示される)
set smartindent              " インデントはスマートインデント
set copyindent

set virtualedit=onemore      " 行末の1文字先までカーソルを移動できるように
set showmatch                " 括弧入力時の対応する括弧を表示
set wildmode=list:longest    " コマンドラインの補完

" file
set termencoding=utf-8       "文字コードをUFT-8に設定
set enc=utf-8
set fileencodings=utf-8      "文字コード自動判別
set fileformats=unix,dos,mac "改行コード自動判別
set noundofile               " undofileを作らない
set nobackup                 " バックアップファイルを作らない
set noswapfile               " スワップファイルを作らない
set autoread                 " 編集中のファイルが変更されたら自動で読み直す

"全角スペースをハイライト表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

" search
set ignorecase                " 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase                 " 検索文字列に大文字が含まれている場合は区別して検索する
set incsearch                 " 検索文字列入力時に順次対象文字列にヒットさせる
set wrapscan                  " 検索時に最後まで行ったら最初に戻る
set hlsearch                  " 検索語をハイライト表示
set inccommand=split          " 文字列置換をインタラクティブに表示
" very magic
nnoremap /  /\v


" return to normal mode
inoremap <C-c> <Esc>
nnoremap <C-c> <Esc>


" カーソル位置記憶
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif

" reset augroup
augroup MyAutoCmd
    autocmd!
augroup END

" ENV
let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $DATA = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME

" Load rc file
function! s:load(file) abort
    let s:path = expand('$CONFIG/nvim/rc/' . a:file . '.vim')

    if filereadable(s:path)
        execute 'source' fnameescape(s:path)
    endif
endfunction

call s:load('plugins')


" Plugin : vim-airline ====================================================
" モードの表示名を定義(デフォルトだと長くて横幅を圧迫するので略称にしている)
let g:airline_mode_map = {
            \ '__' : '-',
            \ 'n'  : 'N',
            \ 'i'  : 'I',
            \ 'R'  : 'R',
            \ 'c'  : 'C',
            \ 'v'  : 'V',
            \ 'V'  : 'V',
            \ 's'  : 'S',
            \ 'S'  : 'S',
            \ }


" パワーラインでかっこよく
let g:airline_powerline_fonts = 1
" カラーテーマ指定してかっこよく
let g:airline_theme = 'badwolf'
" タブバーをかっこよく
let g:airline#extensions#tabline#enabled = 1

" 選択行列の表示をカスタム(デフォルトだと長くて横幅を圧迫するので最小限に)
let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])

" virtulenvを認識しているか確認用に、現在activateされているvirtualenvを表示(vim-virtualenvの拡張)
let g:airline#extensions#virtualenv#enabled = 1

" gitのHEADから変更した行の+-を非表示(vim-gitgutterの拡張)
let g:airline#extensions#hunks#enabled = 0

" Lintツールによるエラー、警告を表示(ALEの拡張)
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#error_symbol = 'E:'
let g:airline#extensions#ale#warning_symbol = 'W:'

let g:airline_left_sep = '□'
let g:airline_left_alt_sep = '■'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'


" Plugin : deoplete =========================================================
let g:deoplete#enable_at_startup = 1



" Plugin :  w0rp/ale ========================================================
" 保存時のみ実行する
let g:ale_lint_on_text_changed = 0
" 表示に関する設定
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '□'
let g:airline#extensions#ale#open_lnum_symbol = '('
let g:airline#extensions#ale#close_lnum_symbol = ')'
let g:ale_echo_msg_format = '[%linter%]%code: %%s'
highlight link ALEErrorSign Tag
highlight link ALEWarningSign StorageClass
" Ctrl + kで次の指摘へ、Ctrl + jで前の指摘へ移動
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)



