local set = vim.o
set.showmatch = true
set.hlsearch = true
set.incsearch = true
set.showmode = false
set.wildmode = "longest,list,full"
set.wildmenu = true
set.splitright = true

-- Tabs and indentation
set.tabstop = 4
set.expandtab = true
set.shiftwidth = 4
set.autoindent = true

-- Text Wrapping
set.textwidth = 0
set.wrapmargin = 0
set.wrap = false

-- Guides
set.ruler=true
set.number=true

-- When a new file is opened and the current file has unsaved changes
-- hide the current file rather than closing it 
set.hidden = true

-- Scrolling
set.scrolloff=3
set.sidescrolloff=7
set.sidescroll=1


local lisps = {'clojure', 'scheme', 'janet', 'racket', 'lisp'}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Defining Plugins
require('lazy').setup({
   'wbthomason/packer.nvim',

    -- Colorscheme 
    'drewtempelmeyer/palenight.vim',

    -- Utilities
    'preservim/nerdtree',
    'vim-airline/vim-airline',
    'vim-scripts/restore_view.vim',
    'nvim-tree/nvim-web-devicons',
    {
      'nvim-telescope/telescope.nvim',
      dependencies = 'nvim-lua/plenary.nvim'
    },
    "easymotion/vim-easymotion",

    -- Language support
    'nvim-treesitter/nvim-treesitter',
    'sheerun/vim-polyglot',
    'qpkorr/vim-bufkill',

    -- Lisp editing
    {
        'tpope/vim-sexp-mappings-for-regular-people',
        dependencies = 'guns/vim-sexp',
    },

    {
      'bhurlow/vim-parinfer',
      ft = lisps
    },

    {
        'Olical/conjure',
        ft = {'clojure', 'scheme', 'julia', 'racket', 'lisp'}
    },

    'wlangstroth/vim-racket',


    -- Idris Editing
    {
        'edwinb/idris2-vim',
        ft = {'idris'}
    },

    -- Language Server
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v2.x',
      dependencies = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-buffer'},
      }
    },
    {
      'ionide/Ionide-vim',
      ft = "fsharp"
    },
  })

----------------- Aesthetics
set.termguicolors = true
vim.cmd('colorscheme palenight')
set.fillchars = 'fold: '                   -- Make folds look nicer

----------------- Leader 
vim.g.mapleader = ","
vim.maplocalleader = "\\"

-- Switching between buffers 
local keymap = vim.keymap.set
keymap('n', '<Leader>a', '<cmd>bn<CR>')
keymap('n', '<leader>d', '<cmd>bp<cr>')

------------------ Language specific config 
-- Only use vim-sexp for lisp files 
-- vim.g.sexp_filetypes = 'clojure,janet,scheme,racket'
vim.g.sexp_filetypes = table.concat(lisps, ',')

local autocmd = vim.api.nvim_create_autocmd

local function language_file(name, file)
    autocmd('Filetype', {pattern = name, command = 'source ~/.config/nvim/langs/'..file})
end

language_file(lisps, 'lisp.vim')
language_file('make', 'make.vim')
language_file('tex', 'tex.vim')
language_file('pug', 'pug.vim')

autocmd('BufRead, BufNewFile, BufEnter', {pattern = '*.fs', command = 'set filetype=fsharp'})
autocmd('BufRead, BufNewFile, BufEnter', {pattern = '*.s', command = 'set filetype=arm64asm'})

---------------- Telescope Keybindings
vim.keymap.set('n', '<Leader>ff', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope lsp_references<cr>')

---------------- Misc 
vim.g.python3_host_prog = '/usr/local/bin/python3'
vim.cmd('map <C-n> :NERDTreeToggle<CR>')

------------------ LSP Setup
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.set_preferences({
  suggest_lsp_servers = false
})

require'lspconfig'.sourcekit.setup{}

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})

local util = require 'lspconfig.util'
local configs = require 'lspconfig.configs'
local lspconfig = require('lspconfig')

require'lspconfig'.zls.setup{}
require'lspconfig'.racket_langserver.setup{}

-- In Chapel we're using a custom local LSP, so we need to set this up from scratch
if not configs.chapel then
  configs.chapel = {
    default_config = {
      cmd = { 'node', '/Users/chris/Code/Chapel/dumb_chapel_lsp/build/main.js', '--stdio'}, --, '--logging', 'info' },
      filetypes = { "chpl" },
      single_file_support = true,
      root_dir = function(fname)
        return util.find_git_ancestor(fname)
      end,
      settings = {},
    }
  }
end
autocmd('BufRead, BufNewFile, BufEnter', {pattern = '*.chpl', command = 'set filetype=chpl'})
lspconfig.chapel.setup{}

vim.g.zig_fmt_parse_errors = 0

-- Setup autocompletion 

local cmp = require'cmp'

cmp.setup({
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }),
  mapping = {
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }
})


-- Setting up Ionide
vim.g['fsharp#enable_reference_code_lens'] = false
vim.g['fsharp#fsi_keymap'] = "custom"
vim.g['fsharp#fsi_keymap_send'] = "<leader>e"
vim.g['fsharp#fsi_keymap_toggle'] = "<leader>@"
vim.cmd [[ :tnoremap <Esc> <C-\><C-n> ]]

-- -- Buffers and splits 
vim.api.nvim_set_keymap('n', '<Space>d', '<cmd>BD!<Cr>!', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>h', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>j', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>k', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>l', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>f', '<C-w>l', { noremap = true, silent = true })

-- telescope
vim.api.nvim_set_keymap('n', '<Space>ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>fb', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })

vim.cmd('map <Leader><Leader> <Plug>(easymotion-prefix)')
