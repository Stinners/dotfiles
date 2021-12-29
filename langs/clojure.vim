# This files goes in ~/.config/nvim/langs/clojure.vim

" For some reason this needs to go before activating the 
" rainbow plugin
let g:rainbow_active = 1

packadd rainbow
packadd vim-parinfer

" Configuring conjure 
let g:conjure_log_size_small=50
let g:conjure_log_blacklist=["up", "eval", "ret", "ret-multiline"]
let g:conjure_fold_multiline_results=v:true
let g:conjure_quick_doc_normal_mode=v:false
let g:conjure_quick_doc_insert_mode=v:false
