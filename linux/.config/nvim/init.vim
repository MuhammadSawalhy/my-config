""" -------------------------------------------------------
""" plugins configuration files
""" -------------------------------------------------------

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/plugin-configs/coc.vim
source ~/.config/nvim/plugin-configs/ccls.vim
source ~/.config/nvim/plugin-configs/sneak.vim
source ~/.config/nvim/plugin-configs/signify.vim

""" -------------------------------------------------------
""" importing vim files for arrangment purpose
""" -------------------------------------------------------

source ~/.config/nvim/bindings.vim

""" -------------------------------------------------------
""" My own plugins
""" -------------------------------------------------------

source ~/.config/nvim/buf-only.vim

" " set the it as vim
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath

set termguicolors
syntax enable
" colo lucid
" colo yellow-moon
colo alduin
set cursorline
set nohlsearch

set splitbelow splitright

" indentation
set tabstop=2
set shiftwidth=2
set expandtab

" side line number bar
set number
set rnu " relativenumber
set nowrap

command! -nargs=0 Reload :source ~/.config/nvim/init.vim

""" -------------------------------------------------------
""" build and preview md,tex,ms files as pdf files
""" -------------------------------------------------------

" Call compile
" Open the PDF from /tmp/
function! Preview()
  :call Compile()<CR>
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
noremap <leader>p :call Preview()<CR><CR><CR>

" map \ + q to compile
noremap <leader>q :call Compile()<CR><CR>

