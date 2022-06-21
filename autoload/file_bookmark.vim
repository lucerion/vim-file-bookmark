" ==============================================================
" Description:  This vim plugin provides bookmarks to the files
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/vim-file-bookmark
" Version:      1.0.0 (2017-11-27)
" Licence:      BSD-3-Clause
" ==============================================================

func! file_bookmark#open(name, mods) abort
  let l:file_path = get(g:file_bookmark, a:name, '')
  if !len(l:file_path)
    return
  end

  silent exec a:mods . ' split ' . l:file_path

  if g:file_bookmark_cd_to_file_directory
    silent exec 'lcd ' . expand('%:p:h')
  end
endfunc
