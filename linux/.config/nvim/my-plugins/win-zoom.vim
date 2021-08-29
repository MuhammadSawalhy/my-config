"""  this plugin replaces the built-in `CTRL-W o` binding
" if exists("g:win_size_loaded") | finish | endif
" let g:win_size_loaded = 1

fun! WinZoomToggle() abort
    if ! exists('w:win_is_zoomed') | let w:win_is_zoomed = 0 | endif
    if w:win_is_zoomed == 0
        let w:win_old_width = winwidth(0)
        let w:win_old_height = winheight(0)
        wincmd _
        wincmd |
        let w:win_is_zoomed = 1
    elseif w:win_is_zoomed == 1
        call WinZoomUnzoom()
    endif
endfun

fun! WinZoomUnzoom() abort
    execute "vertical resize " . w:win_old_width
    execute "resize " . w:win_old_height
    let w:win_is_zoomed = 0
endfun

augroup restore_original_size
    autocmd WinClosed :call WinZoomUnzoom()<CR>
augroup END

noremap <silent> <Plug>WinZoom_Toggle :call WinZoomToggle()<CR>
