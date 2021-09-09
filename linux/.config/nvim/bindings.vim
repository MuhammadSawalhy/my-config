"""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++
""""""                    native in vim
"""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++

""" ---------- disabling

nnoremap Q <Nop>
vnoremap Q <Nop>
nnoremap <C-w>t     :tabedit %<CR>
nnoremap <C-w><C-t> :tabedit %<CR>

""" ---------- tabs

map <tab>j     :tabnext<CR>
map <tab>k     :tabprevious<CR>
map <tab>l     :tablast<CR>
map <tab>h     :tabfirst<CR>
map <tab><tab> :tabnew<Space>

""" ---------- windows

" resize
nmap <M-C-Up>    <C-w>-
nmap <M-C-k>     <C-w>-
nmap <M-C-Down>  <C-w>+
nmap <M-C-j>     <C-w>+
nmap <M-C-Right> <C-w>>
nmap <M-C-l>     <C-w>>
nmap <M-C-Left>  <C-w><
nmap <M-C-h>     <C-w><
nmap <M-BS>      <C-w><

" move
nmap <C-k>     <C-w>k
nmap <C-j>     <C-w>j
nmap <C-l>     <C-w>l
nmap <C-h>     <C-w>h
nmap <BS>      <C-w>h

""" ---------- move the cursor while insert mode

imap <C-l> <Right>
imap <C-k> <Up>
imap <C-j> <Down>
imap <C-h> <Left>
imap <BS>  <Left>

"""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++
""""""                      plugins
"""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++

""" ---------- ./my-plugins/win-zoom.vim

map <C-w>z     <plug>WinZoom_Toggle
map <C-w><C-z> <plug>WinZoom_Toggle

""" ---------- ms-jpq/chadtree

nmap <silent> <Space>e <CMD>CHADopen<CR>

" nmap <silent> <Space>e :NvimTreeToggle<CR>
" nmap <silent> <Space>E :NvimTreeToggle<CR>

""" ---------- fzf

nmap <silent> <space>p :Files<CR>
nmap <silent> <space>g :GFiles<CR>
nmap <silent> <space>o :Buffers<CR>
" from junegunn/fzf plugin
nmap <C-f> :Rg!<CR>

""" ---------- ranger for vim

nmap <silent> <space>r :RnvimrToggle<CR>

""" ---------- sneak

" remap so I can use , and ; with f and t
nmap <silent> gS <Plug>Sneak_,
nmap <silent> gs <Plug>Sneak_;
" I like quickscope better for this since it keeps me in the scope of a single line
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

nnoremap <silent> <leader>t :Twilight<CR>

" ---------- mfussenegger/nvim-ts-hint-textobject

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

""" ---------- mfussenegger/nvim-dap

nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F9> :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <S-F5> :lua require"dap".disconnect({ terminateDebuggee = true });require"dap".close()<CR>
nnoremap <silent> <S-F9> :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
nnoremap <silent> <space>df :Telescope dap frames<CR>
" nnoremap <silent> <space>dc :Telescope dap commands<CR>
nnoremap <silent> <space>db :Telescope dap list_breakpoints<CR>
nnoremap <silent> <space>dg :lua require("dapui").toggle()<CR>
nnoremap <silent> <leader>de :lua require("dapui").eval()<CR>
nnoremap <silent> <leader>dE :lua require("dapui").eval(vim.fn.input('Expression: '))<CR>
