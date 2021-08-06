" bases
nn <silent> <leader>xb :call CocLocations('ccls','$ccls/inheritance')<cr>
" bases of up to 3 levels
nn <silent> <leader>xB :call CocLocations('ccls','$ccls/inheritance',{'levels':3})<cr>
" derived
nn <silent> <leader>xd :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<cr>
" derived of up to 3 levels
nn <silent> <leader>xD :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true,'levels':3})<cr>

" caller
nn <silent> <leader>xc :call CocLocations('ccls','$ccls/call')<cr>
" callee
nn <silent> <leader>xC :call CocLocations('ccls','$ccls/call',{'callee':v:true})<cr>

" $ccls/member
" member variables / variables in a namespace
nn <silent> <leader>xm :call CocLocations('ccls','$ccls/member')<cr>
" member functions / functions in a namespace
nn <silent> <leader>xf :call CocLocations('ccls','$ccls/member',{'kind':3})<cr>
" nested classes / types in a namespace
nn <silent> <leader>xs :call CocLocations('ccls','$ccls/member',{'kind':2})<cr>

nmap <silent> <leader>xt <Plug>(coc-type-definition)<cr>
nn <silent> <leader>xv :call CocLocations('ccls','$ccls/vars')<cr>
nn <silent> <leader>xV :call CocLocations('ccls','$ccls/vars',{'kind':1})<cr>

"""""" navigation
" nn <silent><buffer> <C-l> :call CocLocations('ccls','$ccls/navigate',{'direction':'D'})<cr>
" nn <silent><buffer> <C-k> :call CocLocations('ccls','$ccls/navigate',{'direction':'L'})<cr>
" nn <silent><buffer> <C-j> :call CocLocations('ccls','$ccls/navigate',{'direction':'R'})<cr>
" nn <silent><buffer> <C-h> :call CocLocations('ccls','$ccls/navigate',{'direction':'U'})<cr>
