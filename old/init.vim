"           _                    
"    __   _(_)_ __ ___  _ __ ___ 
"    \ \ / / | '_ ` _ \| '__/ __|
"     \ V /| | | | | | | | | (__ 
"      \_/ |_|_| |_| |_|_|  \___|

let mapleader = ","

" plugins
call plug#begin()

    " gral.
    Plug 'https://tpope.io/vim/commentary.git'
    Plug 'tpope/vim-surround'
    " Plug 'https://github.com/vim-syntastic/syntastic.git'
    Plug 'itchyny/lightline.vim' 
    Plug 'nvim-lua/plenary.nvim'
    Plug 'haya14busa/vim-asterisk'
    Plug 'tpope/vim-repeat'
    Plug 'glts/vim-magnum'
    Plug 'glts/vim-radical'
    Plug 'tpope/vim-characterize'
    Plug 'lewis6991/impatient.nvim'
    Plug 'voldikss/vim-floaterm'
    
    " motion
    Plug 'phaazon/hop.nvim'
    Plug 'ggandor/lightspeed.nvim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    
    " file management
    Plug 'preservim/nerdtree'    
    
    " snippets
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'mattn/emmet-vim'
    
    " IDE
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'p00f/nvim-ts-rainbow'
    Plug 'windwp/nvim-autopairs'
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'onsails/lspkind.nvim'
    Plug 'andrewferrier/textobj-diagnostic.nvim'
    Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'

    " git
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'

    " debug
    Plug 'mfussenegger/nvim-dap'
    Plug 'mfussenegger/nvim-dap-python'

    " language specific
    Plug 'p00f/clangd_extensions.nvim'
    Plug 'simrat39/rust-tools.nvim'

    " colorschemes
    Plug 'Shatur/neovim-ayu'

    " notebook
    Plug 'https://github.com/baruchel/vim-notebook.git'

call plug#end()

lua require('impatient')

" source functions

so ~/.config/nvim/funcs.vim

nnoremap <leader>m :let @z = MAKE()<CR>:FloatermToggle<CR><C-\><C-n>"zpi<CR>
nnoremap <leader>c :let @z = CLEAN()<CR>:FloatermToggle<CR><C-\><C-n>"zpi<CR>
nnoremap <leader>r :let @z = RUN()<CR>:FloatermToggle<CR><C-\><C-n>"zpi<CR>

" switch between .c and .h files

function! SwitchCH()

    let extension = expand('%:e')

    if extension == "c"
        w
        e %<.h
    endif
    if extension == "cpp"
        w
        e %<.hpp
    endif

    if extension == "h"
        w
        e %<.c
    endif
    if extension == "hpp"
        w
        e %<.cpp
    endif

endfunction

function! OpenCH()
    
    let extension = expand('%:e')

    if extension == "c"
        w
        silent !nohup st -e vim %<.h > /dev/null & disown
    endif
    if extension == "cpp"
        w
        silent !nohup st -e vim %<.hpp > /dev/null & disown
    endif

    if extension == "h"
        w
        silent !nohup st -e vim %<.c > /dev/null & disown
    endif
    if extension == "hpp"
        w
        silent !nohup st -e vim %<.cpp > /dev/null & disown
    endif

endfunction

nnoremap <leader>sh :call SwitchCH()<CR>
nnoremap <leader>ss :call OpenCH()<CR>

" other


set nocompatible
filetype off
colorscheme ayu-dark
syntax on

set number relativenumber
set autoindent 
set virtualedit=all
set belloff=all
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set splitright

nnoremap <M-w> :FloatermNew! nohup st > /dev/null & disown ; exit<CR>

nnoremap <space>   <C-d>
nnoremap <C-space> <C-u>

nnoremap <C-u> H
nnoremap <C-d> L

nnoremap L $
nnoremap H 0 

nnoremap <C-y> "+yy 
vnoremap <C-y> "+y

nnoremap <C-p> "+p

nnoremap k gk
nnoremap j gj

nnoremap <S-r> :%s///g<left><left>
xnoremap <S-r> :s///g<left><left>

nnoremap <C-c> cgn
xnoremap <C-c> cgn

vnoremap <S-i> <C-v>I

nnoremap <M-q>   :wq<CR>
nnoremap <M-C-q> :q!<CR>

vnoremap > >gv
vnoremap < <gv

let g:floaterm_keymap_toggle = '<C-t>'
let g:floaterm_autoclose     = 1
let g:floaterm_width         = 0.8
let g:floaterm_height        = 0.8

" NERD tree

nnoremap <CR> :NERDTreeToggle<CR>

" ligthline config

set laststatus=2
set noshowmode
set ttimeoutlen=0

" vim-devicons config

filetype plugin indent on
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
set encoding=utf-8

" ultisnips

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"

" fzf

nnoremap <leader><leader>    :BLine<CR>'
nnoremap <leader>f           :Rg<CR>'

