version 7.4
set titlestring=vim
set t_Co=256
set nocp
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
let &cpo=s:cpo_save
unlet s:cpo_save
set encoding=utf-8
set fileformat=unix
set backspace=2
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
set list " shows hidden characters as control character
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

" syntax for jade
au BufNewFile,BufRead *.jade setf jade

" syntastic
let g:syntastic_ruby_checkers = ['rubocop']

" remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" neosnippet https://github.com/Shougo/neosnippet.vim
" https://gist.github.com/alpaca-tc/4521425

" let s:default_snippet = neobundle#get_neobundle_dir() . '/neosnippet/autoload/neosnippet/snippets' " 本体に入っているsnippet
let s:my_snippet = '~/.vim/snippets' " 自分のsnippet
let g:neosnippet#snippets_directory = s:my_snippet
" let g:neosnippet#snippets_directory = s:default_snippet . ',' . s:my_snippet
imap <silent><C-F>            <Plug>(neosnippet_expand_or_jump)
inoremap <silent><C-U>        <ESC>:<C-U>Unite snippet<CR>
nnoremap <silent><Space>e     :<C-U>NeoSnippetEdit -split<CR>
smap <silent><C-F>            <Plug>(neosnippet_expand_or_jump)
" xmap <silent>o              <Plug>(neosnippet_register_oneshot_snippet)
"}}}

" airline
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#branch#enabled = 0
" unicode symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
set guifont=Octicons
let g:airline_left_sep = ' »'
let g:airline_left_sep = ' ▶'
let g:airline_right_sep = ' «'
let g:airline_right_sep = ' ◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇ '
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline_section_b =
        \ '%{airline#extensions#branch#get_head()}' .
        \ '%{""!=airline#extensions#branch#get_head()?("  " . g:airline_left_alt_sep . " "):""}' .
        \ '%t%( %M%)'

set laststatus=2

" Vundle
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimfiler'
Bundle 'Shougo/neosnippet.vim'
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
Bundle 'vim-scripts/matchit.zip'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
Bundle 't9md/vim-chef'
Bundle 'flomotlik/vim-livereload'
Bundle 'osyo-manga/vim-over'
Bundle 'vim-scripts/Highlight-UnMatched-Brackets'
Bundle 'digitaltoad/vim-jade'
Bundle 'toyamarinyon/vim-swift'
Bundle 'tpope/vim-endwise'
Bundle 'ngmy/vim-rubocop'
Bundle 'vim-scripts/ruby-matchit'
Bundle 'scrooloose/syntastic'
" Color Scheme
Bundle 'nanotech/jellybeans.vim'
Bundle 'mattn/emmet-vim'
Bundle 'ap/vim-css-color'
