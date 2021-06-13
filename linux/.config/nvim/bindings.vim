
""""""" -------------------------------------------------------
""" native in vim
""""""" -------------------------------------------------------

nnoremap Q <Nop>
vnoremap Q <Nop>

""" tabs --------------------------
map <tab>j :tabnext<CR>
map <tab>k :tabprevious<CR>
map <tab>l :tablast<CR>
map <tab>h :tabfirst<CR>
map <tab><tab> :tabnew<Space>

""" windows --------------------------
" move
map <C-Up>    <C-w>k
map <C-k>     <C-w>k
map <C-Down>  <C-w>j
map <C-j>     <C-w>j
map <C-Right> <C-w>l
map <C-l>     <C-w>l
map <C-Left>  <C-w>h
map <C-h>     <C-w>h
" resize
map <C-A-Up> <C-w>-
map <C-A-k> <C-w>-
map <C-A-Down> <C-w>+
map <C-A-j> <C-w>+
map <C-A-Right> <C-w>>
map <C-A-l> <C-w>>
map <C-A-Left> <C-w><
map <C-A-h> <C-w><

" move the cursor in the insertmode -------------------
imap <C-l> <right>
imap <C-h> <left>
imap <C-k> <up>
imap <C-j> <down>

""""""" -------------------------------------------------------
""" plugins
""""""" -------------------------------------------------------

""""""" vimfiler
""""""" ----------------------------------------
map <C-e><C-e> :NERDTreeToggle<CR>
map <C-e>e :NERDTreeFocus<CR>

""""""" fzf
""""""" ----------------------------------------
nnoremap <silent> <space>p :Files<CR>
nnoremap <silent> <space>g :GFiles<CR>
nnoremap <silent> <space>o :Buffers<CR>
nnoremap <A-f> :Ag!
nnoremap <C-f> :Rg!

""""""" coc-formatter
""""""" ----------------------------------------
vmap <C-S-i> <Plug>(coc-format-selected)
nmap <C-S-i> <Plug>(coc-format-selected)
nmap zc :Fold<CR>

""""""" ranger for vim
""""""" ----------------------------------------
nmap <space>r :RnvimrToggle<CR>

""""""" sneak 
""""""" ----------------------------------------
" remap so I can use , and ; with f and t
map gS <Plug>Sneak_,
map gs <Plug>Sneak_;
" I like quickscope better for this since it keeps me in the scope of a single line
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T


""""""" floaterm 
""""""" ----------------------------------------
let g:floaterm_keymap_new    = '<F9>'
let g:floaterm_keymap_next   = '<F10>'
let g:floaterm_keymap_prev   = '<F11>'
let g:floaterm_keymap_toggle = '<F12>'

