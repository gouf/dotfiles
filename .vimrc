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
" set modelines=0 " disable modeline
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

" Ref: https://stackoverflow.com/questions/1416572/vi-vim-restore-opened-files
map <F2> :source ~/.vim-session <cr>     " Quick write session with F3
map <F3> :mksession! ~/.vim-session <cr> " And load session with F2

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

"
" vim-quickrun
"
let g:quickrun_config = {} " Init
let g:quickrun_config['*'] = {'split': ''}

"
" pt integration
"
nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
endif

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

"
" Syntax Highlight
"

" syntax highlight for jade
au BufNewFile,BufRead *.jade setf jade
au BufRead,BufNewFile *.json set filetype=json

" syntax highlight for textlint
au BufRead,BufNewFile .textlintrc set filetype=json

" syntax highlight for slim
autocmd BufNewFile,BufRead *.slim set filetype=slim

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

"
" airline
"
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
let b:ale_fixers = {'ruby': ['rubocop']}
let g:ale_fix_on_save = 1

" Search Tasks
let g:searchtasks_list=["TODO", "FIXME", "NOTE", "BUG"]

command TodoList SearchTasks ./**

" vim-matchup
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_timeout = 10
let g:matchup_matchparen_insert_timeout = 30
let g:matchparen_matchparen_deferred_show_time = 20
let g:matchparen_matchparen_deferred_hide_time = 100

" operator-flashy (yank to blink)
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

"
" dein
"
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/gouf/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/gouf/.cache/dein')
  call dein#begin('/home/gouf/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/gouf/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  " call dein#add('Shougo/neosnippet.vim')
  " call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  " call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

  call dein#add('2072/PHP-Indenting-for-VIm')
  call dein#add('Shougo/neocomplcache')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/vimfiler')
  call dein#add('Shougo/vimproc')
  call dein#add('Shutnik/jshint2.vim')
  call dein#add('StanAngeloff/php.vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('aklt/plantuml-syntax')
  call dein#add('alpaca-tc/alpaca_tags')
  call dein#add('andymass/vim-matchup')
  call dein#add('ap/vim-css-color')
  call dein#add('bling/vim-airline')
  call dein#add('digitaltoad/vim-jade')
  call dein#add('ecomba/vim-ruby-refactoring')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('ekalinin/Dockerfile.vim')
  call dein#add('elixir-lang/vim-elixir')
  call dein#add('fatih/vim-go')
  call dein#add('gilsondev/searchtasks.vim')
  call dein#add('groenewege/vim-less')
  call dein#add('hashivim/vim-terraform')
  call dein#add('haya14busa/vim-operator-flashy')
  call dein#add('hotwatermorning/auto-git-diff')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('kana/vim-operator-user')
  call dein#add('kana/vim-smartinput')
  call dein#add('kannokanno/previm')
  call dein#add('kchmck/vim-coffee-script')
  call dein#add('m2mdas/phpcomplete-extended')
  call dein#add('majutsushi/tagbar')
  call dein#add('mattn/emmet-vim')
  call dein#add('mechatroner/rainbow_csv')
  call dein#add('mxw/vim-jsx')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('ngmy/vim-rubocop')
  call dein#add('nvie/vim-flake8')
  call dein#add('osyo-manga/vim-over')
  call dein#add('pangloss/vim-javascript')
  call dein#add('rhysd/vim-crystal')
  call dein#add('rizzatti/dash.vim')
  call dein#add('rizzatti/funcoo.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('slim-template/vim-slim')
  call dein#add('thinca/vim-quickrun')
  call dein#add('toyamarinyon/vim-swift')
  call dein#add('tpope/vim-endwise')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-pathogen')
  call dein#add('tpope/vim-rails')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')
  call dein#add('triglav/vim-visual-increment')
  call dein#add('tyru/open-browser.vim')
  call dein#add('vim-jp/vim-go-extra')
  call dein#add('vim-scripts/AnsiEsc.vim')
  call dein#add('vim-scripts/Highlight-UnMatched-Brackets')
  call dein#add('vim-scripts/Zen-Color-Scheme')
  call dein#add('vim-scripts/dbext.vim')
  call dein#add('vim-scripts/less-syntax')
  call dein#add('vim-scripts/todolist.vim')
  call dein#add('w0rp/ale')
  call dein#add('weirongxu/plantuml-previewer.vim')
  call dein#add('wsdjeg/dein-ui.vim')
  call dein#add('xolox/vim-easytags')
  call dein#add('xolox/vim-misc')
  " Color Scheme
  call dein#add('nanotech/jellybeans.vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

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
