version 7.4
set titlestring=vim
set t_Co=256
set nocp
" if &cp | set nocp | endif
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
set completeopt=menu,preview
syntax on

" Encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932
set printencoding=utf-8

" Zen-Coding
let g:user_emmet_settings = {
\  'lang':'ja',
\}

au BufNewFile,BufRead Guardfile set filetype=ruby

au BufNewFile,BufRead *.go set filetype=go
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
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

" syntax highlight for jade
au BufNewFile,BufRead *.jade setf jade

" syntastic
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_mode_map = {
  \ 'mode': 'active',
  \ 'active_filetypes': ['ruby', 'javascript'],
  \ 'passive_filetypes': []
  \ }

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

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

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

" Enable slim syntax highlight
" autocmd FileType slim setlocal foldmethod=indent
autocmd BufNewFile,BufRead *.slim set filetype=slim

" AlpacaTags
augroup AlpacaTags
  autocmd!
  if exists(':Tags')
    autocmd BufWritePost Gemfile TagsBundle
    autocmd BufEnter * TagsSet
    " 毎回保存と同時更新する場合はコメントを外す
    " autocmd BufWritePost * TagsUpdate
  endif
augroup END

" Go lang complement
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")

" let g:quickrun_config = {
" \  'go': {
" \    'command': '8g',
" \    'exec': ['8g %s', '8l -o %s:p:r %s:p:r.8', '%s:p:r %a', 'rm -f %s:p:r']
" \  }
" \}

let g:quickrun_config.go = {
\     'type': 'go',
\     'command': 'go',
\     'exec': '%c run %s'
\     }

" indent guides
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=darkgrey
hi IndentGuidesEven ctermbg=lightgrey
let g:indent_guides_enable_on_vim_startup = 1

" Vundle
Bundle 'vim-scripts/AnsiEsc.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'ekalinin/Dockerfile.vim'
Bundle 'Shutnik/jshint2.vim'
Bundle 'fatih/vim-go'
Bundle 'vim-jp/vim-go-extra'
Bundle 'thinca/vim-quickrun'
Bundle 'alpaca-tc/alpaca_tags'
Bundle 'slim-template/vim-slim'
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
" Bundle 'kana/vim-smartinput'
Bundle "jiangmiao/auto-pairs"
Bundle 'violetyk/cake.vim'
Bundle 'kannokanno/previm'
Bundle 'vim-scripts/matchit.zip'
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

"colorscheme desert
colorscheme jellybeans
"colorscheme hybrid
