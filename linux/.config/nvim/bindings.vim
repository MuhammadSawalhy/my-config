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

""" ---------- preservim/nerdtree

" nnoremap <silent> <Space>e <CMD>NERDTreeToggle<CR>
" nnoremap <silent> <Space>E :NERDTreeFocus<CR>

""" ---------- ms-jpq/chadtree

nnoremap <silent> <Space>e <CMD>CHADopen<CR>
nnoremap <silent> <Space>E <CMD>CHADopen<CR>

""" ---------- fzf

nnoremap <silent> <space>p :Files<CR>
nnoremap <silent> <space>g :GFiles<CR>
nnoremap <silent> <space>o :Buffers<CR>
" from junegunn/fzf plugin
nnoremap <C-f> :Rg!<CR>

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

nmap gm <Plug>(git-messenger)

""" ---------- preservim/nerdcommenter

map <C-_> <plug>NERDCommenterToggle

""" ---------- preservim/tagbar

nmap <F8> :TagbarToggle<CR>

""" ---------- AndrewRadev/splitjoin.vim

" use native J to join lines
nmap gj :SplitjoinJoin<CR>
nmap gk :SplitjoinSplit<CR>

""" ---------- haya14busa/incsearch.vim

" nmap /  <Plug>(incsearch-forward)
" nmap ?  <Plug>(incsearch-backward)
" nmap g/ <Plug>(incsearch-stay)

