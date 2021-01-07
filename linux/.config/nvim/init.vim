

""""""" -------------------------------------------------------
""" plugins configuration files
""""""" -------------------------------------------------------

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/plugin-configs/coc.vim
source ~/.config/nvim/plugin-configs/sneak.vim
source ~/.config/nvim/plugin-configs/signify.vim

""""""" -------------------------------------------------------
""" importing vim files for arrangment purpose
""""""" -------------------------------------------------------

source ~/.config/nvim/bindings.vim

""""""" -------------------------------------------------------
""" My own config - built in vim configs
""""""" -------------------------------------------------------

source ~/.config/nvim/buf-only.vim

" " set the it as vim
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath

" highlight comment in json files
" autocmd FileType json syntax match Comment +\/\/.*|\/\*(.|\s)*\*\/$+

set splitbelow splitright

set cursorline

set nohlsearch

" indentation
set tabstop=2
set shiftwidth=2
set expandtab

" side line number bar
set number
set rnu " relativenumber
set nowrap

command! -nargs=0 Reload :source ~/.config/nvim/init.vim

