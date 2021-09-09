let g:plug_home = '~/.config/nvim/plugins'

lua << EOF
-- asdfjkl;
EOF

""""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++
"""""""             Plugins Installation
""""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++

call plug#begin(plug_home)
Plug 'vim-scripts/SyntaxAttr.vim'

Plug 'sudormrfbin/cheatsheet.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kyazdani42/nvim-web-devicons'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tommcdo/vim-exchange'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'SidOfc/mkdx'
Plug 'KabbAmine/vCoolor.vim'
Plug 'rhysd/vim-grammarous'
Plug 'dylon/vim-antlr'
Plug 'PProvost/vim-ps1'
Plug 'kovetskiy/sxhkd-vim'
Plug 'famiu/bufdelete.nvim'
Plug 'tpope/vim-commentary'

Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'microsoft/vscode-node-debug2', { 'do': 'npm install && npm run build' }
Plug 'microsoft/vscode-chrome-debug', { 'do': 'npm install && npm run build' }

Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install()}, 'branch': 'release' }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'p00f/nvim-ts-rainbow'
Plug 'folke/twilight.nvim'
Plug 'nvim-treesitter/playground'
" Plug 'romgrk/nvim-treesitter-context'

Plug 'rafi/awesome-vim-colorschemes'
Plug 'Yagua/nebulous.nvim'
Plug 'sainnhe/edge'
Plug 'sainnhe/everforest'
Plug 'folke/tokyonight.nvim'
Plug 'rhysd/vim-color-spring-night'
Plug 'folke/todo-comments.nvim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'hoob3rt/lualine.nvim'

Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'preservim/vimux'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
Plug 'ms-jpq/chadtree', {'branch': 'chad',
      \ 'do': 'python3 -m pip install chadtree && python3 -m chadtree deps'}

call plug#end()

lua require("plugins.dap")
lua require("plugins.treesitter")
source ~/.config/nvim/bindings.vim

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
colo edge

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

