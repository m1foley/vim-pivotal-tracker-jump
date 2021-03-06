" pivotal-tracker-jump.vim
" Maintainer:   Mike Foley
" Version:      1.1

if exists('g:loaded_pivotal_tracker_jump') || &compatible
  finish
endif
let g:loaded_pivotal_tracker_jump = 1

if !exists('g:pivotal_tracker_jump_url')
  let g:pivotal_tracker_jump_url = 'https://www.pivotaltracker.com/story/show/'
endif

function! s:pivotal_tracker_jump_gx()
  " Creates two regexps joined by \| which are identical except the first one
  " matches when the cursor is on the end bracket. This is referenced later
  " when l:matchno == 2
  let l:regexp = '\(\[\([a-zA-Z]\+s\s\+\)\?\(\(\#[0-9]\{8,12\}\)[, ]*\)\+\%#\]\)'
  let l:regexp = l:regexp . '\|' . substitute(l:regexp, '\\%#', '', '')

  let l:matchno = search(l:regexp, 'bWcnp', line('.'))
  if l:matchno
    " save cursor position in case it needs to get moved
    let l:orig_cursor_pos = getcurpos()

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

    " restore cursor in case it was moved
    call setpos('.', l:orig_cursor_pos)

    if l:storyid =~ '^[0-9]\{8,12\}$'
      call netrw#BrowseX(g:pivotal_tracker_jump_url . l:storyid, 0)
      return
    endif
  endif

  " fallback to default gx behavior
  call netrw#BrowseX(expand(exists('g:netrw_gx')? g:netrw_gx : '<cfile>'), netrw#CheckIfRemote())
endfunction

nnoremap <silent> gx :call <sid>pivotal_tracker_jump_gx()<cr>
