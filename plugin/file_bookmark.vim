" ==============================================================
" Description:  This vim plugin provides bookmarks to the files
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/vim-file-bookmark
" Version:      1.0.0 (2017-11-27)
" Licence:      BSD-3-Clause
" ==============================================================

if exists('g:loaded_file_bookmark') || &compatible || v:version < 700
  finish
endif
let g:loaded_file_bookmark = 1

" let g:file_bookmark = {
"   \ 'bookmark_name': '/path/to/file'
"   \ }
if !exists('g:file_bookmark')
  let g:file_bookmark = {}
endif

if !exists('g:file_bookmark_default_position')
  let g:file_bookmark_default_position = 'tab'
endif

let s:split_positions = {
  \ 'top':    'leftabove',
  \ 'bottom': 'rightbelow',
  \ 'left':   'vertical leftabove',
  \ 'right':  'vertical rightbelow',
  \ 'tab':    'tab'
  \ }

func! s:open_file_bookmark(...) abort
  let l:allowed_position_args = map(keys(s:split_positions), '"-".v:val')
  let l:bookmark_name = get(filter(copy(a:000), 'index(l:allowed_position_args, v:val) < 0'), -1, '')
  let l:file_path = expand(get(g:file_bookmark, l:bookmark_name, ''))

  if filereadable(l:file_path)
    let l:position = g:file_bookmark_default_position
    let l:position_args = filter(copy(a:000), 'index(l:allowed_position_args, v:val) >= 0')
    if len(l:position_args)
      let l:position = substitute(l:position_args[-1], '-', '', 'g')
    endif
    let l:split_position = get(s:split_positions, l:position, s:split_positions.tab)

    silent exec l:split_position . ' split ' . l:file_path
  endif
endfunc

func! s:autocomplete(input, command_line, cursor_position) abort
  return filter(keys(g:file_bookmark), 'v:val =~ a:input')
endfunc

comm! -nargs=+ -complete=customlist,s:autocomplete FileBookmark call s:open_file_bookmark(<f-args>)