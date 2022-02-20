let g:plug_home = '~/.config/nvim/plugins'

""""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++
"""""""             Plugins Installation
""""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++

call plug#begin(plug_home)

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'wakatime/vim-wakatime'
Plug 'sudormrfbin/cheatsheet.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-telescope/telescope.nvim'
Plug 'Shatur/neovim-session-manager'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'ryanoasis/vim-devicons'

""" For Editing
""" -------------------------------------------------------------

Plug 'SidOfc/mkdx'
Plug 'dylon/vim-antlr'
Plug 'mbbill/undotree'
Plug 'PProvost/vim-ps1'
Plug 'tpope/vim-surround'
Plug 'fedepujol/move.nvim'
Plug 'kovetskiy/sxhkd-vim'
Plug 'famiu/bufdelete.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'rhysd/vim-grammarous'
Plug 'tommcdo/vim-exchange'
Plug 'KabbAmine/vCoolor.vim'
Plug 'numToStr/Comment.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'christoomey/vim-sort-motion'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Plug 'terrortylor/nvim-comment'
" Plug 'b3nj5m1n/kommentary'
" Plug 'tpope/vim-commentary'

Plug 'andymass/vim-matchup'
Plug 'Konfekt/FastFold'
Plug 'dkarter/bullets.vim'
Plug 'mattn/emmet-vim' " , { 'for': 'html' }
Plug 'sbdchd/neoformat'

Plug 'mfussenegger/nvim-treehopper'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'Pocco81/DAPInstall.nvim'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'mfussenegger/nvim-dap-python'
Plug 'rogalmic/vscode-bash-debug', { 'do': 'npm install && npm run compile' }
Plug 'vim-test/vim-test'
" Plug 'puremourning/vimspector'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'p00f/nvim-ts-rainbow'
Plug 'windwp/nvim-ts-autotag'
Plug 'folke/twilight.nvim'
Plug 'nvim-treesitter/playground'
Plug 'mfussenegger/nvim-ts-hint-textobject'
Plug 'romgrk/nvim-treesitter-context'

Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install()}, 'branch': 'release' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mlaursen/vim-react-snippets'
Plug 'Galooshi/vim-import-js'
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx', 'typescript'],
  \ 'do': 'make install'
\}

" Plug 'fcpg/vim-complimentary'
" Plug 'preservim/tagbar'
" Plug 'nsf/gocode'
" Plug 'fatih/vim-go'
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Plug 'LaTeX-Box-Team/LaTeX-Box'
" Plug 'vimwiki/vimwiki'
" Plug 'lervag/vimtex'
" Plug 'digitaltoad/vim-pug'

" GUI And Themes (fzf, git, files, statusline, ...)
" --------------------------------------------------------------

" Plug 'mhinz/vim-startify' " for the welcom pages, after startup nvim
Plug 'tanvirtin/vgit.nvim'
Plug 'nacro90/numb.nvim'
Plug 'Pocco81/TrueZen.nvim'
Plug 'karb94/neoscroll.nvim'
Plug 't9md/vim-choosewin'

Plug 'rafi/awesome-vim-colorschemes'
Plug 'Yagua/nebulous.nvim'
Plug 'sainnhe/edge'
Plug 'sainnhe/everforest'
Plug 'folke/tokyonight.nvim'
Plug 'rose-pine/neovim'
Plug 'rhysd/vim-color-spring-night'
Plug 'folke/todo-comments.nvim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'lukas-reineke/indent-blankline.nvim'
" Plug 'hoob3rt/lualine.nvim'
" Plug 'Lokaltog/vim-monotone'
" Plug 'machakann/vim-highlightedyank'

Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'preservim/vimux'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
Plug 'ms-jpq/chadtree', {'branch': 'chad',
      \ 'do': 'python3 -m pip install chadtree && python3 -m chadtree deps --nvim'}
" Plug 'akinsho/bufferline.nvim'
" Plug 'sheerun/vim-polyglot'
" Plug 'tversteeg/registers.nvim', { 'branch': 'main' }
" Plug 'kyazdani42/nvim-tree.lua'
" Plug 'haya14busa/incsearch.vim'
" Plug 'preservim/nerdtree' |
" \ Plug 'tiagofumo/vim-nerdtree-syntax-highlight' |
" \ Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()

""""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++
"""""""          plugins simple configurations
""""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++

""" junegunn/fzf.vim
""" ----------------------------------------

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

""" ms-jpq/chadtree
""" ----------------------------------------

let g:chadtree_settings = {
      \ 'keymap.tertiary': ["<m-enter>", "<middlemouse>", "<C-t>"],
      \ 'keymap.v_split': ["w", "<C-v>"],
      \ 'keymap.h_split': ["W", "<C-x>"],
      \ "view.width": 20,
      \}

""" kyazdani42/nvim-tree.lua
""" ----------------------------------------

let g:nvim_tree_highlight_opened_files = 1
" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue

let g:nvim_tree_icons = {
    \ 'default': '',
    \ }

""" ranger for vim
""" ----------------------------------------

let g:rnvimr_enable_ex = 1
let g:rnvimr_enable_picker = 1
let g:rnvimr_enable_bw = 1

""" t9md/vim-choosewin
""" ----------------------------------------

let g:choosewin_overlay_enable = 1

""" dylon/vim-antlr
""" ----------------------------------------

au BufRead,BufNewFile *.g set filetype=antlr3
au BufRead,BufNewFile *.g4 set filetype=antlr4

""" dkarter/bullets.vim
""" ----------------------------------------

let g:bullets_enabled_file_types =
      \ [ 'markdown', 'text', 'gitcommit', 'scratch', ]

""" rhysd/vim-grammarous I does
""" ----------------------------------------

let g:grammarous#default_comments_only_filetypes =
      \ { '*' : 1, 'help' : 0, 'markdown' : 0, }

""" RRethy/vim-hexokinase
""" ----------------------------------------

let g:Hexokinase_highlighters = [ 'virtual' ]
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'

""" finial flavours
""" ----------------------------------------

source ~/.config/nvim/plugin-configs/coc.vim
source ~/.config/nvim/plugin-configs/ccls.vim
source ~/.config/nvim/plugin-configs/sneak.vim
lua require('plugins')
