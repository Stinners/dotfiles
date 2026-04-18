local set = vim.o

set.showmatch = true
set.hlsearch = true
set.incsearch = true
set.showmode = false
set.wildmode = "longest,list,full"
set.wildmenu = true
set.splitright = true

-- Disanle automatically inserting multi line comments
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

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

-- setup filetype associations
vim.filetype.add({
    extension = {
        chpl = "chapel",
        fs = "fsharp",
        pest = "pest",
        m = "objc",
        c3 = "c3",
        bqn = "bqn",
        typst = "typst",
        typ = "typst",
    }
})

local lisps = {'clojure', 'scheme', 'janet', 'racket', 'lisp', 'fennel'}

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
    -- Colorscheme 
    'drewtempelmeyer/palenight.vim',

    -- Utilities
    'preservim/nerdtree',
    'vim-scripts/restore_view.vim',
    'nvim-tree/nvim-web-devicons',
    {
      'nvim-telescope/telescope.nvim',
      dependencies = 'nvim-lua/plenary.nvim'
    },
    "easymotion/vim-easymotion",
    'qpkorr/vim-bufkill',
    'romgrk/barbar.nvim',

    {
      'bhurlow/vim-parinfer',
      ft = lisps
    },

    {
      'Olical/conjure',
      ft = {'clojure', 'scheme', 'julia', 'racket', 'lisp', 'fennel'}
    },

    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',

    {
      'chomosuke/typst-preview.nvim',
      ft = {"typst"}
    },

    {
      "scalameta/nvim-metals",
      ft = { "scala", "sbt" },
      opts = function()
        return require("metals").bare_config()
      end,
      config = function(self, metals_config)
        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
          pattern = self.ft,
          callback = function()
            require("metals").initialize_or_attach(metals_config)
          end,
          group = nvim_metals_group,
        })
      end
    }
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
vim.g.sexp_filetypes = table.concat(lisps, ',')

local autocmd = vim.api.nvim_create_autocmd

local function language_file(name, file)
    autocmd('Filetype', {pattern = name, command = 'source ~/.config/nvim/langs/'..file})
end

language_file(lisps, 'lisp.vim')
language_file('make', 'make.vim')
language_file('tex', 'tex.vim')
language_file('pug', 'pug.vim')
language_file('ada', 'ada.vim')

---------------- Telescope Keybindings
vim.keymap.set('n', '<Space>ff', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<Space>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<Space>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<Space>fh', '<cmd>Telescope help_tags<cr>')
vim.keymap.set('n', '<Space>fr', '<cmd>Telescope lsp_references<cr>')

---------------- Misc 
vim.g.python3_host_prog = '/usr/local/bin/python3'
vim.cmd('map <C-n> :NERDTreeToggle<CR>')

------------------ LSP Setup
local util = require 'lspconfig.util'

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})

vim.lsp.enable('clangd')
vim.lsp.enable('julials')
vim.lsp.enable('svelte')
vim.lsp.enable('ts_ls')
vim.lsp.enable('csharp_ls')
vim.lsp.enable('fsautocomplete')

vim.lsp.config.cls = {
    cmd = {'chpl-language-server', '--end-markers', 'all'},
    filetypes = {'chpl'},
    autostart = true,
    single_file_support = true,
    --root_dir = util.find_git_ancestor,
    root_markers = { ".git" },
    settings = {},
}
vim.lsp.enable('cls')

-- Stop zig errors from opening in quickfix buffer
vim.g.zig_fmt_parse_errors = 0

-- Stop the lua lsp from complaining about 'vim'
-- table in this file
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})


vim.lsp.config["tinymist"] = {
    cmd = { "tinymist" },
    filetypes = { "typst" },
    settings = {
        formatterMode = "typstyle",
        exportPdf = "onType",
        semanticTokens = "disable"
    }
}
vim.lsp.enable("tinymist")  -- typst

-------------------- Setup autocompletion 

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

--------------------- Formatters 
function def_formater(filetype, command, on_save) 
  local format_cmd = "!".. command .. " " .. vim.fn.expand("%")

  -- For some filetypes we want to avoid formating on save
  -- since the formater is slow
  if on_save then 
      vim.api.nvim_create_autocmd("FileType", {
        pattern = filetype,
        callback = function(args)
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function() 
                    vim.fn.system(format_cmd)
                    vim.cmd("edit!")
                end 
            })
        end,
      })
  end 

  -- Always enable the hotkey for formating
  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetype,
    callback = function()
      vim.keymap.set("n", "F", function()
        vim.cmd(format_cmd)
        vim.cmd("checktime")
      end, { buffer = true })
    end,
  })

end

def_formater("scala", "scalafmt", false)
def_formater("go", "gofmt -w", true)


-- -- Buffers and splits 
vim.api.nvim_set_keymap('n', '<Space>d', '<cmd>BD!<Cr>!', { noremap = true, silent = true })

vim.cmd('map <Leader><Leader> <Plug>(easymotion-prefix)')
