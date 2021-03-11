let g:plug_home = '~/.config/nvim/plugins'

""""""" #######################################################
""""""" -------------------------------------------------------
"""""""             Plugins Installation
""""""" -------------------------------------------------------
""""""" #######################################################

call plug#begin(plug_home)

""" --------------------------
""" For Editing
""" --------------------------

Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'lervag/vimtex'
Plug 'mattn/emmet-vim' " , { 'for': 'html' }
Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install()}, 'branch': 'release' }
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
Plug 'AndrewRadev/splitjoin.vim'
" Plug 'nsf/gocode'
" Plug 'fatih/vim-go'
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Plug 'LaTeX-Box-Team/LaTeX-Box'
" Plug 'vimwiki/vimwiki'

Plug 'andymass/vim-matchup'
Plug 'leafgarland/typescript-vim'
Plug 'dylon/vim-antlr'
Plug 'PProvost/vim-ps1'
Plug 'kovetskiy/sxhkd-vim'
Plug 'alunny/pegjs-vim'
Plug 'digitaltoad/vim-pug'

""" --------------------------
""" Navigation
""" --------------------------

Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
Plug 'mileszs/ack.vim'
Plug 'preservim/nerdtree'
Plug 'voldikss/vim-floaterm'
" Plug 'ryanoasis/vim-devicons'

""" --------------------------
""" for git, diff display, show changes, etc... + other utlities
""" --------------------------

Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
" Plug 'junegunn/vim-github-dashboard'

""" --------------------------
""" GUI And Themes
""" --------------------------

Plug 'junegunn/rainbow_parentheses.vim'
Plug 'mhinz/vim-startify' " for the welcom pages, after startup nvim
Plug 'norcalli/nvim-colorizer.lua'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Lokaltog/vim-monotone'
Plug 'Yggdroot/indentLine'
" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'machakann/vim-highlightedyank'
" Plug 'romainl/vim-cool'
" Plug 'SpaceVim/SpaceVim-theme'
" Plug 'itchyny/lightline.vim'
" Plug 'joshdick/onedark.vim'
" Plug 'mhartington/oceanic-next'
" Plug 'morhetz/gruvbox'

call plug#end()

""""""" #######################################################
""""""" -------------------------------------------------------
"""""""          plugins simple configurations
""""""" -------------------------------------------------------
""""""" #######################################################

""""""" ----------------------------------------
""""""" vim-easy-align
""""""" ----------------------------------------

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""""""" ----------------------------------------
""""""" ack.vim
""""""" ----------------------------------------

let g:ackprg = 'ag --vimgrep'

""""""" ----------------------------------------
""""""" airline - status bar
""""""" ----------------------------------------

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='ayu_mirage'

""""""" ----------------------------------------
""""""" rainbow-colorizer
""""""" ----------------------------------------

set termguicolors
lua require 'plug-colorizer'
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = [248, 15]
" Activation based on file type
augroup rainbow_lisp
  autocmd!
  autocmd filetype * :RainbowParentheses!
  autocmd filetype scss,js,css,python,json :RainbowParentheses
augroup end

""""""" ----------------------------------------
""""""" NERDtree
""""""" ----------------------------------------

let NERDTreeDirArrowExpandable = ' '
let NERDTreeDirArrowCollapsible = '~'
let NERDTreeHijackNetrw = 1
let NERDTreeShowHidden = 1
let NERDTreeWinSize = 20
let NERDTreeIgnore = ['\~$', '^\.git$', '\.lock$', '\.pyc']
" let g:webdevicons_conceal_nerdtree_brackets = 0
" let g:webdevicons_enable_nerdtree = 0

""""""" ----------------------------------------
""""""" ranger for vim
""""""" ----------------------------------------

" let g:rnvimr_ex_enable = 1 " Make Ranger replace netrw and be the file explorer
let g:rnvimr_ranger_cmd = 'ranger --cmd="set draw_borders both"' " Draw border with both

""""""" ----------------------------------------
""""""" NERDCommenter
""""""" ----------------------------------------

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDToggleCheckAllLines = 1

""""""" ----------------------------------------
""""""" vimwiki
""""""" ----------------------------------------

" let g:vimwiki_list = [{ 'syntax': 'markdown', 'ext': '.md' }]

""""""" ----------------------------------------
""""""" indentLine
""""""" ----------------------------------------

let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" json: conceal ", tex: conceal, e.g., \textbf{}
augroup indent_line
  autocmd!
  au Filetype json,tex set conceallevel=0
augroup END

""""""" ----------------------------------------
""""""" nathanaelkane/vim-indent-guides
""""""" ----------------------------------------

" let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_start_level = 2
" let g:indent_guides_guide_size = 1

""""""" ----------------------------------------
""""""" fzf
""""""" ----------------------------------------

" This is the default extra key bindings
let g:fzf_action = {
    \'ctrl-t': 'tab split',
    \'ctrl-s': 'split',
    \'ctrl-v': 'vsplit'
  \}
" Default fzf layout
" - Popup window
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }


""""""" ----------------------------------------
""""""" dylon/vim-antlr
""""""" ----------------------------------------

" au BufRead,BufNewFile *.g set filetype=antlr3
" au BufRead,BufNewFile *.g4 set filetype=antlr4

