" pivotal-tracker-jump.vim
" Maintainer:   Mike Foley
" Version:      1.0

if exists('g:loaded_pivotal_tracker_jump')
  finish
endif
let g:loaded_pivotal_tracker_jump = 1

function! s:pivotal_tracker_jump_gx()
  " The two expressions surrounding \| are identical except the first one
  " matches when cursor is on the end bracket. This is referenced later
  " when l:regexno == 2
  let l:regexno = search('\(\[\(\(\#[0-9]\{8,12\}\)[, ]*\)\+\%#\]\)\|\(\[\(\(\#[0-9]\{8,12\}\)[, ]*\)\+\]\)', 'bWcnp', line('.'))
  if l:regexno
    " If cursor is on the end bracket, move it backwards so <cword> will match
    " the last ticket ID
    if l:regexno == 2
      normal! ge
    endif

    let l:ticketid = expand('<cword>')
    if l:ticketid =~ '^[0-9]\{8,12\}$'
      call netrw#BrowseX('https://www.pivotaltracker.com/story/show/'.l:ticketid, 0)
      return
    endif
  endif

  " fallback to default gx behavior
  call netrw#BrowseX(expand(exists('g:netrw_gx')? g:netrw_gx : '<cfile>'), netrw#CheckIfRemote())
endfunction

nnoremap <silent> gx :call <sid>pivotal_tracker_jump_gx()<cr>
