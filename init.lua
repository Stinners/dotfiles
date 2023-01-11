---------------- General Options
local set = vim.opt

-- Search
set.showmatch = true
set.hlsearch = true
set.incsearch = true
set.showmode = false
set.wildmode = "longest,list,full"
set.wildmenu = true

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

local lisps = {'clojure', 'scheme', 'janet'}

-- Defining Plugins
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

    -- Colorscheme 
    use 'drewtempelmeyer/palenight.vim'

    -- Utilities
    use 'preservim/nerdtree'
    use 'vim-airline/vim-airline'
    use 'vim-scripts/restore_view.vim'
    use 'nvim-tree/nvim-web-devicons'
    use {
      'nvim-telescope/telescope.nvim',
      requires = 'nvim-lua/plenary.nvim'
    }
    use 'folke/trouble.nvim'
    use 'ervandew/supertab'

    -- Language support
    use 'nvim-treesitter/nvim-treesitter'
    use 'sheerun/vim-polyglot'

    -- Lisp editing
    use {
        'tpope/vim-sexp-mappings-for-regular-people',
        requires = 'guns/vim-sexp',
        ft = lisps
    }

    use {
      'frazrepo/vim-rainbow',
      ft = lisps
    }

    use {
      'bhurlow/vim-parinfer',
      ft = lisps
    }

    -- Conjure
    use {
        'Olical/conjure',
        ft = {'clojure', 'scheme', 'julia'}
    }

    -- Idris Editing
    use {
        'edwinb/idris2-vim',
        ft = {'idris'}
    }

    -- Language Server
    use {
      'VonHeikemen/lsp-zero.nvim',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'},
        -- Snippets
        {'L3MON4D3/LuaSnip'},

      }
    }

end)

----------------- Aesthetics
set.termguicolors = true
vim.cmd('colorscheme palenight')
set.fillchars = 'fold: '                   -- Make folds look nicer

----------------- Leader 
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.keymap.set('n', '<Leader>a', ':bp!<Enter>')
vim.keymap.set('n', '<Leader>d', ':bn!<Enter>')
vim.keymap.set('n', '<Leader>c', ':noh!<Enter>')
vim.keymap.set('n', '<Leader>w', ':<C-w><C-w>')
vim.keymap.set('n', '<Leader>q', 'b#<bar>bd#<Enter>')

------------------ Language specific config 
-- Only use vim-sexp for lisp files 
vim.g.sexp_filetypes = 'clojure,janet,scheme'

local autocmd = vim.api.nvim_create_autocmd

local function language_file(name, file)
    autocmd('Filetype', {pattern = name, command = 'source ~/.config/nvim/langs/'..file})
end

language_file(lisps, 'lisp.vim')
language_file('make', 'make.vim')
language_file('tex', 'tex.vim')
language_file('pug', 'pug.vim')

---------------- Telescope Keybindings
vim.keymap.set('n', '<Leader>ff', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')

---------------- Misc 
vim.g.python3_host_prog = '/usr/local/bin/python3'
vim.cmd('map <C-n> :NERDTreeToggle<CR>')

------------------ LSP Setup
local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.set_preferences({
  suggest_lsp_servers = false
})

lsp.configure('sumneko_lua', {
      settings = {
      Lua = {
          diagnostics = {
              globals = { 'vim' }  -- Stop the LSP from calling 'vim' and error
          }
      }
  }
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})

-- Trouble Setup
require("trouble").setup {}
vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>')
