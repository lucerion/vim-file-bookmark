" ==============================================================
" Description:  This vim plugin provides bookmarks to the files
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/vim-file-bookmark
" Version:      1.0.0 (2017-11-27)
" Licence:      BSD-3-Clause
" ==============================================================

let s:positions = {
  \ 'current':      'edit',
  \ 'tab':          'tabedit',
  \ 'top':          'leftabove split',
  \ 'bottom':       'rightbelow split',
  \ 'left':         'leftabove vsplit',
  \ 'right':        'rightbelow vsplit',
  \ 'top-full':     'topleft split',
  \ 'bottom-full':  'botright split',
  \ 'left-full':    'topleft vsplit',
  \ 'right-full':   'botright vsplit'
  \ }

func! file_bookmark#open(name, split) abort
  let l:file_path = get(g:file_bookmark, a:name, '')
  if !len(l:file_path)
    return
  end

  silent exec s:position(a:split) . ' ' . l:file_path

  if g:file_bookmark_cd_to_file_directory
    silent exec 'lcd ' . expand('%:p:h')
  end
endfunc

func! s:position(split)
  if len(a:split)
    return a:split . ' split'
  endif

  return get(s:positions, g:file_bookmark_position, s:positions.tab)
endfunc
