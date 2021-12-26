
 "Extensions being used:
 "vim-airline 
 "PaperColor 
 "NERDTree
 "restore_view 
 "vim-polyglot
 "deoplete
 "Easy-Motion

filetype plugin on 
filetype indent on  

set nocompatible      " Diable comaptibility with vi
set showmatch         " Show matching brackets
set hlsearch          " highlight search results
set incsearch 
set noshowmode

set tabstop=4
set expandtab
set shiftwidth=4
set autoindent

" Setup autocomplete
set wildmode=longest,list,full
set wildmenu

set textwidth=0
set wrapmargin=0
set nowrap

set ruler
set number

set scrolloff=3 
set sidescrolloff=7
set sidescroll=1

set hidden

""""""" NERDTree Related things 
map <C-n> :NERDTreeToggle<CR>    " toggle tree with Ctrl+n

"""""""" Aesthetics
set termguicolors
set background=dark 
"colorscheme PaperColor
"colorscheme github_dark
colorscheme challenger_deep

set fillchars="fold: "

" Setup Python provider 
let g:python3_host_prog = '/usr/local/bin/python3'

" Use tab to jump to close bracket in 
" normal and visual mode
nnoremap <tab> %
vnoremap <tab> %

" Dealing with the leader
let mapleader = ","
nnoremap <leader>a :bp!<Enter>
nnoremap <leader>d :bn!<Enter>
nnoremap <leader>c :noh<Enter>   " Clears search highlighting 
nnoremap <leader>w <C-w><C-w>    " Jump between windows
let maplocalleader = "\\"

nnoremap <leader>q :b#<bar>bd#<Enter>

" Setup shiftwidth for language with smaller indentation
autocmd Filetype clojure setlocal shiftwidth=2
autocmd Filetype elixir  setlocal shiftwidth=2
autocmd Filetype html    setlocal shiftwidth=2

" Configuring vim airline 
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'

" noremap <F5> :call LanguageClient_contextMenu()<CR>
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd : call LanguageClient#textDocument_definition()<CR>
" noremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Recognize F# files 
autocmd BufNewFile,BufRead *.fs,*.fsx,*.fsi set filetype=fsharp

" Set up language specific config 
autocmd Filetype clojure source ~/.config/nvim/langs/clojure.vim
autocmd Filetype tex source ~/.config/nvim/langs/tex.vim
autocmd Filetype racket source ~/.config/nvim/langs/racket.vim
autocmd Filetype markdown source ~/.config/nvim/langs/markdown.vim
autocmd Filetype fsharp source ~/.config/nvim/langs/fsharp.vim
autocmd Filetype make source ~/.config/nvim/langs/make.vim
autocmd Filetype pug source ~/.config/nvim/langs/pug.vim


" Configure language server
lua << EOF 
require'lspconfig'.pyright.setup{}
require'lspconfig'.rls.setup {
  settings = {
    rust = {
      unstable_features = true,
      build_on_save = false,
      all_features = true,
    },
  },
}

-- Setup keybindings 

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', '<F12>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

local nvim_lsp = require('lspconfig');

local servers = { 'pyright', 'rls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF 

" Auto close preview window
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Enable Deoplete
let g:deoplete#enable_at_startup = 1
" Use Tab to fill
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
