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
set cursorline
set helplang=ja,en
set redrawtime=4000

autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd filetype crontab setlocal nobackup nowritebackup
au filetype java setlocal ts=4 sts=2 sw=4 noet listchars=tab:»･

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

"
" <C-w> configures
"
nnoremap <C-w>t :tab sp<CR>
nnoremap <C-w>T :tabnew<CR>
" nnoremap <C-w>L :terminal<CR>

nnoremap <NL> i<CR><ESC>

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
au BufNewFile,BufRead *.rb set ft=ruby

au BufNewFile,BufRead *.erb set ft=eruby

au BufNewFile,BufRead *.go set filetype=go
autocmd FileType go autocmd BufWritePre <buffer> Fmt

au BufNewFile,BufRead *.cjsx set filetype=coffee
au BufNewFile,BufRead *.coffee set filetype=coffee

au BufNewFile,BufRead Guardfile set filetype=ruby

au BufNewFile,BufRead *.swift se ft=swift

au BufNewFile,BufRead .bash_functions se ft=sh
au BufNewFile,BufRead .bash_aliases se ft=sh

au BufNewFile,BufRead Dockerfile se ft=dockerfile

" fold などの設定を自動保存・読み込み
au BufWinLeave *.* mkview!
au BufWinEnter *.* silent loadview

filetype plugin indent on

"
" incsearch.vim
"
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"
" incsearch-fuzzy.vim
"
" map f/ <Plug>(incsearch-fuzzy-/)
map f? <Plug>(incsearch-fuzzy-?)
map fg/ <Plug>(incsearch-fuzzy-stay)

"
" operator-camelize
"
map gC <Plug>(operator-camelize-toggle)

"
" ctrlp
"
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"   \ 'file': '\v\.(exe|so|dll)$',
"   \ 'link': 'some_bad_symbolic_links',
"   \
" }
" let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
" let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows

if executable('fd')
  let g:ctrlp_user_command = 'fd --type f --color never . %s | grep -v vendor/bundle'
endif

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

"
" easytags
"
let g:easytags_async = 1
let g:easytags_syntax_keyword = 'always'

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
" Solargraph
"
if executable('solargraph')
    " gem install solargraph
    au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
endif

"
" unite.vim
"
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,y :<C-u>Unite history/yank<CR>
nnoremap <silent> ,b :<C-u>Unite buffer<CR>
nnoremap <silent> ,f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,u :<C-u>Unite file_mru buffer<CR>

"
" pt integration
"
nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
endif

" QuickRun Trigger key
nnoremap <leader>r :QuickRun<CR>

let g:quickrun_config = {}

let g:quickrun_config['ruby'] = {
\     'type': 'ruby',
\     'command': 'ruby',
\     'cmdopt': '',
\     'exec': '%c %o %s'
\}
" General
" Ref: https://github.com/pocke/dotfiles/commit/ef7039170cdfe245c9b92c105700652b9e59b299
let g:quickrun_config['_'] = {
\   'runner': 'terminal',
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

let g:quickrun_config['markdown'] = {
\  'runner': 'shell',
\  'outputter': 'null',
\  'command': ':PrevimOpen',
\  'exec': '%c',
\ }

"
" Toggle Pane Maximize
"
nnoremap <C-W>O :call MaximizeToggle()<CR>
nnoremap <C-W>o :call MaximizeToggle()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle()<CR>

function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction

" Move current line to up/down
" Ref: https://vim.fandom.com/wiki/Moving_lines_up_or_down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" When MacOS
" Ref: https://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
if has('macunix')
  " Option + J/K
  " ∆ == J
  " ˚ == K
  nnoremap ∆ :m .+1<CR>==
  nnoremap ˚ :m .-2<CR>==
  inoremap ∆ <Esc>:m .+1<CR>==gi
  inoremap ˚ <Esc>:m .-2<CR>==gi
  vnoremap ∆ :m '>+1<CR>gv=gv
  vnoremap ˚ :m '<-2<CR>gv=gv
endif

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

let s:default_snippet =  expand('~/.cache/dein') . '/neosnippet/autoload/neosnippet/snippets'

let s:my_snippet = '~/.vim/snippets' " 自分のsnippet
let g:neosnippet#snippets_directory = s:my_snippet
" let g:neosnippet#snippets_directory = s:default_snippet . ',' . s:my_snippet
imap <silent><C-F>            <Plug>(neosnippet_expand_or_jump)
inoremap <silent><C-U>        <ESC>:<C-U>Unite snippet<CR>
nnoremap <silent><Space>e     :<C-U>NeoSnippetEdit -split<CR>
smap <silent><C-F>            <Plug>(neosnippet_expand_or_jump)
" xmap <silent>o              <Plug>(neosnippet_register_oneshot_snippet)
"}}}

" LanguageClient-neovim
set hidden
let g:LanguageClient_serverCommands = {
    \ 'ruby': ['~/.anyenv/envs/rbenv/shims/solargraph', 'stdio']
    \}
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

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
        \ '%{""!=airline#extensions#branch#get_head()?("  " . g:airline_left_alt_sep . " "):""}'

let g:airline_section_warning =
  \ '%{LinterStatus()}'

set laststatus=2

" Go lang complement
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")

" indent guides
let g:indent_guides_auto_colors = 0

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=Grey11 ctermbg=234 guifg=Grey42 ctermfg=242
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=Grey19 ctermbg=236 guifg=Grey35 ctermfg=240

let g:indent_guides_enable_on_vim_startup = 1

"
" Previm settings
"
if has('macunix')
  let g:previm_open_cmd = 'open'
elseif has('unix')
  let g:previm_open_cmd = 'gnome-open'
elseif has('win32')
  let g:previm_open_cmd = 'start'
endif

augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

"
" Ale (Lint Engine)

let g:ale_set_highlights = 0
"
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign
let g:ale_sign_column_always = 0
" let g:ale_fix_on_save = 1
nmap <silent> ]w <Plug>(ale_next_wrap)
nmap <silent> [w <Plug>(ale_previous_wrap)]

