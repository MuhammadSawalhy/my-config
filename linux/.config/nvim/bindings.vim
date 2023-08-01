"""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++
""""""                    native in vim
"""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++

""" ---------- disabling

nnoremap Q <Nop>
vnoremap Q <Nop>
nnoremap <C-w>t     :tabedit %<CR>
nnoremap <C-w><C-t> :tabedit %<CR>

""" ---------- copy to clipboard

function! CopyBuffer()
  if search("debug_itr", "nw") || search("debug_bits", "nw")
    " echoerr "there exists debug_bits or debug_itr, remove them first"
    silent w !xsel -ib
  else
    silent w !xsel -ib
  endif
endfunction

xmap <C-c>  "+y
nmap <leader>wc :call CopyBuffer()<CR>

""" ---------- sort by line width

xmap gsw :'<,'> ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }'<CR><ESC>

""" ---------- easily move in wrapped lines
""" https://stackoverflow.com/a/21000307/10891757

noremap <silent> <expr> j v:count ? 'j' : 'gj'
noremap <silent> <expr> k v:count ? 'k' : 'gk'

""" ---------- tabs

nmap <tab>j     :tabnext<CR>
nmap <tab>l     :tablast<CR>
nmap <tab>h     :tabfirst<CR>
nmap <tab><tab> :tabnew<Space>
nmap <tab>k     :tabprevious<CR>

""" ---------- windows

" kill the buffer and its window
nmap <C-w>q     :Bd!<CR>
nmap <C-w><C-q> :bd!<CR>

" resize
nmap <C-Up>    <C-w>+
nmap <C-Down>  <C-w>-
nmap <C-Right> <C-w>>
nmap <C-Left>  <C-w><

" navigate
nmap <C-k>       <C-w>k
nmap <C-j>       <C-w>j
nmap <C-l>       <C-w>l
nmap <C-h>       <C-w>h
nmap <BS>        <C-w>h

""" ---------- without yanking

nnoremap <leader>d "_d
nnoremap <leader>c "_c
nnoremap <leader>D "_D
vnoremap <leader>d "_d
vnoremap <leader>c "_c
vnoremap <leader>D "_D
vnoremap <leader>p "_dP

""" ---------- terminal

nnoremap <space>tr <CMD>sp term://zsh<CR>

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

nnoremap <silent> <space>tw :Twilight<CR>

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

nnoremap <silent> <F4> :lua require'dap'.run_to_cursor()<CR>
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F6> :lua require"dap".disconnect({ terminateDebuggee = true }); require"dap".close()<CR>
nnoremap <silent> <F7> :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <F8> :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <F9> :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <space>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <space>dl :lua require'dap'.run_last()<CR>
nnoremap <silent> <space>df :Telescope dap frames<CR>
nnoremap <silent> <space>dc :Telescope dap commands<CR>
nnoremap <silent> <space>db :Telescope dap list_breakpoints<CR>
nnoremap <silent> <space>dg :lua require("dapui").toggle()<CR>
nnoremap <silent> <space>de :lua require("dapui").eval()<CR>
nnoremap <silent> <space>dE :lua require("dapui").eval(vim.fn.input('Expression: '))<CR>
xnoremap <silent> <space>de :lua require("dapui").eval(require("utils.get_visual_selection")())<CR>
" au FileType python nnoremap <silent> <leader>dtt :lua require('dap-python').test_method()<CR>
" au FileType python noremap <silent> <leader>dtc :lua require('dap-python').test_class()<CR>
" au FileType python noremap <silent> <leader>dts <ESC>:lua require('dap-python').debug_selection()<CR>

nnoremap <silent> <leader>tf :lua require("neotest").run.run(vim.fn.expand("%"))<CR>
nnoremap <silent> <leader>tr :lua require("neotest").run.run()<CR>
nnoremap <silent> <leader>ts :lua require("neotest").run.stop()<CR>
nnoremap <silent> <leader>ta :lua require("neotest").run.attach()<CR>
nnoremap <silent> <leader>td :lua require("neotest").run.run({strategy = "dap"})<CR>
nnoremap <silent> <space>to :lua require("neotest").output.open({ enter = true })<CR>
nnoremap <silent> <space>ts :lua require("neotest").summary.toggle()<CR>

""" ---------- eluxee/competitest.nvim
""" ---------- earleser97/cpbooster.vim
""" no <leader> here to make it easy for my fingers

function! CPIO()
  silent ! touch input
  silent ! touch output
  split input
  vsplit output
endfunction


nmap cpt <CMD>CompetiTest receive testcases<CR>
nmap cpp <CMD>CompetiTest receive problem<CR>
nmap cpc <CMD>CompetiTest receive contest<CR>
nmap cpr <CMD>CompetiTest run<CR>
nmap cpR <CMD>CompetiTest run_no_compile<CR>
nmap cpr <CMD>CompetiTest run<CR>
nmap cpe <CMD>CompetiTest edit<CR>
nmap cpa <CMD>CompetiTest add<CR>
nmap cpd :silent ! g++ -g "%" -o "%:p:r"<CR>
nmap cpio <CMD>call CPIO()<CR>

