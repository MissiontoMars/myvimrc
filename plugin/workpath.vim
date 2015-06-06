""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File Name   : workpath.vim
" Maintainer  : Brook L.
" Create      : 2014.01.29
" Last Change : 2014.02.02
" License     :	This file is placed in the public domain.
" Description : Set work path, used for c.vim to specify the tags file.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:WorkPathList=[
					\'/home/wanxing.wwx/magic2/uuid4c/uuid4c/']

let g:WorkPathIdx=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display the list of work path and current work path.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function WP_getwp()

    echo "List of work path:"
    let b:Idx=0
    for b:WorkPath in g:WorkPathList
        echo "\t" . b:Idx . ": " . b:WorkPath
        let b:Idx+=1
    endfor

    echo "Current work path:"
    echo "\t" . g:WorkPathIdx . ": " . g:WorkPathList[g:WorkPathIdx]
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set work path.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function WP_setwp(WorkPathIdx)
    let g:WorkPathIdx=a:WorkPathIdx
    echo "Current work path:"
    echo "\t" . g:WorkPathIdx . ": " . g:WorkPathList[g:WorkPathIdx]
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" End of workpath.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

