if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd!
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'ctrlpvim/ctrlp.vim'

" shortcuts and snippets
"Plug 'SirVer/ultisnips'
"Plug 'mlaursen/vim-react-snippets'
Plug 'hrsh7th/vim-vsnip'

" Plug 'vimwiki/vimwiki'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
"Plug 'terryma/vim-multiple-cursors'
"Plug 'dhruvasagar/vim-table-mode'
"Plug 'farseer90718/vim-taskwarrior'
Plug 'thaerkh/vim-workspace'
"Plug 'scrooloose/nerdtree'
"Plug 'jlipps/tmux-safekill'
"Plug 'posva/vim-vue'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'nvie/vim-flake8'
" Plug 'elmcast/elm-vim'
Plug 'elixir-editors/vim-elixir'
Plug 'vim-vdebug/vdebug'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'skanehira/preview-markdown.vim'
Plug 'Kachyz/vim-gitmoji'
" Plug 'preservim/vim-pencil'
Plug 'ObserverOfTime/coloresque.vim'
Plug 'vifm/vifm.vim'

" rust
Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'

" language server
Plug 'neovim/nvim-lspconfig'
Plug 'lspcontainers/lspcontainers.nvim'

" completion framework
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" required for typescript lsp
Plug 'nvim-lua/plenary.nvim'

" for typescript lsp setup
Plug 'jose-elias-alvarez/typescript.nvim'

" database stuf
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'

" typescript
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"let g:coc_global_extensions = [ 'coc-tsserver' ]
"if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
"    let g:coc_global_extensions += ['coc-prettier']
"endif
"if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
"    let g:coc_global_extensions += ['coc-eslint']
"endif

call plug#end()



set background=dark
set textwidth=80
set colorcolumn=80

syntax on
" let g:zenburn_transparent = 1
color zenburn
filetype on

hi Normal guibg=NONE ctermbg=NONE

:let mapleader = " "

set smartindent
set smarttab
set number relativenumber
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
" have a fixed column for diagnostics
set signcolumn=yes

set backup
set writebackup
set backupcopy=yes
set backupdir=~/.vim/backup//
set display+=lastline
set encoding=utf-8
set wildmenu
set autoread
set nofoldenable

" start run lsp config
"set completeopt+=longest,menuone,preview
set completeopt=menuone,noinsert,noselect

" timeout for when diagnostic popup will appear
set updatetime=500

" avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP through rust-tools.nvim plugin
lua <<EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attaches to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF

" enabling lsp for typescript and python
lua <<EOF
--require("typescript").setup()
require'lspconfig'.tsserver.setup{}
require'lspconfig'.eslint.setup{}
require'lspconfig'.pyright.setup{}
EOF

" enabling lsp for elixir
lua << EOF
local lspcontainers = require'lspcontainers'
local lspconfig = require'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.elixirls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = lspcontainers.command('elixir', {
        image = "lspcontainers/elixir-ls",
        cmd = function (runtime, volume, image)
            return {
                runtime,
                "container",
                "run",
                "--interactive",
                "--rm",
                "--volume",
                volume,
                image
            }
        end,
    }),
    root_dir = lspconfig.util.root_pattern("mix.exs", ".git", vim.fn.getcwd()),
    settings = {
        elixirLS = {
            dialyzerEnabled = false,
            fetchDeps = false
        }
    }
}

lspconfig.phpactor.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = lspcontainers.command('phpactor', {
        image = "lspcontainers/phpactor",
        cmd = function (runtime, volume, image)
            return {
                runtime,
                "container",
                "run",
                "--interactive",
                "--rm",
                "--volume",
                volume,
                image
            }
        end,
    }),
    root_dir = lspconfig.util.root_pattern("composer.json", ".git", vim.fn.getcwd()),
}

EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

" end run lsp config

" let g:pymode_python = 'python'
let g:pymode_lint_config = '$HOME/pylint.rc'

" Show buffers at the top
let g:airline#extensions#tabline#enabled = 1
" Show only the file name
let g:airline#extensions#tabline#fnamemod = ':t'
" Show git branch
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_theme = 'zenburn'
let g:airline_powerline_fonts = 1

let g:workspace_autosave = 0
let g:workspace_session_directory = $HOME . '/.cache/vim/sessions/'
let g:workspace_persist_undo_history = 0
let g:workspace_undodir='~/.vim/undodir//'

" vim-session
let g:session_default_to_last = 1
let g:session_autoload = 'no'

" ultisnips
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

let g:db_ui_table_helpers = {
\   'mysql': {
\        'CREATE': 'SHOW CREATE TABLE `{table}`'
\    }
\}

" Multiple Cursors Settings
" let g:multi_cursor_use_default_mapping = 0
" let g:multi_cursor_next_key = '<C-j>'
" let g:multi_cursor_prev_key = '<C-k>'
" let g:multi_cursor_skip_key = '<C-x>'
" let g:multi_cursor_quit_key = '<Esc>'

set showcmd
" Move to next buffer
nmap <right> :bnext<CR>
nmap <C-j> :bnext<CR>
" Mome to previous buffer
nmap <left> :bprevious<CR>
nmap <C-k> :bprevious<CR>
" Close current buffer and move to the previous one
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>w :bp <BAR> bw #<CR>
" Show all open buffers and their status
nmap <leader>bl :ls<CR>
" Switch to last used buffer
nmap <Tab> :b#<CR>
" Code folding
" nnoremap <space> za
nmap <leader>o :CtrlPTag<CR>
" nmap <leader>e :Explore<CR>
" nmap <leader>e :NvimTreeToggle<CR>
nmap <leader>e :EditVifm<CR>

map <up> <nop>
map <down> <nop>

imap <C-V> <C-R>*
vmap <C-C> "+y
nmap <leader>P "+p

" nnoremap j gj
" nnoremap k gk

nnoremap ; :

nnoremap \ za

nnoremap <leader>so :OpenSession<CR>
nnoremap <leader>ss :SaveSession<CR>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" coc
"nnoremap <leader>rn <Plug>(coc-rename)

nnoremap <silent> <leader>p :set opfunc=DeleteAndReplace<CR>g@
function! DeleteAndReplace(type)
    silent exec 'normal! `[v`]"_d'
    silent exec 'normal! P'
endfunction

command! -range Aleq execute <line1>.",".<line2> . "! sed 's/=/=TMPXX/'| column -t -s=| sed 's/TMPXX\s*/= /'"

" lsp shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-s> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>rn     <cmd>lua vim.lsp.buf.rename()<CR>

nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> g[    <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g]    <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

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
set wildignore+=*/dist/*

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd FileType javascript setlocal ts=2 sw=2 expandtab
autocmd FileType vue setlocal ts=2 sw=2 expandtab
autocmd FileType typescript setlocal ts=2 sw=2 expandtab
autocmd FileType typescriptreact setlocal ts=2 sw=2 expandtab
autocmd FileType yaml setlocal sw=2 ts=2 expandtab

" lsp stuff
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
" auto format
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200);
