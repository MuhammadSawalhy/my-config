
"""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++
""""""       						native in vim
"""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++

""" disabling ---------------------------

nnoremap Q <Nop>
vnoremap Q <Nop>

""" tabs --------------------------------

map <tab>j :tabnext<CR>
map <tab>k :tabprevious<CR>
map <tab>l :tablast<CR>
map <tab>h :tabfirst<CR>
map <tab><tab> :tabnew<Space>

""" windows -----------------------------

" move
nmap <C-Up>    <C-w>k
nmap <C-k>     <C-w>k
nmap <C-Down>  <C-w>j
nmap <C-j>     <C-w>j
nmap <C-Right> <C-w>l
nmap <C-l>     <C-w>l
nmap <C-Left>  <C-w>h
nmap <C-h>     <C-w>h
nmap <BS>      <C-w>h " <C-h>

" resize
nmap <C-M-Up> <C-w>-
nmap <C-M-k> <C-w>-
nmap <C-M-Down> <C-w>+
nmap <C-M-j> <C-w>+
nmap <C-M-Right> <C-w>>
nmap <C-M-l> <C-w>>
nmap <C-M-Left> <C-w><
nmap <M-BS> <C-w><

""" move the cursor while insert mode ---

imap <C-l> <Right>
imap <C-k> <Up>
imap <C-j> <Down>
imap <C-h>  <Left>
imap <BS>  <Left>  " <C-h>

"""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++
"""""" 											plugins
"""""" +++++++++++++++++++++++++++++++++++++++++++++++++++++++

""" vimfiler ----------------------------

map <C-e><C-e> :NERDTreeToggle<CR>
map <C-e>e :NERDTreeFocus<CR>

""" fzf ---------------------------------

nnoremap <silent> <space>p :Files<CR>
nnoremap <silent> <space>g :GFiles<CR>
nnoremap <silent> <space>o :Buffers<CR>
nnoremap <M-f> :Ag!<CR>
nnoremap <C-f> :Rg!<CR>

""" coc-formatter -----------------------

vmap <C-S-i> <Plug>(coc-format-selected)
nmap <C-S-i> <Plug>(coc-format-selected)
nmap zc :Fold<CR>

""" ranger for vim ----------------------

nmap <space>r :RnvimrToggle<CR>

""" sneak -------------------------------

" remap so I can use , and ; with f and t
map gS <Plug>Sneak_,
map gs <Plug>Sneak_;
" I like quickscope better for this since it keeps me in the scope of a single line
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

""" floaterm ----------------------------

let g:floaterm_keymap_new    = '<F9>'
let g:floaterm_keymap_next   = '<F10>'
let g:floaterm_keymap_prev   = '<F11>'
let g:floaterm_keymap_toggle = '<F12>'

""" vim-easy-align ----------------------

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""" sbdchd/neoformat --------------------

nmap <leader>nf :Neoformat<CR>

""" rhysd/git-messenger.vim -------------

nmap gm <Plug>(git-messenger)

""" preservim/nerdcommenter -------------

map <C-_> <plug>NERDCommenterToggle " <C-/>
