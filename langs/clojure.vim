" This files goes in ~/.config/nvim/langs/lisp.vim
"
" Mostly this handles loading things that we want for editing Lisps, but not 
" other languages

" For some reason this needs to go before activating the 
" rainbow plugin
let g:rainbow_active = 1

:highlight NormalFloat guifg=#dfe9ed

let g:vim_parinfer_filetypes = ['clojure', 'racket', 'lisp', 'scheme', 'lfe', 'fennel', 'janet']
let g:vim_parinfer_globs = ['*.clj', '*.cljs', '*.cljc', '*.edn', '*.el', '*.hl', '*.lisp',  '*.rkt', '*.ss', '*.lfe', '*.fnl', '*.fennel', '*.carp', '*janet', '*.scm']

packadd rainbow
packadd vim-parinfer

" Configuring Conjure 
let g:conjure#client#scheme#stdio#command = "csi -quiet -:c"
let g:conjure#client#scheme#stdio#prompt_pattern = "\n-#;%d-> "

let g:conjure_log_size_small=50
let g:conjure_log_blacklist=["up", "eval", "ret", "ret-multiline"]
let g:conjure_fold_multiline_results=v:true
let g:conjure_quick_doc_normal_mode=v:false
let g:conjure_quick_doc_insert_mode=v:false
