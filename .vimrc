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
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))|write %:p
command! CurrentFilePath :echo expand('%:p')
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
set colorcolumn=120
set ruler
set list " shows hidden characters as control character
set completeopt=menu,preview

autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd FileType php setlocal tabstop=4 shiftwidth=4 expandtab

" Tag jump
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-j> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

nmap <Leader>gd <Plug>(auto_git_diff_manual_update)

" Encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932
set printencoding=utf-8

" Zen-Coding
let g:user_emmet_settings = {
\  'lang':'ja',
\}

au BufNewFile,BufRead Routefile set ft=ruby

au BufNewFile,BufRead *.go set filetype=go
autocmd FileType go autocmd BufWritePre <buffer> Fmt

au BufNewFile,BufRead *.cjsx set filetype=coffee
au BufNewFile,BufRead *.coffee set filetype=coffee

au BufNewFile,BufRead Guardfile set filetype=ruby

filetype plugin indent on
syntax on

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
au BufRead,BufNewFile *.json set filetype=json

" syntax highlight for textlint
au BufRead,BufNewFile .textlintrc set filetype=json

" syntastic
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'
let g:syntastic_json_checkers=['jsonlint']
let g:syntastic_php_checkers = ['phpcs']
let g:syntastic_php_phpcs_args='--standard=psr2'
let g:syntastic_python_checkers = ['pep8', 'pyflakes']
let g:syntastic_mode_map = {
  \ 'mode': 'active',
  \ 'active_filetypes': ['ruby', 'javascript', 'php', 'python'],
  \ 'passive_filetypes': []
  \ }

" remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Ref: http://hail2u.net/blog/software/vim-additional-highlights.html
" Additional highlights
augroup AdditionalHighlights
  autocmd!

  " Zenkaku space
  autocmd ColorScheme * highlight link ZenkakuSpace Error
  autocmd Syntax * syntax match ZenkakuSpace containedin=ALL /　/
augroup END

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

let g:quickrun_config.go = {
\     'type': 'go',
\     'command': 'go',
\     'exec': '%c run %s'
\     }

" Swift quickrun
let g:quickrun_config['swift'] = {
  \ 'command': 'swift',
  \ 'exec': '%c %o %s',
  \}
" indent guides
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=darkgrey
hi IndentGuidesEven ctermbg=lightgrey
let g:indent_guides_enable_on_vim_startup = 1

execute pathogen#infect('~/.anyenv/envs/rbenv/shims/{}')
se shell=bash\ -l


let g:previm_open_cmd = 'gnome-open'
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

" vim-flay
" let g:flay_on_open=0
" let g:flay_on_save=1
" let g:flay_minimum_mass=10
" let g:flay_piet_text="✗"

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  " Vundle
  Plugin 'prophittcorey/vim-flay'
  Plugin 'fousa/vim-flog'
  Plugin 'hotwatermorning/auto-git-diff'
  Plugin 'triglav/vim-visual-increment'
  Plugin 'nvie/vim-flake8'
  Plugin 'groenewege/vim-less'
  Plugin '2072/PHP-Indenting-for-VIm'
  Plugin 'majutsushi/tagbar'
  Plugin 'xolox/vim-easytags'
  Plugin 'xolox/vim-misc'
  Plugin 'elixir-lang/vim-elixir'
  Plugin 'rhysd/vim-crystal'
  Plugin 'kannokanno/previm'
  Plugin 'gmarik/Vundle.vim'
  Plugin 'tpope/vim-pathogen'
  Plugin 'kchmck/vim-coffee-script'
  Plugin 'vim-scripts/AnsiEsc.vim'
  Plugin 'nathanaelkane/vim-indent-guides'
  Plugin 'ekalinin/Dockerfile.vim'
  Plugin 'pangloss/vim-javascript'
  Plugin 'mxw/vim-jsx'
  Plugin 'Shutnik/jshint2.vim'
  Plugin 'fatih/vim-go'
  Plugin 'vim-jp/vim-go-extra'
  Plugin 'thinca/vim-quickrun'
  Plugin 'alpaca-tc/alpaca_tags'
  Plugin 'slim-template/vim-slim'
  Plugin 'tpope/vim-fugitive'
  Plugin 'airblade/vim-gitgutter'
  Plugin 'bling/vim-airline'
  Plugin 'ecomba/vim-ruby-refactoring'
  Plugin 'Shougo/neocomplcache'
  Plugin 'Shougo/unite.vim'
  Plugin 'Shougo/vimfiler'
  Plugin 'Shougo/neosnippet.vim'
  Plugin 'tpope/vim-surround'
  Plugin 'scrooloose/nerdtree'
  Plugin 'vim-scripts/dbext.vim'
  Plugin 'vim-scripts/less-syntax'
  Plugin 'vim-scripts/Zen-Color-Scheme'
  Plugin 'kana/vim-smartinput'
  Plugin 'jiangmiao/auto-pairs'
  Plugin 'vim-scripts/matchit.zip'
  Plugin 'rizzatti/funcoo.vim'
  Plugin 'rizzatti/dash.vim'
  Plugin 'flomotlik/vim-livereload'
  Plugin 'osyo-manga/vim-over'
  Plugin 'vim-scripts/Highlight-UnMatched-Brackets'
  Plugin 'digitaltoad/vim-jade'
  Plugin 'toyamarinyon/vim-swift'
  Plugin 'tpope/vim-endwise'
  Plugin 'ngmy/vim-rubocop'
  Plugin 'vim-scripts/ruby-matchit'
  Plugin 'scrooloose/syntastic'
  " Color Scheme
  Plugin 'nanotech/jellybeans.vim'
  Plugin 'mattn/emmet-vim'
  Plugin 'ap/vim-css-color'
call vundle#end()

"colorscheme desert
colorscheme jellybeans
"colorscheme hybrid
