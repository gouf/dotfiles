version 8.0
let skip_defaults_vim=1
set viminfo=""
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
autocmd filetype crontab setlocal nobackup nowritebackup

au BufNewFile,BufRead *.php se ft=php

" StanAngeloff/php.vim
function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

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

au BufNewFile,BufRead *.swift se ft=swift

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
let g:quickrun_config = {} " Init
let g:quickrun_config['*'] = {'split': ''}

" Ref: https://github.com/pocke/dotfiles/commit/ef7039170cdfe245c9b92c105700652b9e59b299
let g:quickrun_config['_'] = {
\   'runner': 'vimproc',
\   'runner/vimproc/updatetime': 60,
\   'tempfile': '%{expand("%:p:h") . "/" . system("echo -n $(uuidgen)")}'
\ }

let g:quickrun_config['go'] = {
\   'type': 'go',
\   'command': 'go',
\   'cmdopt': 'run',
\   'exec': '%c %o %s'
\ }

" Swift quickrun
let g:quickrun_config['swift'] = {
\ 'command': 'xcrun',
\ 'cmdopt': 'swift',
\ 'exec': '%c %o %s',
\ }

" Haskell quickrun
let g:quickrun_config['haskell'] = { 'type': 'haskell/stack' }
let g:quickrun_config['haskell/stack'] = {
\  'command': 'stack',
\  'cmdopt': 'runghc',
\  'exec': '%c %o %s %a'
\ }

" syntax highlight for jade
au BufNewFile,BufRead *.jade setf jade
au BufRead,BufNewFile *.json set filetype=json

" syntax highlight for textlint
au BufRead,BufNewFile .textlintrc set filetype=json


" remove trailing whitespace on save
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

" indent guides
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=darkgrey
hi IndentGuidesEven ctermbg=lightgrey
let g:indent_guides_enable_on_vim_startup = 1

let g:previm_open_cmd = 'gnome-open'
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

" Ale (Lint Engine)
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_column_always = 1

" Search Tasks
let g:searchtasks_list=["TODO", "FIXME", "NOTE", "BUG"]

command TodoList SearchTasks ./**

" vim-matchup
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_timeout = 30
let g:matchup_matchparen_insert_timeout = 60
let g:matchparen_matchparen_deferred_show_time = 50
let g:matchparen_matchparen_deferred_hide_time = 200

" operator-flashy
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  " Vundle
  Plugin 'mechatroner/rainbow_csv'
  Plugin 'kana/vim-operator-user'
  Plugin 'haya14busa/vim-operator-flashy'
  Plugin 'tpope/vim-rails'
  Plugin 'tpope/vim-repeat'
  Plugin 'vim-scripts/todolist.vim'
  Plugin 'gilsondev/searchtasks.vim'
  Plugin 'StanAngeloff/php.vim'
  Plugin 'Shougo/neosnippet-snippets'
  Plugin 'Shougo/vimproc'
  Plugin 'majutsushi/tagbar'
  Plugin 'm2mdas/phpcomplete-extended'
  Plugin 'hotwatermorning/auto-git-diff'
  Plugin 'triglav/vim-visual-increment'
  Plugin 'nvie/vim-flake8'
  Plugin 'groenewege/vim-less'
  Plugin '2072/PHP-Indenting-for-VIm'
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
  Plugin 'rizzatti/funcoo.vim'
  Plugin 'rizzatti/dash.vim'
  Plugin 'osyo-manga/vim-over'
  Plugin 'vim-scripts/Highlight-UnMatched-Brackets'
  Plugin 'digitaltoad/vim-jade'
  Plugin 'toyamarinyon/vim-swift'
  Plugin 'tpope/vim-endwise'
  Plugin 'ngmy/vim-rubocop'
  Plugin 'andymass/vim-matchup'
  Plugin 'w0rp/ale'
  " Color Scheme
  Plugin 'nanotech/jellybeans.vim'
  Plugin 'mattn/emmet-vim'
  Plugin 'ap/vim-css-color'
call vundle#end()

"colorscheme desert
colorscheme jellybeans
"colorscheme hybrid

execute pathogen#infect()

se statusline+=%#warningmsg#
se statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:phpcomplete_index_composer_command = '/home/gouf/.local/bin/composer.phar'

" change Spellcap background color
hi SpellCap term=reverse cterm=underline ctermbg=17 gui=underline guibg=#002442 guisp=DarkBlue
