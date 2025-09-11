" Thomson Comer, NVIDIA
" MIT License
" old .vimrc
" No longer used, see /home/tcomer/.config/nvim/init.vim

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" I'm going to use leader?
let mapleader = " " 

" Clipboard for Ubuntu
set clipboard=unnamedplus

" remap Esc
:imap jk <Esc>
:imap kj <Esc>

" Display all matching files when we tab complete
set wildmenu

" allow backspacing over everything in insert mode
set backspace=eol,start,indent

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=1000		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" mine
set expandtab		" use soft tabs
set tabstop=2
set sw=2
set background=dark

" Enable setting the window title
set title

" inserting newlines into files, stop it
set fileformats+=dos

" json format!
" key-\ $!python -m json.tool

" blinken!
source /home/tcomer/.config/nvim/blinken.vim

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" put temp files somewhere less messy
set backupdir=~/.vim/backups,.

" better paren highlighting
hi MatchParen cterm=none ctermbg=green ctermfg=yellow

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

" yank to system clipboard in Ubuntu
set clipboard=unnamedplus

" F5 Refresh
nnoremap <F5> :source $MYVIMRC<CR>

" FZF File Explore
nnoremap <C-p> :Files<CR>

" Make it always exactly 81 chars wide.
" This causes the text to wrap at 81 characters, but only visually. The actual
" text is still 80 characters wide, so that it can be pasted into other
" programs without losing the last character.
"
" This causes major problems if the width of the terminal is less than 81
" characters so beware.
"set textwidth=81
"set columns=81

" Infinite undo
set undodir=~/.config/nvim/undo_dirs
set undofile

" Please never insert <CR> I hate that
set wrap
set linebreak
set textwidth=0
set formatoptions-=t

" Set up Vim options for better editing experience
set expandtab         " Use spaces instead of tabs
set shiftwidth=2      " Number of spaces to use for each step of (auto)indent
set tabstop=2         " Number of spaces that a <Tab> in the file counts for

set wrap
