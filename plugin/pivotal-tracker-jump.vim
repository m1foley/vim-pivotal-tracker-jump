" pivotal-tracker-jump.vim
" Maintainer:   Mike Foley
" Version:      1.0

if exists('g:loaded_pivotal_tracker_jump')
  finish
endif
let g:loaded_pivotal_tracker_jump = 1

function! s:pivotal_tracker_jump_gx()
  " Creates two regexps joined by \| which are identical except the first one
  " matches when the cursor is on the end bracket. This is referenced later
  " when l:matchno == 2
  let l:regexp = '\(\[\([a-zA-Z]\+s\s\+\)\?\(\(\#[0-9]\{8,12\}\)[, ]*\)\+\%#\]\)'
  let l:regexp = l:regexp . '\|' . substitute(l:regexp, '\\%#', '', '')

  let l:matchno = search(l:regexp, 'bWcnp', line('.'))
  if l:matchno
    " If cursor is on the end bracket, move it backwards so <cword> will match
    " the last story ID
    if l:matchno == 2
      normal! ge
    endif

    let l:storyid = expand('<cword>')

    " If cursor is on a leading verb, move to first story ID
    if l:storyid =~? '^\(finishes\|fixes\|delivers\)$'
      normal! W
      let l:storyid = expand('<cword>')
    endif

    if l:storyid =~ '^[0-9]\{8,12\}$'
      call netrw#BrowseX('https://www.pivotaltracker.com/story/show/'.l:storyid, 0)
      return
    endif
  endif

  " fallback to default gx behavior
  call netrw#BrowseX(expand(exists('g:netrw_gx')? g:netrw_gx : '<cfile>'), netrw#CheckIfRemote())
endfunction

nnoremap <silent> gx :call <sid>pivotal_tracker_jump_gx()<cr>
