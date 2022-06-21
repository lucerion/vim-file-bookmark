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

if !exists('g:file_bookmark_cd_to_file_directory')
  let g:file_bookmark_cd_to_file_directory = 1
endif

func! s:autocomplete(input, _command_line, _cursor_position) abort
  return filter(keys(g:file_bookmark), "filereadable(expand(get(g:file_bookmark, v:val, ''))) && v:val =~ a:input")
endfunc

comm! -nargs=1 -complete=customlist,s:autocomplete FileBookmark call file_bookmark#open(<q-args>, <q-mods>)
