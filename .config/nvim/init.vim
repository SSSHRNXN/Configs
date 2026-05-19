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
:set nohidden
:set wrap
:set linebreak
:set breakindent

" ===== PLUGINS =====

call plug#begin()

Plug 'https://github.com/WolfgangMehner/bash-support.git'
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
Plug 'hrsh7th/nvim-cmp'
Plug 'https://github.com/hrsh7th/cmp-buffer.git'
Plug 'https://github.com/hrsh7th/cmp-path.git'
Plug 'L3MON4D3/LuaSnip'
Plug 'https://github.com/Yggdroot/indentLine.git'
Plug 'vim-airline/vim-airline-themes'
Plug 'akinsho/toggleterm.nvim'
Plug 'https://github.com/neovim/nvim-lspconfig.git'
Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'https://github.com/wfxr/code-minimap.git'
"Plug 'https://github.com/wfxr/minimap.vim.git'
Plug 'sheerun/vim-polyglot'
"Plug 'https://github.com/gorbit99/codewindow.nvim.git'
Plug 'https://github.com/nvim-mini/mini.map.git'
Plug 'https://github.com/mason-org/mason.nvim.git'
Plug 'https://github.com/mason-org/mason-lspconfig.nvim.git'
Plug 'https://github.com/stevearc/dressing.nvim.git'
Plug 'https://github.com/folke/which-key.nvim.git'
Plug 'https://github.com/folke/todo-comments.nvim.git'

call plug#end()

lua <<EOF
require('todo-comments').setup {}
EOF

"let g:minimap_width = 10
"let g:minimap_auto_start = 1
"let g:minimap_auto_start_win_enter = 1
"let g:minimap_highlight_search = 1
"autocmd VimLeavePre * MinimapClose 
lua <<EOF
require('mini.map').setup({
  window = { width = 10 },
  integrations = {
    require('mini.map').gen_integration.diagnostic(),
  },
})
vim.keymap.set('n', '<space>mm', MiniMap.toggle, { desc = 'Toggle minimap' })
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    MiniMap.open()
  end,
})
EOF

" ===== CAPS LOCK INDICATOR =====
let g:airline#extensions#tabline#enabled = 1

function! CapsLockStatus()
  let l:file = globpath('/sys/class/leds', 'input*::capslock/brightness')
  if !empty(l:file)
    let l:files = split(l:file, "\n")
    for l:f in l:files
      let l:val = readfile(l:f)
      if !empty(l:val) && l:val[0] == '1'
        return ' [CAPS]'
      endif
    endfor
  endif
  return ''
endfunction

let g:airline_section_x = '%{CapsLockStatus()}'

" обновление статуслайна каждую секунду
lua <<EOF
vim.uv.new_timer():start(200, 200, vim.schedule_wrap(function()
  vim.cmd('redrawstatus')
end))
EOF
" ===== CAPS LOCK INDICATOR =====

" ===== INDENTLINE =====
:set list lcs=tab:\|\
let g:indentLine_char_list = '|'
" ===== INDENTLINE =====
" ===== PLUGINS =====

" ====== MASON =====
lua <<EOF
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    "pyright",
    "bash-language-server",
    "lua-language-server",
    "json-lsp",
    "yaml-language-server",
    "taplo",
  },
  automatic_installation = true,
})
EOF
" ====== MASON =====

lua <<EOF
require'nvim-treesitter.config'.setup {
    ensure_installed = { "bash", "python", "markdown", "regex", "json", "yaml", "toml" },
    highlight = { 
        enable = true 
        },
    auto_install = true
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
nnoremap <S-h> :bprev<CR>
nnoremap <S-l> :bnext<CR>

" ====== TOGGLETERM =====
lua <<EOF
local launch_dir = vim.fn.getcwd()

require('toggleterm').setup({
  size = 15,
  open_mapping = [[<leader>t]],
  direction = 'horizontal',
  dir = launch_dir,
})
EOF
" ====== TOGGLETERM =====

" ====== LSP PYRIGHT =====
lua <<EOF
-- capabilities: связка с nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities,
  require('cmp_nvim_lsp').default_capabilities())
-- кастомные настройки pyright (объединяем с дефолтными из lsp/pyright.lua)
vim.lsp.config('pyright', {
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'workspace',
      },
    },
  },
})
-- on_attach: хоткеи LSP
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
  end,
})
-- диагностика
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  float = { border = 'rounded' },
})
-- включаем pyright
vim.lsp.enable('pyright')
EOF
" ====== LSP PYRIGHT =====
" ====== NVIM-CMP =====
lua <<EOF
local cmp = require('cmp')
local luasnip = require('luasnip')
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
})
EOF
" ====== NVIM-CMP =====
cnoreabbrev qqq qa!
cabbrev q <c-r>=(getcmdpos()==1 && getcmdtype()==':' ? 'bd' : 'q')<CR>
