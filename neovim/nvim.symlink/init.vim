"""" pre-config
let g:ruby_path = '/usr/bin/ruby'                   " do not travers $PATH to find ruby
let g:python_host_prog = '/usr/bin/python'          " do not mess with pyenv here
let g:python3_host_prog = '/usr/bin/python3'        " do not mess with pyenv here

""""""
""" plugins
""""""
call plug#begin()
Plug 'iCyMind/NeoSolarized'
Plug 'morhetz/gruvbox'

Plug 'mileszs/ack.vim'                              " project-wide search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fzf executable
Plug 'junegunn/fzf.vim'                             " additional fzf things
Plug 'tpope/vim-commentary'                         " shortcuts for commenting in/out
Plug 'bogado/file-line'                             " open files directly at line number
Plug 'tpope/vim-eunuch'                             " helpful unix shell commands
Plug 'janko-m/vim-test'                             " run tests from within vim
Plug 'benmills/vimux'                               " interact with tmux (e.g. for running tests)
Plug 'tpope/vim-endwise'                            " for automatically adding 'ends' in ruby
Plug 'machakann/vim-highlightedyank'                " blink-highlight what gets yanked
Plug 'editorconfig/editorconfig-vim'                " accept editorconfig files
Plug 'pmeinhardt/hmm'                               " joblogs
Plug 'eiginn/netrw'                                 " current version of netrw

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips'                             " snippets
Plug 'dense-analysis/ale'                           " linting

Plug 'elixir-editors/vim-elixir',     { 'for': 'elixir' }
Plug 'mhinz/vim-mix-format',          { 'for': 'elixir' }
Plug 'pangloss/vim-javascript',       { 'for': 'javascipt' }
Plug 'maxmellon/vim-jsx-pretty',      { 'for': 'javascript' }
Plug 'HerringtonDarkholme/yats.vim',  { 'for': 'typescript' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
call plug#end()

""""""
""" general
""""""
let mapleader="\<Space>"                            " map leader key to space
let maplocalleader="\<Space>"                       " map leader key to space
set encoding=utf8                                   " alwyas use utf8 encoding
set clipboard=unnamedplus                           " use the system clipboard
set autowriteall                                    " automatically write buffers when switching focus
set undofile                                        " keep an undo file in the default location
set mouse=nv                                        " enable mouse in normal and visual modei to stay compatible with tmux scrolling
set noemoji                                         " do not assume all emoji are double width

"""" indentation
set tabstop=2                                       " real tabs are 2 spaces
set softtabstop=2                                   " soft tabs are 2 spaces
set shiftwidth=2                                    " auto-indent with 2 spaces
set expandtab                                       " convert tabs to spaces (softtabs)

"""" searching
set ignorecase                                      " search case insensitive by default
set smartcase                                       " search case sensitive when using mixed letters
set inccommand=nosplit                              " show substitution 'live' in all places

""" spelling
autocmd FileType gitcommit setlocal spell           " spell check commit messages
autocmd BufRead,BufNewFile *.md setlocal spell      " spell check markdown files
autocmd BufRead,BufNewFile *.txt setlocal spell     " spell check text files
set complete+=kspell                                " autocomplete words

"""" window
set scrolloff=2                                     " start scrolling w lines before the end of the screen
set nowrap                                          " do not wrap lines
set noshowcmd                                       " do not show the command history
set number                                          " show line numbers
set cursorline                                      " highlight cursor line
set splitbelow                                      " horizontally split down by default
set splitright                                      " vertically split to the right by default

""" statusline
set statusline=                                     " reset left side of the statusline
set statusline+=%r\                                 " show readonly flag
set statusline+=%t\                                 " show file name
set statusline+=%m                                  " show modfied flag
set statusline+=%=                                  " reset right side of the statusline
set statusline+=%l:%c\                              " show cursor position

""" netrw tree view
let g:netrw_dirhistmax=0                            " disable history
let g:netrw_banner = 0                              " remove banner on top

""" colors
set colorcolumn=80,120                              " highlight column at 80 and 120 characters
set termguicolors                                   " use true colors
set background=dark                                 " use a dark background
colorscheme NeoSolarized
let g:neosolarized_vertSplitBgTrans = 1             " transparent split bars

""" markdown
au FileType markdown setlocal wrap                  " wrap lines in markdown files
hi! link markdownItalic Italic
hi! link markdownBold Bold
let g:markdown_fenced_languages = ['bash=sh', 'ruby', 'elixir', 'json', 'javascript', 'html']
let g:markdown_folding = 1                          " enable folding sections on headers in markdown files
au FileType markdown setlocal foldlevel=99          " start with folds open

""" plugin settings
let test#strategy = "vimux"                         " run tests in tmux split
let g:mix_format_on_save = 1                        " autoformat elixir code
let g:deoplete#enable_at_startup = 1                " enable deoplete autocompletion
let g:ackprg = 'rg --vimgrep --no-heading'          " use ripgrep for Ack
au BufRead,BufNewFile Brewfile setfiletype ruby     " use ruby syntax in brewfiles
let g:ale_sign_error = '!'                          " character for ale linter errors
let g:ale_sign_warning = '~'                        " character for ale linter warnings
let g:ale_fix_on_save = 1                           " automatically fix lint errors on save
let g:ale_fixers = {
  \ 'javascript': ['prettier', 'eslint'],
  \ 'javascriptreact': ['prettier', 'eslint']
\ }

""" fzf
" use 'fd', show hidden files, exclude gitignored files
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
" disable preview window
let g:fzf_preview_window = ''
" layout for overlay window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Comment' } }

""" snippets
" rank snippets higher in autocomplete search
call deoplete#custom#source('ultisnips', 'rank', 1000)
" snippet directory for UltiSnips
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'snips']
" swallow python warnings
let g:UltiSnipsNoPythonWarning = 1


""""""
""" magic
""""""
" quickly navigate splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" fix navigation mappings for netrw
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw nnoremap <buffer> <C-L> <C-W><C-L>
augroup END
" move wrapped lines line by line
nnoremap j gj
nnoremap k gk
" use ctrl p for fzf
nnoremap <silent> <c-p> :Files<cr>
" run tests in tmux split
map <leader>t :TestNearest<cr>
map <leader>f :TestFile<cr>
map <leader>l :TestLast<cr>
" fuzzy find buffers
map <leader><space> :Buffers<cr>
" clear search highlights with ESC in normal mode
nnoremap <silent><ESC> :noh<return><ESC>

""" commands
command FormatJSON %!jq .
command German :set spelllang=de                    " set spellcheck language to German
command English :set spelllang=en                   " set language to English
