let g:plug_home = '~/.config/nvim/plugins'

""""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++
"""""""             Plugins Installation
""""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++

call plug#begin(plug_home)

Plug 'folke/which-key.nvim'
Plug 'wakatime/vim-wakatime'
Plug 'https://gitlab.com/yorickpeterse/nvim-pqf.git'
Plug 'nvim-lua/plenary.nvim' " required by NeoTest
Plug 'antoinemadec/FixCursorHold.nvim' " Required by NeoTest
Plug 'nvim-telescope/telescope.nvim'
Plug 'Shatur/neovim-session-manager'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

""" For Editing
""" -------------------------------------------------------------

" Plug 'dylon/vim-antlr'
" Plug 'PProvost/vim-ps1'
" Plug 'kovetskiy/sxhkd-vim'
Plug 'alunny/pegjs-vim'
Plug 'GutenYe/json5.vim'

Plug 'MunifTanjim/nui.nvim'
Plug 'xeluxee/competitest.nvim'
Plug 'searleser97/cpbooster.vim'

Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'fedepujol/move.nvim'
Plug 'famiu/bufdelete.nvim'
Plug 'jiangmiao/auto-pairs'
" Plug 'rhysd/vim-grammarous'
Plug 'tommcdo/vim-exchange'
Plug 'KabbAmine/vCoolor.vim' " color picker with a gui such as 'zenity'
Plug 'junegunn/vim-easy-align'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " TODO: learn more
Plug 'numToStr/Comment.nvim'

" TODO: imporve your markdown editing
" Plug 'SidOfc/mkdx'

Plug 'andymass/vim-matchup'   " to match end of code statements such as `if`, `while`, and `switch`
" Plug 'Konfekt/FastFold'     " TODO: learn more about it
" Plug 'dkarter/bullets.vim'  " TODO: learn more about it
Plug 'mattn/emmet-vim' , { 'for': 'html,js' }
" Plug 'sbdchd/neoformat'

""" IDE tools
""" -------------------------------------------------------------

Plug 'tpope/vim-dispatch' " specially for my-configs/build-preview.vim

Plug 'mfussenegger/nvim-treehopper' " to select by pressing <m> in visual mode
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'Pocco81/DAPInstall.nvim'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'mfussenegger/nvim-dap-python'
Plug 'rogalmic/vscode-bash-debug', { 'do': 'npm install && npm run compile' }
Plug 'theHamsta/nvim-dap-virtual-text'

Plug 'nvim-neotest/neotest-python'
Plug 'haydenmeade/neotest-jest'
Plug 'nvim-neotest/neotest-vim-test'
Plug 'nvim-neotest/neotest'
" Plug 'puremourning/vimspector'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
" Plug 'p00f/nvim-ts-rainbow' " causes an issue
" Plug 'windwp/nvim-ts-autotag' " TODO: learn more about it
Plug 'folke/twilight.nvim'
Plug 'nvim-treesitter/playground'
Plug 'mfussenegger/nvim-ts-hint-textobject'
Plug 'm-demare/hlargs.nvim'
" Plug 'romgrk/nvim-treesitter-context'

" TODO: choose the best one
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mlaursen/vim-react-snippets'
" Plug 'github/copilot.vim'
Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install() }, 'branch': 'release' }
Plug 'rodrigore/coc-tailwind-intellisense', {'do': 'npm install'}
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

Plug 'tanvirtin/vgit.nvim' " TODO: enable when the issue is fixed
Plug 'akinsho/git-conflict.nvim'
Plug 'nacro90/numb.nvim'
Plug 'Pocco81/TrueZen.nvim'
Plug 'karb94/neoscroll.nvim'
Plug 't9md/vim-choosewin'
" Plug 'mhinz/vim-startify' " for the welcom pages, after startup nvim
" Plug 'TaDaa/vimade'

" Plug 'rafi/awesome-vim-colorschemes'
Plug 'Yagua/nebulous.nvim'
Plug 'sainnhe/edge'
" Plug 'sainnhe/everforest'
" Plug 'folke/tokyonight.nvim'
" Plug 'rose-pine/neovim'
" Plug 'rhysd/vim-color-spring-night'
Plug 'folke/todo-comments.nvim'
" Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'NMAC427/guess-indent.nvim'
" Plug 'tpope/vim-sleuth' " auto delect indentation of the current buffer
Plug 'machakann/vim-highlightedyank'
" Plug 'akinsho/bufferline.nvim'
Plug 'itchyny/lightline.vim'
" Plug 'nvim-lualine/lualine.nvim'
" Plug 'Lokaltog/vim-monotone'

" Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
" Plug 'preservim/vimux'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
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
  \ 'view.width': 20,
  \ 'view.sort_by': ["is_folder", "file_name", "ext"],
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

""" mbbill/undotree
""" ----------------------------------------

if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

""" itchyny/lightline.vim 
""" ----------------------------------------

let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ }

""" SirVer/ultisnips
""" ----------------------------------------

let g:UltiSnipsExpandTrigger="<s-tab>"
let g:snips_author = "Muahmmad Assawalhy"

""" rcarriga/ultest
""" ----------------------------------------

let test#python#pytest#options = "--color=yes"
let test#javascript#jest#options = "--color=always"

""" finial flavours
""" ----------------------------------------

source ~/.config/nvim/plugin-configs/coc.vim
source ~/.config/nvim/plugin-configs/sneak.vim
lua require('plugins')
