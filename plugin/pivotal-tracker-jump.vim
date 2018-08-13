" pivotal-tracker-jump.vim
" Maintainer:   Mike Foley
" Version:      1.0

if exists('g:loaded_pivotal_tracker_jump')
  finish
endif
let g:loaded_pivotal_tracker_jump = 1

function! s:pivotal_tracker_jump_gx()
  if getline('.') =~ '\[#\d\{8,12\}\]'
    let cfile = expand('<cfile>')
    if !filereadable(cfile)
      let cfile = substitute(cfile, '#', '', '')
      call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx :
        \ 'https://www.pivotaltracker.com/story/show/'.cfile)), netrw#CheckIfRemote())
      return
    endif
  endif

  call netrw#BrowseX(expand(exists("g:netrw_gx")? g:netrw_gx : '<cfile>'),
    \ netrw#CheckIfRemote())
endfunction

nnoremap <silent> gx :call <sid>pivotal_tracker_jump_gx()<cr>
