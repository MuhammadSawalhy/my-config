let g:plug_home = '~/.config/nvim/plugins'

""""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++
"""""""             Plugins Installation
""""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++

call plug#begin(plug_home)

Plug 'sudormrfbin/cheatsheet.nvim' |
\ Plug 'nvim-lua/popup.nvim' |
\ Plug 'nvim-lua/plenary.nvim' |
\ Plug 'nvim-telescope/telescope.nvim'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }


""" For Editing
""" -------------------------------------------------------------

Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tommcdo/vim-exchange'
Plug 'AndrewRadev/splitjoin.vim'
" Plug 'preservim/nerdcommenter'
" Plug 'tpope/vim-commentary'
" Plug 'suy/vim-context-commentstring'
Plug 'tomtom/tcomment_vim'
Plug 'preservim/tagbar'
Plug 'SidOfc/mkdx'
Plug 'KabbAmine/vCoolor.vim'
Plug 'rhysd/vim-grammarous'

Plug 'fcpg/vim-complimentary'
Plug 'dylon/vim-antlr'
Plug 'PProvost/vim-ps1'
Plug 'kovetskiy/sxhkd-vim'
" Plug 'tversteeg/registers.nvim', { 'branch': 'main' }
" Plug 'vim-syntastic/syntastic'
" Plug 'nsf/gocode'
" Plug 'fatih/vim-go'
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Plug 'LaTeX-Box-Team/LaTeX-Box'
" Plug 'vimwiki/vimwiki'
" Plug 'lervag/vimtex'
" Plug 'digitaltoad/vim-pug'

Plug 'andymass/vim-matchup'
Plug 'Konfekt/FastFold'
Plug 'dkarter/bullets.vim'
Plug 'mattn/emmet-vim' " , { 'for': 'html' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install()}, 'branch': 'release' }
Plug 'puremourning/vimspector'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mlaursen/vim-react-snippets'
Plug 'Galooshi/vim-import-js'
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx', 'typescript'],
  \ 'do': 'make install'
\}

""" Navigation, and beyond
""" --------------------------------------------------------------

Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'justinmk/vim-sneak'
" Plug 'haya14busa/incsearch.vim'
" Plug 'preservim/nerdtree' |
" \ Plug 'tiagofumo/vim-nerdtree-syntax-highlight' |
" \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ms-jpq/chadtree', {'branch': 'chad',
      \ 'do': 'python3 -m pip install chadtree && python3 -m chadtree deps'}
Plug 'preservim/vimux'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
Plug 'ryanoasis/vim-devicons'
Plug 'ryanoasis/vim-devicons'

""" for git, diff display, show changes, etc... + other utlities
""" --------------------------------------------------------------

Plug 'tanvirtin/vgit.nvim'

""" GUI And Themes
""" --------------------------------------------------------------

Plug 'mhinz/vim-startify' " for the welcom pages, after startup nvim
Plug 'karb94/neoscroll.nvim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'sainnhe/edge'
Plug 'rhysd/vim-color-spring-night'
Plug 'folke/todo-comments.nvim'
Plug 'itchyny/lightline.vim'
" Plug 'sheerun/vim-polyglot' " treesitter took his job
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'Yggdroot/indentLine'
" Plug 'Lokaltog/vim-monotone'
" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
" Plug 'norcalli/nvim-colorizer.lua'
" Plug 'machakann/vim-highlightedyank'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'junegunn/rainbow_parentheses.vim'

call plug#end()

""""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++
"""""""          plugins simple configurations
""""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++

""" neoclide/coc.nvim
""" ----------------------------------------

autocmd FileType scss,css,sass setl iskeyword+=@-@,-
let g:coc_global_extensions = [
      \ 'coc-diagnostic',
      \ 'coc-cssmodules',
      \ 'coc-stylelint',
      \ 'coc-explorer',
      \ 'coc-snippets',
      \ 'coc-tsserver',
      \ 'coc-prettier',
      \ 'coc-vimlsp',
      \ 'coc-eslint',
      \ 'coc-json',
      \ 'coc-yaml',
      \ 'coc-css',
      \ 'coc-sh',
      \]
      " \ 'coc-git',

""" nvim-treesitter/nvim-treesitter
""" ----------------------------------------

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" }, -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true
  }
}
EOF

""" puremourning/vimspector
""" ----------------------------------------

let g:vimspector_enable_mappings = 'VISUAL_STUDIO' " defaults

""" junegunn/fzf.vim
""" ----------------------------------------

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

""" ack.vim
""" ----------------------------------------

if executable('rg') | let g:ackprg = 'rg --vimgrep' | endif

""" airline - status bar
""" ----------------------------------------

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='ayu_mirage'

""" itchyny/lightline.vim
""" ----------------------------------------

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \}

""" rainbow-colorizer
""" ----------------------------------------

set termguicolors
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = [248, 15]
" augroup rainbow_lisp
"   autocmd!
"   autocmd filetype txt :RainbowParentheses!<CR>
" augroup END

""" sainnhe/edge
""" ----------------------------------------

let g:edge_style = 'neon'
let g:edge_enable_italic = 1

""" preservim/nerdtree
""" ----------------------------------------

" let NERDTreeDirArrowExpandable = ''
" let NERDTreeDirArrowCollapsible = ''
" let NERDTreeShowHidden = 1
" let NERDTreeWinSize = 20
" let NERDTreeIgnore = ['\~$', '^\.git$', '\.lock$', '\.pyc']
" let NERDTreeHijackNetrw = 1


""" ---------- ms-jpq/chadtree
""" ----------------------------------------

let g:chadtree_settings = {
      \ 'keymap.tertiary': ["<m-enter>", "<middlemouse>", "<C-t>"],
      \ 'keymap.v_split': ["w", "<C-v>"],
      \ 'keymap.h_split': ["W", "<C-s>"],
      \ "view.width": 20,
      \}

""" ranger for vim
""" ----------------------------------------

let g:rnvimr_enable_ex = 1
let g:rnvimr_enable_picker = 1
let g:rnvimr_enable_bw = 1
let g:rnvimr_action = {
            \ '<C-s>': 'NvimEdit split',
            \}

""" preservim/nerdcommenter
""" ----------------------------------------

" let g:NERDSpaceDelims = 1
" let g:NERDDefaultAlign = 'left'

""" vimwiki
""" ----------------------------------------

" let g:vimwiki_list = [{ 'syntax': 'markdown', 'ext': '.md' }]

""" indentLine
""" ----------------------------------------

let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" json: conceal ", tex: conceal, e.g., \textbf{}
augroup disable_concealing
  au!
  au BufReadPre,BufNewFile *.json,*.tex  let indentLine_setConceal=0
  au BufReadPre,BufNewFile *             let indentLine_setConceal=1
augroup END

""" dylon/vim-antlr
""" ----------------------------------------

au BufRead,BufNewFile *.g set filetype=antlr3
au BufRead,BufNewFile *.g4 set filetype=antlr4

""" rhysd/vim-fixjson
""" ----------------------------------------

let g:fixjson_fix_on_save = 0

""" dkarter/bullets.vim
""" ----------------------------------------

let g:bullets_enabled_file_types =
      \ [ 'markdown', 'text', 'gitcommit', 'scratch', ]

""" karb94/neoscroll.nvim
""" ----------------------------------------

lua << EOF
require('neoscroll').setup({})
EOF

""" rhysd/vim-grammarous I does
""" ----------------------------------------

let g:grammarous#default_comments_only_filetypes =
      \ { '*' : 1, 'help' : 0, 'markdown' : 0, }
