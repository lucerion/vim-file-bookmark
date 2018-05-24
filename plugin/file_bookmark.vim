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

if !exists('g:file_bookmark')
  let g:file_bookmark = {}
endif

if !exists('g:file_default_position')
  let g:file_bookmark_position = 'tab'
endif

if !exists('g:file_bookmark_cd_to_file_directory')
  let g:file_bookmark_cd_to_file_directory = 1
endif

let s:positions = {
  \ 'top':    'leftabove',
  \ 'bottom': 'rightbelow',
  \ 'left':   'vertical leftabove',
  \ 'right':  'vertical rightbelow',
  \ 'tab':    'tab'
  \ }

func! s:open_file_bookmark(name, position) abort
  let l:position = get(s:positions, a:position, s:positions.tab)
  let l:file_path = get(g:file_bookmark, a:name, '')

  if !len(l:file_path)
    return
  end

  silent exec l:position . ' split ' . l:file_path
  if g:file_bookmark_cd_to_file_directory
    silent exec 'lcd ' . expand('%:p:h')
  end
endfunc

func! s:autocomplete(input, _command_line, _cursor_position) abort
  return filter(keys(g:file_bookmark), "filereadable(expand(get(g:file_bookmark, v:val, ''))) && v:val =~ a:input")
endfunc

comm! -nargs=1 -complete=customlist,s:autocomplete FileBookmark
  \ call s:open_file_bookmark(<q-args>, g:file_bookmark_position)
