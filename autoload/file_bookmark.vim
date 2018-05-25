" ==============================================================
" Description:  This vim plugin provides bookmarks to the files
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/vim-file-bookmark
" Version:      1.0.0 (2017-11-27)
" Licence:      BSD-3-Clause
" ==============================================================

let s:positions = {
  \ 'current':      'edit',
  \ 'tab':          'tab split',
  \ 'top':          'leftabove split',
  \ 'bottom':       'rightbelow split',
  \ 'left':         'vertical leftabove split',
  \ 'right':        'vertical rightbelow split',
  \ 'top-full':     'topleft split',
  \ 'bottom-full':  'botright split',
  \ 'left-full':    'vertical topleft split',
  \ 'right-full':   'vertical botright split'
  \ }

func! file_bookmark#open(name, position) abort
  let l:position = get(s:positions, a:position, s:positions.tab)
  let l:file_path = get(g:file_bookmark, a:name, '')

  if !len(l:file_path)
    return
  end

  silent exec l:position . ' ' . l:file_path
  if g:file_bookmark_cd_to_file_directory
    silent exec 'lcd ' . expand('%:p:h')
  end
endfunc
