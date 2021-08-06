let g:plug_home = '~/.config/nvim/plugins'

""""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++
"""""""             Plugins Installation
""""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++

call plug#begin(plug_home)

""" For Editing
""" -------------------------------------------------------------

Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'folke/todo-comments.nvim'
Plug 'fcpg/vim-complimentary'
Plug 'SidOfc/mkdx'
Plug 'sbdchd/neoformat'
Plug 'KabbAmine/vCoolor.vim'
Plug 'tpope/vim-surround'
Plug 'tommcdo/vim-exchange'
" Plug 'vim-syntastic/syntastic'
" Plug 'tversteeg/registers.nvim', { 'branch': 'main' }

Plug 'mattn/emmet-vim' " , { 'for': 'html' }
Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install()}, 'branch': 'release' }
Plug 'rhysd/vim-fixjson', { 'for': 'json' }

Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'
Plug 'Galooshi/vim-import-js'
Plug 'heavenshell/vim-jsdoc', { 
  \ 'for': ['javascript', 'javascript.jsx', 'typescript'],
  \ 'do': 'make install'
\}

" Plug 'nsf/gocode'
" Plug 'fatih/vim-go'
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Plug 'LaTeX-Box-Team/LaTeX-Box'
" Plug 'vimwiki/vimwiki'

Plug 'lervag/vimtex'
Plug 'andymass/vim-matchup'
Plug 'leafgarland/typescript-vim'
Plug 'dylon/vim-antlr'
Plug 'PProvost/vim-ps1'
Plug 'kovetskiy/sxhkd-vim'
Plug 'alunny/pegjs-vim'
Plug 'digitaltoad/vim-pug'
Plug 'dkarter/bullets.vim'
Plug 'sudormrfbin/cheatsheet.nvim' |
\ Plug 'nvim-lua/popup.nvim' |
\ Plug 'nvim-lua/plenary.nvim' |
\ Plug 'nvim-telescope/telescope.nvim'

""" Navigation
""" --------------------------------------------------------------

Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'preservim/nerdtree' |
\ Plug 'tiagofumo/vim-nerdtree-syntax-highlight' |
\ Plug 'Xuyuanp/nerdtree-git-plugin' |
\ Plug 'ryanoasis/vim-devicons'
" Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
" Plug 'voldikss/vim-floaterm'
" Plug 'ryanoasis/vim-devicons'

""" for git, diff display, show changes, etc... + other utlities
""" --------------------------------------------------------------

Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'sindrets/diffview.nvim'
Plug 'christoomey/vim-conflicted'
Plug 'rhysd/git-messenger.vim'
" Plug 'junegunn/vim-github-dashboard'

""" GUI And Themes
""" --------------------------------------------------------------

Plug 'sheerun/vim-polyglot'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'mhinz/vim-startify' " for the welcom pages, after startup nvim
Plug 'norcalli/nvim-colorizer.lua'
Plug 'Iron-E/nvim-highlite'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'shaunsingh/moonlight.nvim'
Plug 'rafi/awesome-vim-colorschemes'
" Plug 'Yggdroot/indentLine'
" Plug 'Lokaltog/vim-monotone'
" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'machakann/vim-highlightedyank'
" Plug 'romainl/vim-cool'
" Plug 'SpaceVim/SpaceVim-theme'
" Plug 'itchyny/lightline.vim'
" Plug 'joshdick/onedark.vim'
" Plug 'mhartington/oceanic-next'
" Plug 'morhetz/gruvbox'

call plug#end()

""""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++
"""""""          plugins simple configurations
""""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++

""" neoclide/coc.nvim
""" ----------------------------------------

let g:coc_global_extensions = [
      \ "coc-diagnostic",
      \ "coc-snippets",
      \ "coc-tsserver",
      \ "coc-prettier",
      \ "coc-eslint",
      \ "coc-json",
      \ "coc-yaml",
      \ "coc-sh",
      \ "coc-vimlsp",
      \]

""" sbdchd/neoformat ----------------------------

" auto save
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END

""" ack.vim
""" ----------------------------------------

let g:ackprg = 'ag --vimgrep'

""" airline - status bar
""" ----------------------------------------

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='ayu_mirage'

""" rainbow-colorizer
""" ----------------------------------------

set termguicolors
lua require 'plug-colorizer'
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = [248, 15]
" Activation based on file type
augroup rainbow_lisp
  autocmd!
  autocmd BufReadPre *                        RainbowParentheses!
  autocmd BufReadPre scss,js,css,python,json  RainbowParentheses
augroup END

""" NERDtree
""" ----------------------------------------

let NERDTreeDirArrowExpandable = ''
let NERDTreeDirArrowCollapsible = ''
let NERDTreeHijackNetrw = 1
let NERDTreeShowHidden = 1
let NERDTreeWinSize = 20
let NERDTreeIgnore = ['\~$', '^\.git$', '\.lock$', '\.pyc']

""" ranger for vim
""" ----------------------------------------

" let g:rnvimr_ex_enable = 1 " Make Ranger replace netrw and be the file explorer
let g:rnvimr_ranger_cmd = 'ranger --cmd="set draw_borders both"' " Draw border with both

""" NERDCommenter
""" ----------------------------------------

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDToggleCheckAllLines = 1

""" vimwiki
""" ----------------------------------------

" let g:vimwiki_list = [{ 'syntax': 'markdown', 'ext': '.md' }]

""" indentLine
""" ----------------------------------------

" let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" " json: conceal ", tex: conceal, e.g., \textbf{}
" augroup disable_concealing
"   au!
"   au BufReadPre,BufNewFile *.json,*.tex   let b:indentLine_setConceal=0
"   au BufReadPre,BufNewFile *              let b:indentLine_setConceal=1
" augroup END

""" fzf
""" ----------------------------------------

" This is the default extra key bindings
let g:fzf_action = {
    \'ctrl-t': 'tab split',
    \'ctrl-s': 'split',
    \'ctrl-v': 'vsplit'
  \}
" Default fzf layout
" - Popup window
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

""" dylon/vim-antlr
""" ----------------------------------------

" au BufRead,BufNewFile *.g set filetype=antlr3
" au BufRead,BufNewFile *.g4 set filetype=antlr4

""" rhysd/vim-fixjson
""" ----------------------------------------

let g:fixjson_fix_on_save = 0

""" dkarter/bullets.vim
""" ----------------------------------------

let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \ 'yaml',
    \ 'scratch',
    \]
