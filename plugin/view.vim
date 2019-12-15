"======================================================================
"
"
"======================================================================

let s:view_config  = {
    \ 'mode':'vertical',
    \ 'pos':'rightbelow',
    \ 'size':0,
    \ 'scrolllinecount':2,
    \ 'scrolloffset':2,
    \ 'avoid':['quickfix', 'help', 'nofile']}

if exists("g:view_config")
    let g:view_config = extend(s:view_config, g:view_config)
else
    let g:view_config = s:view_config
endif

command! -nargs=0 ViewQuickfix :call view#ViewQuickfix('')
command! -nargs=0 ViewScrollUp :call view#ViewScrollUp()
command! -nargs=0 ViewScrollDown :call view#ViewScrollDown()

if !exists("g:view_autoview") 
    let g:view_autoview = 1
endif

if g:view_autoview
    autocmd FileType qf nnoremap <silent><buffer> j j:ViewQuickfix<CR>
    autocmd FileType qf nnoremap <silent><buffer> k k:ViewQuickfix<CR>
    autocmd FileType qf nnoremap <silent><buffer> u :ViewScrollUp<CR>
    autocmd FileType qf nnoremap <silent><buffer> d :ViewScrollDown<CR>
endif

