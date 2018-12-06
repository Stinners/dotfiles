
" Extensions being used:
" vim-airline 
" PaperColor 
" NERDTree
" restore_view 
" vim-polyglot

execute pathogen#infect()

filetype plugin on 
filetype indent on  

set nocompatible      " Diable comaptibility with vi
set showmatch         " Show matchign brackets
set hlsearch          " highlight search results
set incsearch 

set tabstop=4         " 
set expandtab 
set shiftwidth=4 
set autoindent 

set wildmode=longest,list

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
set background=dark 
set termguicolors
colorscheme PaperColor

set fillchars="fold: "

" Use tab to just to close bracket in 
" normal and visual mode
nnoremap <tab> %
vnoremap <tab> %

" Dealing with the leader
let mapleader = ","
nnoremap <leader>a :bp!<Enter>
nnoremap <leader>d :bn!<Enter>
nnoremap <leader>c :noh<Enter>   " Clears search highlighting 
nnoremap <leader>w <C-w><C-w>

nnoremap <leader>q :b#<bar>bd#<Enter>

autocmd Filetype clojure setlocal shiftwidth=2
autocmd Filetype elixir  setlocal shiftwidth=2
autocmd Filetype html    setlocal shiftwidth=2


function! ToggleMouse() 
	" Check is mouse is enabled
	if &mouse == 'a'
		set mouse=
	else
		"enable mouse everywhere
		set mouse=a
	endif
endfunc

nnoremap <leader>m :call ToggleMouse()<Enter>
	
" Configuring vim airline 
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Dealing with the terminal 
tnoremap <Esc> <C-\><C-n>
autocmd TermOpen * set bufhidden=hide  " allows the terminal to be hidden without closing


" Set up the language server protocol
"
set hidden 

let g:LanguageClient_serverCommands = {
	\ 'rust': ['rls'],
	\ 'python': ['pyls'],
	\ 'typescript': ['/usr/bin/javascript-typescript-stdio'],
	\ 'javascript.jsx': ['/usr/bin/javascript-typescript-stdio'],
	\ 'css': ['css-languageserver', "--stdio"],
	\ }

noremap <F5> :call LanguageClient_contextMenu()<CR>
"
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd : call LanguageClient#textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Turn off automatic commenting 
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

