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

source ~/.config/nvim/my-plugins/buf-only.vim
source ~/.config/nvim/my-plugins/build-preview.vim
source ~/.config/nvim/my-plugins/win-zoom.vim

""" -------------------------------------------
""" importing vim files for arrangment purpose
""" -------------------------------------------

source ~/.config/nvim/bindings.vim

""" -------------------------------------------
""" my configs
""" -------------------------------------------

set runtimepath^=~/.vim-cache runtimepath+=~/.vim-cache/after
let &packpath = &runtimepath
set mouse=a
set smartcase

""" theme, colors
set termguicolors
syntax enable
colo edge
" colo gruvbox
" colo paramount
" colo spring-night
" colo angr
" colo snow
" colo yellow-moon
" colo lucid
" colo alduin
" set cursorcolumn
set cursorline
set nohlsearch
set splitbelow splitright
set nowrap
set number
set rnu " relativenumber

""" indentation & whitespaces
set list
set autoindent
set breakindent
set tabstop=4
set shiftwidth=2
set softtabstop=2
set expandtab

command! -nargs=0 Reload :source ~/.config/nvim/init.vim " reload all configs
command! -nargs=0 Xs :mks! | :xa " save the session, save modified files, and exit

augroup AU_AUTO_WRAP
  autocmd!
  autocmd BufRead,BufNewFile *.md set wrap
augroup END

