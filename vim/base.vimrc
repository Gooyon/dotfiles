" -------*-------*-------*-------*-------*-------*
" 基本設定
" -------*-------*-------*-------*-------*-------*


" --------------------------------------------
"カラースキーマを設定
colorscheme wombat256mod
" --------------------------------------------

" ;でコマンド入力( ;と:を入れ替)
noremap ; :
noremap : ;

" --------------------------------------------
" 定義済のautocommandを全て削除
" --------------------------------------------
augroup MyAutoCmd
    autocmd!
augroup END

syntax on
"filetype on
"filetype indent on
"filetype plugin on

scriptencoding utf8

set nowrap

" 編集中でも他のファイルを開けるようにする
set hidden

" テキスト整形オプション，マルチバイト系を追加
set formatoptions+=loq
"日本語の行の連結時には空白を入力しない。
set formatoptions+=mM
"8進数を無効にする。<C-a>,<C-x>などに影響する。
set nrformats-=octal
"キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)。
set timeoutlen=3500
"Visual blockモードでフリーカーソルを有効にする。
set virtualedit=block
" ビープをならさない
set vb t_vb=
"カーソルキーで行末／行頭の移動可能に設定。
set whichwrap=b,s,[,],<,>
set autoread                   " 他で書き換えられたら自動で読み直す
set whichwrap=b,s,h,l,<,>,[,]  " カーソルを行頭、行末で止まらないようにする
set scrolloff=8                " スクロール時の余白確保
set showmatch                  " 括弧の対応をハイライト
set number            " 行番号表示
" コマンド補完を強化
set wildmenu
set wildmode=list:full " リスト表示，最長マッチ
" コマンド・検索パターンの履歴数
set history=1000
" スペース、タブ、改行などを表示する
set list
set lcs=tab:>-,trail:_,extends:\

"□や○の文字があってもカーソル位置がずれないようにする。
if exists('&ambiwidth')
  set ambiwidth=double
endif

set showtabline=2

" バックアップ
set nowritebackup
set nobackup
set noswapfile

"クリップボードを共有。
set clipboard+=unnamed

"エラー時の音とビジュアルベルの抑制。
" --------------------------------------------
set noerrorbells
set novisualbell
set visualbell t_vb=


" 検索
" --------------------------------------------
set wrapscan     " 最後まで検索したら先頭へ戻る
set ignorecase   " 大文字小文字無視
set smartcase    " 大文字ではじめたら大文字小文字無視しない
set noincsearch  " インクリメンタルサーチOFF
set hlsearch     " 検索文字をハイライト

" エンコーディング
" --------------------
set encoding=utf-8
set fileencodings=euc-jp,shift-jis,iso-2022-jp

" タブ、インデント
" --------------------------------------------
set smartindent
set smarttab
set expandtab
set autoindent
"タブ幅をリセット
"autocmd MyAutoCmd BufNewFile,BufRead * set tabstop=4 shiftwidth=4
set tabstop=4 shiftwidth=4

" バックスペースでインデントや改行を削除
set backspace=indent,eol,start

" ステータスラインの設定
" -----------------------
set laststatus=2 " 常にステータスラインを表示
set statusline=%{expand('%:p:t')}\ %<\(%{SnipMid(expand('%:p:h'),80-len(expand('%:p:t')),'...')}\)%=\ %m%r%y%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}[%3l,%3c]
" コマンドラインの高さ
set cmdheight=1
"コマンドをステータス行に表示
set showcmd
"画面最後の行をできる限り表示する。
set display=lastline

" タイトル文字の設定
" --------------------
set titlestring=%{expand('%:p:t')}%(\ %m%r%w%)\ %<\(%{SnipMid(expand('%:p:h'),80-len(expand('%:p:t')),'...')}\)\ -\ Vim

function! SnipMid(str, len, mask)
    if a:len >= len(a:str)
        return a:str
    elseif a:len <= len(a:mask)
        return a:mask
    endif
    let len_head = (a:len - len(a:mask)) / 2
    let len_tail = a:len - len(a:mask) - len_head
    return (len_head > 0 ? a:str[: len_head - 1] : '') . a:mask . (len_tail > 0 ? a:str[-len_tail :] : '')
endfunction

" --------------------
" 前回の終了位置に戻る
" --------------------
autocmd MyAutoCmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" --------------------
"全角スペースを表示
" --------------------
if has('syntax')
  "コメント以外で全角スペースを指定しているので scriptencodingと、
  "このファイルのエンコードが一致するよう注意！
  "全角スペースが表示されない場合、ここでscriptencodingを指定すると良い。
  "scriptencoding cp932
  syntax on
  function! ActivateInvisibleIndicator()
    highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
    "全角スペースを明示的に表示する。
    silent! match ZenkakuSpace /　/
  endfunction
  augroup InvisibleIndicator
    autocmd!
    autocmd VimEnter,BufEnter * call ActivateInvisibleIndicator()
  augroup END
endif
" --------------------
"挿入モード時、ステータスラインの色を変更
" --------------------
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  syntax on
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

" grep
" ----------
"vimgrep をデフォルトのgrepとする場合internal
set grepprg=internal
" .svn以下をgrepしない
" set grepprg=grep\ -nH\ $*\ \\\|\ grep\ -v\ .svn

" カレントウィンドウのカーソル行のみハイライト
" --------------------------------------------
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" -------*-------*-------*-------*-------*-------*
" カスタムキーバインド
" -------*-------*-------*-------*-------*-------*

" キーマップリーダー
" --------------------------------------------
let mapleader=","

nnoremap <Space>w   : write<CR>
nnoremap <Space>d   : bd<CR>
nnoremap <Space>q   : q<CR>

nnoremap <C-h>      : <C-u>help<Space>
nnoremap <C-h><C-h> : <C-u>help<Space><C-r><C-w><CR>

" 改行コードを変更
nmap ,d :set fileformat=dos<cr>
nmap ,m :set fileformat=mac<cr>
nmap ,u :set fileformat=unix<cr>

" 検索結果のハイライト消す(,nn)
" --------------------------------------------
nnoremap <silent> <Leader>nn :nohlsearch<CR>

" 論理行と表示行のキーバインディングを入れ替える
" --------------------------------------------
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" .vimrcを編集したり再読み込みするためのショートカット
" --------------------------------------------
" vimrcを編集
nnoremap <Space>.  : <C-u>edit $MYVIMRC<CR>
" gvimrcを編集
nnoremap <Space>,  : <C-u>edit $MYGVIMRC<CR>


" .vimrcを再読み込み
nnoremap <Space>s. : <C-u>source $MYVIMRC<CR>
" .gvimrcを再読み込み
nnoremap <Space>s, : <C-u>source $MYGVIMRC<CR>

" インサートモードのとき ,date で日付を挿入する
" --------------------------------------------
inoremap <Leader>date <C-R>=strftime('%Y/%m/%d (%a)')<CR>

" タブの操作
" --------------------------------------------
nnoremap <silent> tc :<C-u>tabnew<CR>:tabmove<CR>
nnoremap <silent> tk :<C-u>tabclose<CR>
nnoremap <silent> tn :<C-u>tabnext<CR>
nnoremap <silent> tp :<C-u>tabprevious<CR>


" 文字コードを指定して開き直す
" --------------------------------------------------------
command! Cp932     edit ++enc=cp932<CR>
command! Utf8      edit ++enc=utf-8<CR>
command! Eucjp     edit ++enc=euc-jp<CR>
command! Iso2022jp edit ++enc=iso2022jp<CR>
command! Jis       Iso2022jp
command! Sjis      Cp932

