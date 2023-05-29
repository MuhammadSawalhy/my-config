let g:plug_home = '~/.config/nvim/plugins'

call plug#begin(plug_home)
Plug 'nvim-lua/plenary.nvim'
Plug 'tanvirtin/vgit.nvim'
Plug 'Shatur/neovim-session-manager'
call plug#end()

lua << EOF
require('vgit').setup()
EOF