" Ref:
" https://github.com/dense-analysis/ale/blob/4fe7402e89/README.md#5v-how-can-i-show-errors-or-warnings-in-my-statusline
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" set statusline+=%{LinterStatus()}

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

" dein.vimのディレクトリ
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" なければgit clone
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#end()
  call dein#save_state()
endif

let g:dein#auto_recache = 1

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " 管理するプラグインを記述したファイル
  let s:toml = '~/.dein.toml'
  let s:lazy_toml = '~/.dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " Let dein manage dein
  " Required:
  call dein#add(s:dein_repo_dir)

  " Add or remove your plugins here:
  " call dein#add('Shougo/neosnippet.vim')
  " call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  " call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

  call dein#add('Shougo/defx.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  " call dein#add('neoclide/coc.nvim')
  call dein#add('autozimu/LanguageClient-neovim', {
        \ 'rev': 'next',
        \ 'build': 'bash install.sh',
        \ })
  call dein#add('2072/PHP-Indenting-for-VIm')
  call dein#add('IJustDev/vim-ruby-refactoring')
  call dein#add('Shougo/neocomplcache')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neoyank.vim')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/vimfiler')
  call dein#add('Shougo/vimproc')
  call dein#add('Shutnik/jshint2.vim')
  call dein#add('StanAngeloff/php.vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('aklt/plantuml-syntax')
  call dein#add('andymass/vim-matchup')
  call dein#add('ap/vim-css-color')
  call dein#add('bling/vim-airline')
  call dein#add('cespare/vim-toml')
  call dein#add('dag/vim-fish')
  call dein#add('dense-analysis/ale')
  call dein#add('digitaltoad/vim-jade')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('ekalinin/Dockerfile.vim')
  call dein#add('elixir-lang/vim-elixir')
  call dein#add('fatih/vim-go')
  call dein#add('gilsondev/searchtasks.vim')
  call dein#add('groenewege/vim-less')
  call dein#add('hashivim/vim-terraform')
  call dein#add('haya14busa/incsearch-fuzzy.vim')
  call dein#add('haya14busa/incsearch.vim')
  call dein#add('haya14busa/vim-operator-flashy')
  call dein#add('hotwatermorning/auto-git-diff')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('kana/vim-operator-user')
  call dein#add('kana/vim-smartinput')
  call dein#add('kchmck/vim-coffee-script')
  call dein#add('kien/ctrlp.vim')
  call dein#add('leafgarland/typescript-vim')
  call dein#add('mattn/emmet-vim')
  call dein#add('mechatroner/rainbow_csv')
  call dein#add('mxw/vim-jsx')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('ngmy/vim-rubocop')
  call dein#add('nvie/vim-flake8')
  call dein#add('osyo-manga/vim-over')
  call dein#add('pangloss/vim-javascript')
  call dein#add('posva/vim-vue')
  call dein#add('previm/previm')
  call dein#add('rhysd/vim-crystal')
  call dein#add('rizzatti/dash.vim')
  call dein#add('rizzatti/funcoo.vim')
  call dein#add('rust-lang/rust.vim')
  call dein#add('slim-template/vim-slim')
  call dein#add('thinca/vim-quickrun')
  call dein#add('toyamarinyon/vim-swift')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-endwise')
  call dein#add('tpope/vim-pathogen')
  call dein#add('tpope/vim-rails')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')
  call dein#add('triglav/vim-visual-increment')
  call dein#add('tyru/open-browser.vim')
  call dein#add('tyru/operator-camelize.vim')
  call dein#add('vim-jp/vim-go-extra')
  call dein#add('vim-jp/vim-java')
  call dein#add('vim-scripts/AnsiEsc.vim')
  call dein#add('vim-scripts/Highlight-UnMatched-Brackets')
  call dein#add('vim-scripts/Zen-Color-Scheme')
  call dein#add('vim-scripts/blockle.vim')
  call dein#add('vim-scripts/dbext.vim')
  call dein#add('vim-scripts/less-syntax')
  call dein#add('vim-scripts/todolist.vim')
  call dein#add('weirongxu/plantuml-previewer.vim')
  call dein#add('wsdjeg/dein-ui.vim')
  call dein#add('xolox/vim-easytags')
  call dein#add('xolox/vim-misc')
  call dein#add('yuttie/comfortable-motion.vim')
  " Color Scheme
  call dein#add('nanotech/jellybeans.vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

execute pathogen#infect()

se statusline+=%#warningmsg#
se statusline+=%*

" change Spellcap background color
" hi SpellCap term=reverse cterm=underline ctermbg=17 gui=underline guibg=#002442 guisp=DarkBlue
hi SpellCap term=reverse cterm=underline ctermbg=17 gui=underline guibg=#3A8A5A guisp=DarkBlue

" Ref: http://hail2u.net/blog/software/vim-additional-highlights.html
" Additional highlights
augroup AdditionalHighlights
  autocmd!

  " Zenkaku space
  autocmd ColorScheme * highlight link ZenkakuSpace SpellBad
  autocmd Syntax * syntax match ZenkakuSpace containedin=ALL /　/
augroup END

" colorscheme desert
colorscheme jellybeans
" colorscheme hybrid

syntax on
