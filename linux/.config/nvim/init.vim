""" -------------------------------------------
""" plugins configuration files
""" -------------------------------------------

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/plugin-configs/coc.vim
source ~/.config/nvim/plugin-configs/ccls.vim
source ~/.config/nvim/plugin-configs/sneak.vim
source ~/.config/nvim/plugin-configs/signify.vim

""" -------------------------------------------
""" My own plugins
""" -------------------------------------------

source ~/.config/nvim/buf-only.vim

""" -------------------------------------------
""" importing vim files for arrangment purpose
""" -------------------------------------------

source ~/.config/nvim/bindings.vim

""" -------------------------------------------
""" my configs
""" -------------------------------------------

""" set the it as vim
set runtimepath^=~/.vim-cache runtimepath+=~/.vim-cache/after
let &packpath = &runtimepath

""" theme, colors
set termguicolors
syntax enable
colo snow
" colo paramount
" colo yellow-moon
" colo lucid
" colo alduin
set cursorline
" set cursorcolumn
set nohlsearch
set splitbelow splitright
set nowrap
set number
set rnu " relativenumber

""" indentation
set autoindent
set breakindent
set tabstop=2
set shiftwidth=2
set expandtab

command! -nargs=0 Reload :source ~/.config/nvim/init.vim " reload all configs
command! Xs :mks! | :xa " save the session, save modified files, and exit

""" ----------------------------------------------
""" build and preview md,tex,ms files as pdf files
""" ----------------------------------------------

" Call compile
" Open the PDF from /tmp/
function! Preview()
  :call Compile()
  execute "! zathura /tmp/op.pdf &"
endfunction

" [1] Get the extension of the file
" [2] Apply appropriate compilation command
" [3] Save PDF as /tmp/op.pdf
function! Compile()
  let extension = expand('%:e')
  if extension == "ms"
    execute "! groff -ms % -T pdf > /tmp/op.pdf"
  elseif extension == "tex"
    execute "! pandoc -f latex -t latex % -o /tmp/op.pdf"
  elseif extension == "md"
    execute "! pandoc % -s -o /tmp/op.pdf"
  endif
endfunction

" map \ + p to preview
noremap <leader>v :call Preview()<CR><CR><CR>

" map \ + q to compile
noremap <leader>b :call Compile()<CR><CR>

