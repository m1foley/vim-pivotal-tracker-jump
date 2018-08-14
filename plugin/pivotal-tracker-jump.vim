" pivotal-tracker-jump.vim
" Maintainer:   Mike Foley
" Version:      1.0

if exists('g:loaded_pivotal_tracker_jump')
  finish
endif
let g:loaded_pivotal_tracker_jump = 1

function! s:pivotal_tracker_jump_gx()
  if getline('.') =~ '\[\(\(\#\d\{8,12\}\)[, ]*\)\+\]'
    let l:ticketid = substitute(expand('<cWORD>'), '\D', '', 'g')
    if l:ticketid =~ '^\d\{8,12\}$'
      call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx :
        \ 'https://www.pivotaltracker.com/story/show/'.l:ticketid)), 0)
      return
    endif
  endif

  call netrw#BrowseX(expand(exists("g:netrw_gx")? g:netrw_gx : '<cfile>'),
    \ netrw#CheckIfRemote())
endfunction

nnoremap <silent> gx :call <sid>pivotal_tracker_jump_gx()<cr>
