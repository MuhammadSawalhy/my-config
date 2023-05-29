""" ----------------------------------------------
""" build and preview md,tex,ms files as pdf files
""" ----------------------------------------------

let g:build_preview = v:true

" Open the PDF from /tmp/
function! Run()
  " TODO: use make if it has `run` entry
  " TODO: run it in terminal if it is executable
  if exists("b:run")
    let r = dispatch#expand(b:run) " from vim-dispatch plugin
    echo r
    silent exec "! " . r
  else
    echo 'nothing to run, you must define b:run variable'
  endif
endfunction

function! Compile(background)
  write
  if a:background
    Dispatch!
  else
    Dispatch
  endif
endfunction
 
autocmd FileType sh       let b:run      = 'timeout 5s bash "%:p:r" &'
autocmd FileType cpp      let b:dispatch = 'make compile'
" autocmd FileType cpp      let b:dispatch = 'g++ "%" -o "%:p:r"'
autocmd FileType cpp      let b:run      = 'timeout 5s "%:p:r" &'
autocmd FileType tex      let b:dispatch = 'xelatex -output-directory="%:p:h" "%"'
autocmd FileType tex      let b:run      = 'zathura "%:p:r.pdf" &'
autocmd FileType java     let b:dispatch = 'javac "%"'
autocmd FileType java     let b:run      = 'timeout 5s java "%:p:r" &'
autocmd FileType markdown let b:dispatch = 'pandoc "%" -s -o "%:p:r.pdf"'
autocmd FileType markdown let b:run      = 'zathura "%:p:r.pdf" &'

noremap <silent> <leader>v :call Run()<CR>
noremap <silent> <leader><leader>b :call Compile(v:false)<CR>
noremap <silent> <leader>b :call Compile(v:true)<CR>
