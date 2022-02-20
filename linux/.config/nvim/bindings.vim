"""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++
""""""                    native in vim
"""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++

""" ---------- disabling

nnoremap Q <Nop>
vnoremap Q <Nop>
nnoremap <C-w>t     :tabedit %<CR>
nnoremap <C-w><C-t> :tabedit %<CR>

""" ---------- copy to clipboard

xmap <C-c> "+y

""" ---------- sort by line width

xmap gsw :'<,'> ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }'<CR><ESC>

""" ---------- tabs

nmap <tab>j     :tabnext<CR>
nmap <tab>l     :tablast<CR>
nmap <tab>h     :tabfirst<CR>
nmap <tab><tab> :tabnew<Space>
nmap <tab>k     :tabprevious<CR>

""" ---------- windows

" resize
nmap <C-Up>    <C-w>+
nmap <C-Down>  <C-w>-
nmap <C-Right> <C-w>>
nmap <C-Left>  <C-w><

" move
nmap <C-k>       <C-w>k
nmap <C-j>       <C-w>j
nmap <C-l>       <C-w>l
nmap <C-h>       <C-w>h
nmap <BS>        <C-w>h

""" ---------- without yanking

nnoremap <leader>d "_d
nnoremap <leader>D "_D
vnoremap <leader>d "_d
vnoremap <leader>D "_D
vnoremap <leader>p "_dP
vnoremap <leader>P "_dp

"""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++
""""""                      plugins
"""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++

""" ---------- git

nmap <space>gd <CMD>VGit buffer_diff_preview<CR>
nmap <space>gh <CMD>VGit buffer_history_preview<CR>

""" ---------- mbbill/undotree

nmap <space>u <CMD>UndotreeToggle<CR>

""" ---------- ./my-plugins/win-zoom.vim

map <C-w>z     <plug>WinZoom_Toggle
map <C-w><C-z> <plug>WinZoom_Toggle

""" ---------- fzf

nmap <silent> <space>p :Files<CR>
nmap <silent> <space>o :Buffers<CR>
" from junegunn/fzf plugin
nmap <C-f> :Rg!<CR>

""" ---------- ranger for vim
""" ---------- kyazdani42/nvim-tree.lua
""" ---------- ms-jpq/chadtree

" nmap <silent> <Space>e <CMD>NvimTreeToggle<CR>
nmap <silent> <Space>e <CMD>CHADopen<CR>
nmap <silent> <space>r :RnvimrToggle<CR>

""" ---------- sneak

nmap <silent> f <Plug>Sneak_f
nmap <silent> F <Plug>Sneak_F
nmap <silent> t <Plug>Sneak_t
nmap <silent> T <Plug>Sneak_T

""" ---------- vim-easy-align

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)

nmap ga <Plug>(EasyAlign)

""" ---------- sbdchd/neoformat

nmap <leader>nf :Neoformat<CR>

""" ---------- rhysd/git-messenger.vim

nmap <C-_> gcc
xmap <C-_> gc

""" ---------- rhysd/git-messenger.vim

nmap gm <Plug>(git-messenger)

""" ---------- AndrewRadev/splitjoin.vim

" use native J to join lines
nmap gj :SplitjoinJoin<CR>
nmap gk :SplitjoinSplit<CR>

""" ---------- haya14busa/incsearch.vim

" nmap /  <Plug>(incsearch-forward)
" nmap ?  <Plug>(incsearch-backward)
" nmap g/ <Plug>(incsearch-stay)

" ---------- t9md/vim-choosewin

nmap <silent> <space>w <Plug>(choosewin)

" ---------- folke/twilight.nvim

nnoremap <silent> <space>t :Twilight<CR>

" ---------- mfussenegger/nvim-ts-hint-textobject

omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
vnoremap <silent> m :lua require('tsht').nodes()<CR>

" ---------- mfussenegger/nvim-treehopper

omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
vnoremap <silent> m :lua require('tsht').nodes()<CR>

""" ---------- Pocco81/TrueZen.nvim

nnoremap <silent> <space>za :TZAtaraxis<CR>
nnoremap <silent> <space>zm :TZMinimalist<CR>
nnoremap <silent> <space>zf :TZFocus<CR>
nnoremap <silent> <space>zj :TZBottom<CR>
nnoremap <silent> <space>zk :TZTop<CR>
nnoremap <silent> <space>zl :TZRight<CR>
nnoremap <silent> <space>zh :TZLeft<CR>

""" ---------- fedepujol/move.nvim

nnoremap <silent> <A-j> :MoveLine(1)<CR>
nnoremap <silent> <A-k> :MoveLine(-1)<CR>
vnoremap <silent> <A-j> :MoveBlock(1)<CR>
vnoremap <silent> <A-k> :MoveBlock(-1)<CR>
nnoremap <silent> <A-l> :MoveHChar(1)<CR>
nnoremap <silent> <A-h> :MoveHChar(-1)<CR>
vnoremap <silent> <A-l> :MoveHBlock(1)<CR>
vnoremap <silent> <A-h> :MoveHBlock(-1)<CR>

""" ---------- mfussenegger/nvim-dap

nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F6> :lua require"dap".disconnect({ terminateDebuggee = true });require"dap".close()<CR>
nnoremap <silent> <F8> :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <F9> :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
nnoremap <silent> <space>df :Telescope dap frames<CR>
nnoremap <silent> <space>dc :Telescope dap commands<CR>
nnoremap <silent> <space>db :Telescope dap list_breakpoints<CR>
nnoremap <silent> <space>dg :lua require("dapui").toggle()<CR>
nnoremap <silent> <leader>de :lua require("dapui").eval()<CR>
nnoremap <silent> <leader>dE :lua require("dapui").eval(vim.fn.input('Expression: '))<CR>
nnoremap <silent> <leader>de :lua require("dapui").eval()<CR>
xnoremap <silent> <leader>de :lua require("dapui").eval(require("utils.get_visual_selection")())<CR>
au FileType python nnoremap <silent> <leader>dtf :lua require('dap-python').test_method()<CR>
au FileType python noremap <silent> <leader>dtc :lua require('dap-python').test_class()<CR>
au FileType python noremap <silent> <leader>dts <ESC>:lua require('dap-python').debug_selection()<CR>

nmap ]t <Plug>(ultest-next-fail)
nmap [t <Plug>(ultest-prev-fail)
