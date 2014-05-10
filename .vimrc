version 6.0
set titlestring=vim
set t_Co=256
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
let &cpo=s:cpo_save
unlet s:cpo_save
set encoding=utf-8
set backspace=2
set fileencodings=utf-8,ucs-bom,default,latin1
set helplang=ja
set modelines=0
set window=0
set history=1000
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))
" vim: set ft=vim :

set title
set number
set smarttab
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set formatoptions-=ro
set autoindent
set nocompatible
set scrolloff=5
set colorcolumn=80
set ruler
syntax on
"colorscheme desert
colorscheme jellybeans
"colorscheme hybrid

" Encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932
set printencoding=utf-8

" Zen-Coding
let g:user_emmet_settings = {
\  'lang':'ja',
\}

" Vundle
set rtp+=~/.vim/vundle/
call vundle#rc()
filetype plugin on

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_min_syntax_length = 4

" VimFiler
let g:vimfiler_as_default_explorer = 1

" Cake.vim
let g:cakephp_enable_auto_mode = 1

" vim-quickrun
let g:quickrun_config={'*': {'split': ''}}

" Vundle
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimfiler'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/dbext.vim'
Bundle 'vim-scripts/less-syntax'
Bundle 'vim-scripts/Zen-Color-Scheme'
Bundle 'kana/vim-smartinput'
Bundle 'violetyk/cake.vim'
Bundle 'thinca/vim-quickrun'
Bundle 'kannokanno/previm'
Bundle 'tsaleh/vim-matchit'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
Bundle 't9md/vim-chef'
Bundle 'flomotlik/vim-livereload'
Bundle 'osyo-manga/vim-over'
Bundle 'vim-scripts/Highlight-UnMatched-Brackets'
Bundle 'vim-scripts/Changed'
" Color Scheme
Bundle 'nanotech/jellybeans.vim'
Bundle 'mattn/emmet-vim'
Bundle 'rcmdnk/vim-markdown'
Bundle 'ap/vim-css-color'
