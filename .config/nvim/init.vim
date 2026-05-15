:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set tabstop=4
:set smarttab
:set softtabstop
:set clipboard=unnamedplus
:set hlsearch
:set showcmd
:set wildmenu
:set cursorline
:set scrolloff=8
:set signcolumn=yes
:set termguicolors
:set expandtab
:set shiftwidth=4
:set smartindent
:set undofile
:set encoding=utf-8
:set fileencoding=utf-8

" ===== PLUGINS =====

call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/PhilRunninger/nerdtree-buffer-ops'
Plug 'https://github.com/PhilRunninger/nerdtree-visual-selection'
Plug 'catppuccin/nvim', { 'branch': 'vim', 'as': 'catppuccin' }
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-neo-tree/neo-tree.nvim'

call plug#end()

" ===== PLUGINS =====

lua <<EOF
require'nvim-treesitter.config'.setup {
  ensure_installed = { "bash" },
  highlight = { enable = true },
}
EOF

lua <<EOF
require('neo-tree').setup({
  filesystem = {
    follow_current_file = { enabled = true },
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
    },
    window = {
      mappings = {
        ["h"] = "open",
        ["l"] = "close_node",
      },
    },
  },
})
EOF

colorscheme catppuccin-nvim " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

" ====== HOTKEYS FOR NEO TREE =====

:let mapleader = " "
:tnoremap <C-h> <C-\><C-n><C-w>h
:tnoremap <C-j> <C-\><C-n><C-w>j
:tnoremap <C-k> <C-\><C-n><C-w>k
:tnoremap <C-l> <C-\><C-n><C-w>l
:nnoremap <C-h> <C-w>h
:nnoremap <C-j> <C-w>j
:nnoremap <C-k> <C-w>k
:nnoremap <C-l> <C-w>l
nnoremap <leader>e :Neotree toggle<CR>
nnoremap <leader>fe :Neotree reveal<CR>

" ====== HOTKEYS FOR NERDTREE =====
"
cnoreabbrev qqq qa!
