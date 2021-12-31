""" ----------------------------------------------
""" build and preview md,tex,ms files as pdf files
""" ----------------------------------------------

let g:build_preview = v:true

" Call compile
" Open the PDF from /tmp/
function! Preview()
  call Compile()
  !zathura /tmp/op.pdf &
endfunction

" [1] Get the extension of the file
" [2] Apply appropriate compilation command
" [3] Save PDF as /tmp/op.pdf
function! Compile()
  let extension = expand('%:e')
  if extension == "ms"
    execute "! groff -ms % -T pdf > /tmp/op.pdf"
  elseif extension == "tex"
    execute "! pandoc -f latex -t latex % -o /tmp/op.pdf"
  elseif extension == "md"
    execute "! pandoc % -s -o /tmp/op.pdf"
  endif
endfunction

noremap <leader>v :call Preview()<CR><CR><CR>
noremap <leader>q :call Compile()<CR><CR>