nnoremap <leader><CR>        :Files<CR>'
nnoremap <leader>g           :GFiles<CR>'
nnoremap <leader>G           :GFiles?<CR>'

nnoremap <leader>:           :History:<CR>'
nnoremap <leader>h           :History<CR>'
nnoremap <leader>H           :History/<CR>'

" easymotion

map <Leader> <Plug>(easymotion-prefix)

" vim-gitgutter

nmap <leader>J <Plug>(GitGutterNextHunk)
nmap <leader>K <Plug>(GitGutterPrevHunk)

" vim-fugitive

nnoremap <M-g> :G<space>
nnoremap <M-G> :G<CR>

" asterisk 

map +   <Plug>(asterisk-z*)
map #   <Plug>(asterisk-#)
map g+  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
map z+  <Plug>(asterisk-z*)
map gz+ <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)
map -   :let @/=''<CR>

" hop

lua require('hop').setup()

nnoremap S :HopChar1<CR>
nnoremap s :HopChar2<CR>

nnoremap <leader>w :HopWord<CR>
nnoremap // :HopPattern<CR>

" LSP keybindings:

nnoremap gd :lua vim.lsp.buf.definition()<CR>
nnoremap gD :lua vim.lsp.buf.declaration()<CR>
nnoremap gi :lua vim.lsp.buf.implementation()<CR>
nnoremap gw :lua vim.lsp.buf.document_symbol()<CR>
nnoremap gw :lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap gr :lua vim.lsp.buf.references()<CR>
nnoremap gt :lua vim.lsp.buf.type_definition()<CR>
nnoremap rn :lua vim.lsp.buf.rename()<CR>

" dap keybindings

nnoremap <C-b> :lua require('dap').toggle_breakpoint()<CR>
nnoremap <leader>dc :lua require('dap').continue()<CR>
nnoremap <leader>dr :lua require('dap').repl.open()<CR>
nnoremap <leader>di :lua require('dap.ui.variables').hover()<CR>

:highlight Breakpoint ctermbg=red

" lua

lua << EOF

-- lightspeed

require'lightspeed'.setup {
    ignore_case = false,
    exit_after_idle_msecs = { unlabeled = nil, labeled = nil },
    jump_to_unique_chars = { safety_timeout = 400 },
    match_only_the_start_of_same_char_seqs = true,
    force_beacons_into_match_width = false,
    substitute_chars = { ['\r'] = '¬', },
    safe_labels = {},
    labels = {},
    special_keys = {
    next_match_group = '<space>',
    prev_match_group = '<tab>',
    },
    limit_ft_matches = 4,
    repeat_ft_with_target_char = false,
}

-- treesitter:

local treesitter_conf = require'nvim-treesitter.configs'

treesitter_conf.setup {
    ensure_installed = "all",
    ignore_install = { "phpdoc" },
    sync_install = "false",
    highlight = {
        enable = true,
    },
    indent = {
        enable = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "<C-n>",
        scope_incremental = "<C-s>",
        node_decremental = "<C-b>",
      },
    },
    textobjects = {
        select = {
            enable = true,
            keymaps =
            {
                ["fo"] = "@function.outer",
                ["fi"] = "@function.inner",

                ["lo"] = "@loop.outer",
                ["li"] = "@loop.inner",

                ["co"] = "@conditional.outer",
                ["ci"] = "@conditional.inner",

                ["po"] = "@parameter.outer",
                ["pi"] = "@parameter.inner",

                ["so"] = "@class.outer",
                ["si"] = "@class.inner",
            }
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start =
            {
                ["gfi"] = "@function.outer",

                ["gli"] = "@loop.outer",

                ["gci"] = "@conditional.outer",

                ["gpi"] = "@parameter.outer",

                ["gsi"] = "@class.outer",
            },
        },
    },
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    }
}

-- Autopairs

require("nvim-autopairs").setup {}

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(
    function(server)
        local opts = {}
        if server.name == "sumneko_lua" then
            opts =
            {
                settings =
                {
                    Lua =
                    {
                        diagnostics =
                        {
                            globals =
                            {
                                'vim'
                            }
                        }
                    }
                }
            }
        end
        server:setup(opts)
    end
)

local cmp = require'cmp'
cmp.setup({
window = {
  -- completion = cmp.config.window.bordered(),
  -- documentation = cmp.config.window.bordered(),
},


mapping = cmp.mapping.preset.insert({
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<TAB>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),
sources = cmp.config.sources({
  { name = 'ultisnips' }, -- For ultisnips users.
}, {
  { name = 'buffer' },
})
})

--- Debugger

require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

local dap = require('dap')
dap.defaults.fallback.external_terminal =
{
    command='st';
    args={'-e'};
}
dap.defaults.fallback.force_external_terminal = true

vim.fn.sign_define('DapBreakpoint', {text='B', texthl='', linehl='', numhl=''} )

--- LSP

EOF
