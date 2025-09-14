" Thomson Comer, NVIDIA
" MIT License
" autocmd configuration for full stack + c++/cuda

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " Spacing
  " Other settings for TypeScript
  autocmd FileType typescript setlocal sw=2 sts=2 et
  " Set tab to 4 spaces for markdown files
  autocmd FileType markdown setlocal sw=4 sts=4 et

  " Syntax
  " glsl syntax highlighting
  au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl,*.cuh,*.cu setf glsl
  autocmd FileType c,cpp,cu,cuh source ~/.vim/syntax/opengl.vim
  " cython syntax highlighting
  autocmd BufNewFile,BufRead *.pyx set syntax=python

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=81

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

  autocmd FileType setlocal indentkeys=0{,0},0),0],o,O,=endif,=enddef,=endfu,=endfor,=endwh,=endtry,=},=else,=finall,=END
  autocmd FileType setlocal indentexpr=

  " large file disable syntax highlighting
  autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif

  " Update the window title every time you enter a buffer
  autocmd BufEnter * let &titlestring = expand('%:t') . ' - ' . expand('%:p:h')

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

