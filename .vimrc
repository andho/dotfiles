set nocompatible

call plug#begin()

Plug 'ctrlpvim/ctrlp.vim'

" Plug 'vimwiki/vimwiki'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'terryma/vim-multiple-cursors'
"Plug 'dhruvasagar/vim-table-mode'
"Plug 'farseer90718/vim-taskwarrior'
Plug 'thaerkh/vim-workspace'
"Plug 'scrooloose/nerdtree'
"Plug 'jlipps/tmux-safekill'
Plug 'posva/vim-vue'
Plug 'leafgarland/typescript-vim'
Plug 'nvie/vim-flake8'
Plug 'elmcast/elm-vim'
Plug 'elixir-editors/vim-elixir'
Plug 'vim-vdebug/vdebug'

call plug#end()

set background=dark
set textwidth=80
set colorcolumn=80

syntax on
" let g:zenburn_transparent = 1
color zenburn
filetype on

:let mapleader = " "

set smartindent
set smarttab
set number
set cursorline
set showmatch
set incsearch
set hlsearch
set directory=~/.vim/swapfiles//
set hidden
set foldmethod=indent
set foldlevel=79
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set completeopt+=longest,menuone,preview

set backup
set writebackup
set backupdir=~/.vim/backup//
set display+=lastline
set encoding=utf-8
set wildmenu
set autoread
set nofoldenable

let g:pymode_python = 'python3'
let g:pymode_lint_config = '$HOME/pylint.rc'

" Show buffers at the top
let g:airline#extensions#tabline#enabled = 1
" Show only the file name
let g:airline#extensions#tabline#fnamemod = ':t'
" Show git branch
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
" let g:airline_theme = 'zenburn'
let g:airline_powerline_fonts = 1

let g:workspace_autosave = 0

" Multiple Cursors Settings
" let g:multi_cursor_use_default_mapping = 0
" let g:multi_cursor_next_key = '<C-j>'
" let g:multi_cursor_prev_key = '<C-k>'
" let g:multi_cursor_skip_key = '<C-x>'
" let g:multi_cursor_quit_key = '<Esc>'

set showcmd
" To open a new empty buffer
nmap <leader>T :enew<cr>
" Move to next buffer
nmap <right> :bnext<CR>
" Mome to previous buffer
nmap <left> :bprevious<CR>
" Close current buffer and move to the previous one
nmap <leader>bq :bp <BAR> bd #<CR>
" Show all open buffers and their status
nmap <leader>bl :ls<CR>
" Switch to last used buffer
nmap <Tab> :b#<CR>
" Code folding
" nnoremap <space> za
nmap <leader>o :CtrlPBufTag<CR>
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>e :Explore<CR>

map <up> <nop>
map <down> <nop>

imap <C-V> <C-R>*
vmap <C-C> "+y
nmap <leader>P "+p

nnoremap j gj
nnoremap k gk

nnoremap ; :

nnoremap \ za
" ctrlp stuff
let g:ctrlp_working_path_mode = 'r'
 
" Ignore some defaults
set wildignore=*.o,*.obj,*~,*.pyc
set wildignore+=.env
set wildignore+=.env[0-9]+
set wildignore+=.git,.gitkeep
set wildignore+=.tmp
set wildignore+=.coverage
set wildignore+=*DS_Store*
set wildignore+=.sass-cache/
set wildignore+=__pycache__/
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=.tox/**
set wildignore+=.idea/**
set wildignore+=*.egg,*.egg-info
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
set wildignore+=*/.nx/**,*.app
set wildignore+=*/node_modules/*

autocmd FileType javascript setlocal ts=2 sw=2 expandtab
autocmd FileType vue setlocal ts=2 sw=2 expandtab
autocmd FileType typescript setlocal ts=2 sw=2 expandtab
