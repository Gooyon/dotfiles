" ここからneobundle.vim 設定
" -------*-------*-------*-------*-------*-------*
set nocompatible               " Be iMproved
filetype off                   " Required!

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" BASE
NeoBundle 'Shougo/vimproc' " After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile || For Mac → make -f make_mac.mak
NeoBundle 'Shougo/neocomplcache'

NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell'

" Ruby
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-haml'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'thinca/vim-quickrun'

" Utility
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-surround'
NeoBundle 'YankRing.vim'
NeoBundle 'vim-scripts/sudo.vim'

" CVS
NeoBundle 'tpope/vim-fugitive'

" HTML
NeoBundle 'mattn/zencoding-vim'

" Color Scheme
NeoBundle 'wombat256.vim'
NeoBundle 'sexy-railscasts'


" Powerline Add 2013/01/26
" https://github.com/Lokaltog/vim-powerline
"NeoBundle 'Lokaltog/vim-powerline'


" Installation check.
if neobundle#exists_not_installed_bundles()
echomsg 'Not installed bundles : ' .
     \ string(neobundle#get_not_installed_bundle_names())
echomsg 'Please execute ":NeoBundleInstall" command.'
"finish
endif

" -------*-------*-------*-------*-------*-------*
" ここまでneobundle.vim 設定

