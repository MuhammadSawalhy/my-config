" let g:python_host_prog = '/home/ms/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/ms/.virtualenvs/neovim3/bin/python'

set runtimepath^=~/.vim-cache runtimepath+=~/.vim-cache/after
let &packpath = &runtimepath
set mouse=a
set smartcase

""" theme, colors
set termguicolors
syntax enable
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

""" -------------------------------------------
""" importing vim files for arrangment purpose
""" -------------------------------------------

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/my-plugins/buf-only.vim
source ~/.config/nvim/my-plugins/build-preview.vim
source ~/.config/nvim/my-plugins/win-zoom.vim
source ~/.config/nvim/bindings.vim

""" colorschemes
""" ----------------------------------------

" Yagua/nebulous.nvim
let g:nb_style = "night"
let g:nb_italic_functions = v:true
let g:nb_italic_comments = v:true
lua require("nebulous").setup()

" sainnhe/edge
let g:edge_style = 'neon'
let g:edge_enable_italic = 1

" sainnhe/everforest
let g:everforest_background = 'hard'
let g:everforest_enable_italic = 1
let g:everforest_disable_italic_comment = 1

" rose-pine/neovim
lua<<EOF
require('rose-pine').setup({
  -- -@usage 'main'|'moon'
  dark_variant = 'moon',
})
EOF

colo everforest
" colo rose-pine
" colo ayu
" colo nebulous
" colo edge
" colo gruvbox
" colo paramount
" colo spring-night
" colo angr
" colo snow
" colo yellow-moon
" colo lucid
" colo alduin
" set cursorcolumn
