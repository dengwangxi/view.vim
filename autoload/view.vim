"======================================================================
"
"
"======================================================================
"
function! view#ViewQuickfix(linenr)
    let l:original_win = win_getid()
    let linenr = (a:linenr > 0)? a:linenr : line('.')
    let qflist = getqflist()
    if linenr < 1 || linenr > len(qflist)
        exec "norm! \<esc>"
        return ""
    endif
    let entry = qflist[linenr - 1]
    unlet qflist
    if entry.valid
        if entry.bufnr > 0
            call ViewLocateWindow()
            if winbufnr('%') != entry.bufnr
                silent exec "b! ".entry.bufnr
            endif
            if entry.lnum > 0
                noautocmd exec "".entry.lnum
            endif
            call win_gotoid(l:original_win)
            return ""
    else
        exec "norm! \<esc>"
    endif
    return ""
endfunction

function! view#ViewCloseWindow()
    exe ":pclose"
endfunction

function! view#ViewScrollDown()
    let l:original_win = win_getid()
    let l:find_ret = s:ViewFindWindow()
    if l:find_ret == 0
        return
    endif
    let l:linecount = g:view_config['scrolllinecount']
    execute "normal! " . l:linecount . "\<c-y>"
    "noautocmd wincmd p
    call win_gotoid(l:original_win)
endfunction

function! view#ViewScrollUp()
    let l:original_win = win_getid()
    let l:find_ret = s:ViewFindWindow()
    if l:find_ret == 0
        return
    endif
    let l:linecount = g:view_config['scrolllinecount']
    execute "normal! " . l:linecount . "\<c-e>"
    "noautocmd wincmd p
    call win_gotoid(l:original_win)
endfunction

function! s:LocateWorkWindow()
    for i in range(winnr('$'))
        let buftype = &buftype
        "echom "buf type".buftype
        if index(g:view_config['avoid'], buftype) != -1
            "echom "find avoid ".buftype
            exec 'wincmd W'
        else
            "echom "break ".winnr()
            break
        endif
    endfor
endfunction

function! s:ViewCreateWindow()
    let l:mode = g:view_config['mode']
    let l:openpos = g:view_config['pos']
    let l:width = g:view_config['size']
    exe 'silent keepalt '.l:openpos.' '.l:mode.' split '. "__PREVIEW__"
    if l:width > 0
        exe 'silent '.l:mode.' resize '.l:width
    endif 
    
    setlocal noreadonly " in case the "view" mode is used
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal nobuflisted
    setlocal nomodifiable
    setlocal textwidth=0
    
    if has('balloon_eval')
        setlocal balloonexpr=TagbarBalloonExpr()
        set ballooneval
    endif
    
    setlocal nolist
    setlocal nowrap
    setlocal winfixwidth
    setlocal previewwindow
    call s:ViewRecordWindow()
endf

function! ViewLocateWindow()
    let l:find_ret = s:ViewFindWindow()
    if l:find_ret == 0
        call s:LocateWorkWindow()
        call s:ViewCreateWindow()
    endif
endfunction

function! s:ViewRecordWindow()
    let t:__VIEW_WINDOW_ID__ = win_getid()
    "echom "create winid:".t:__VIEW_WINDOW_ID__
endfunction

function! s:ViewFindWindow()
   if exists("t:__VIEW_WINDOW_ID__")
       let l:find_ret = win_gotoid(t:__VIEW_WINDOW_ID__)
       if l:find_ret == 1
           return 1
       endif
   endif
   return 0
endfunction

