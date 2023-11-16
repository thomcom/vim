" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" https://github.org/junegunn/vim-plug
call plug#begin()

" Typescript
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'leafgarland/typescript-vim'

" Universal linting
"Plug 'dense-analysis/ale'

" Folding - Temporarily disabling
"Plug 'tmhedberg/SimpylFold'
"Plug 'Konfekt/FastFold'

" Python - Temporarily disabling in favor of ALE/Coc
"Plug 'nvie/vim-flake8'
"Plug 'Integralist/vim-mypy'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'github/copilot.vim'

call plug#end()

" ALE
highlight ALEError ctermbg=Red ctermfg=White guibg=#991199 guifg=#FFFFFF
let g:ale_enable = 1
let b:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'python': ['black', 'autoflake', 'isort'],
\ 'javascript': ['xo', 'eslint'],
\ 'typescript': ['xo', 'eslint'],
\ 'typescript.tsx': ['xo'],
\ 'typescriptreact': ['xo']
\}
let g:ale_linters = {
\ 'python': ['flake8', 'mypy', 'black'],
\ 'javascript': ['xo', 'tsserver'],
\ 'typescript': ['xo', 'tsserver'],
\ 'typescript.tsx': ['xo', 'tsserver'],
\ 'typescriptreact': ['xo', 'tsserver']
\}
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_cursor_moved = 0
let g:ale_lint_on_insert = 0
let g:ale_python_black_options = '-l 78'
nnoremap <C-k> :ALEDetail<CR> " ALE Detail
nnoremap <C-]> :ALEGoToDefinition<CR> " ALE Jump

" COC
let g:coc_global_extensions = ['coc-tsserver', 'coc-prettier', 'coc-eslint']
let g:coc_user_config = {
\   'format.enable': v:true,
\   'tsserver.enable': v:true,
\}
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" folding?
set foldmethod=expr
nnoremap <space> za
vnoremap <space> zf

" Clipboard for Ubuntu
set clipboard=unnamedplus

" black
" autocmd bufwritepost *.py execute ':!black -l 79 %'

" flake8
" autocmd bufwritepost *.py call flake8()

" flake8-cython
" autocmd bufwritepost *.pyx,*.pxd call flake8()

" tmux
"autocmd bufreadpost,filereadpost,bufnewfile * call system("tmux rename-window " . expand("%"))

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

" Update the window title every time you enter a buffer
autocmd BufEnter * let &titlestring = expand('%:t') . ' - ' . expand('%:p:h')

" inserting newlines into files, stop it
set fileformats+=dos

" large file disable syntax highlighting
autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif

" json format!
" key-\ $!python -m json.tool

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

" glsl syntax highlighting
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl,*.cuh,*.cu setf glsl
autocmd FileType c,cpp,cu,cuh source ~/.vim/syntax/opengl.vim

" cython syntax highlighting
autocmd BufNewFile,BufRead *.pyx set syntax=python

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

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Modified version of Damian Conway's Die Blinkënmatchen: highlight matches
"
" This is how long you want the blinking to last in milliseconds. If you're
" using an earlier Vim without the `+timers` feature, you need a much shorter
" blink time because Vim blocks while it waits for the blink to complete.
let s:blink_length = has("timers") ? 500 : 100

if has("timers")
  " This is the length of each blink in milliseconds. If you just want an
  " interruptible non-blinking highlight, set this to match s:blink_length
  " by uncommenting the line below
  let s:blink_freq = 50
  "let s:blink_freq = s:blink_length
  let s:blink_match_id = 0
  let s:blink_timer_id = 0
  let s:blink_stop_id = 0

  " Toggle the blink highlight. This is called many times repeatedly in order
  " to create the blinking effect.
  function! BlinkToggle(timer_id)
    if s:blink_match_id > 0
      " Clear highlight
      call BlinkClear()
    else
      " Set highlight
      let s:blink_match_id = matchadd('ErrorMsg', s:target_pat, 101)
      redraw
    endif
  endfunction

  " Remove the blink highlight
  function! BlinkClear()
    call matchdelete(s:blink_match_id)
    let s:blink_match_id = 0
    redraw
  endfunction

  " Stop blinking
  "
  " Cancels all the timers and removes the highlight if necessary.
  function! BlinkStop(timer_id)
    " Cancel timers
    if s:blink_timer_id > 0
      call timer_stop(s:blink_timer_id)
      let s:blink_timer_id = 0
    endif
    if s:blink_stop_id > 0
      call timer_stop(s:blink_stop_id)
      let s:blink_stop_id = 0
    endif
    " And clear blink highlight
    if s:blink_match_id > 0
      call BlinkClear()
    endif
  endfunction

  augroup die_blinkmatchen
    autocmd!
    autocmd CursorMoved * call BlinkStop(0)
    autocmd InsertEnter * call BlinkStop(0)
  augroup END
endif

function! HLNext(blink_length, blink_freq)
  let s:target_pat = '\c\%#'.@/
  if has("timers")
    " Reset any existing blinks
    call BlinkStop(0)
    " Start blinking. It is necessary to call this now so that the match is
    " highlighted initially (in case of large values of a:blink_freq)
    call BlinkToggle(0)
    " Set up blink timers.
    let s:blink_timer_id = timer_start(a:blink_freq, 'BlinkToggle', {'repeat': -1})
    let s:blink_stop_id = timer_start(a:blink_length, 'BlinkStop')
  else
    " Vim doesn't have the +timers feature. Just use Conway's original
    " code.
    " Highlight the match
    let ring = matchadd('ErrorMsg', s:target_pat, 101)
    redraw
    " Wait
    exec 'sleep ' . a:blink_length . 'm'
    " Remove the highlight
    call matchdelete(ring)
    redraw
  endif
endfunction

" Set up maps for n and N that blink the match
execute printf("nnoremap <silent> n n:call HLNext(%d, %d)<cr>", s:blink_length, has("timers") ? s:blink_freq : s:blink_length)
execute printf("nnoremap <silent> N N:call HLNext(%d, %d)<cr>", s:blink_length, has("timers") ? s:blink_freq : s:blink_length)

" yank to system clipboard in Ubuntu
set clipboard=unnamedplus

" F5 Refresh
nnoremap <F5> :source $MYVIMRC<CR>

" FZF File Explore
nnoremap <C-p> :Files<CR>

" Make it always exactly 79 chars wide.
set textwidth=79
set columns=79

" Infinite undo
set undodir=~/.vim/undo_dirs
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

" Other settings for TypeScript
autocmd FileType typescript setlocal sw=2 sts=2 et

set nowrap
