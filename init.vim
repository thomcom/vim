""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN MANAGEMENT - vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use ssh for plugin installation (more secure)
let g:plug_url_format = 'git@github.com:%s.git'

" https://github.org/junegunn/vim-plug
call plug#begin()

" === Language Support ===
Plug 'leafgarland/typescript-vim'      " TypeScript syntax & indentation
Plug 'stephpy/vim-yaml'                " YAML syntax improvements

" === File Navigation & Search ===
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy finder (binary)
Plug 'junegunn/fzf.vim'                              " Vim integration for fzf
Plug 'mangelozzi/nvim-rgflow.lua'      " Interactive ripgrep in vim

" === Visual & UX ===
Plug 'folke/tokyonight.nvim'           " Modern dark colorscheme
Plug 'powerman/vim-plugin-AnsiEsc'     " Handle ANSI escape sequences in logs

" === Code Quality ===
Plug 'averms/black-nvim', {'do': ':UpdateRemotePlugins'}  " Python formatter

" === LSP & Intelligence ===
Plug 'neovim/nvim-lspconfig'           " LSP configurations (currently unused)

" === AI Assistance ===
Plug 'github/copilot.vim'              " GitHub Copilot
Plug 'nvim-lua/plenary.nvim'           " Lua utilities (required by CopilotChat)
Plug 'CopilotC-Nvim/CopilotChat.nvim'  " Chat interface for Copilot
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LUA CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require("CopilotChat").setup {
  -- See Configuration section for options
}
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CORE VIM SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather than Vi settings (must be first!)
set nocompatible

" Modern dark colorscheme
colorscheme tokyonight-night

" Leader key for custom mappings
let mapleader = " " 

" System clipboard integration (Ubuntu/Linux)
set clipboard=unnamedplus

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Alternative Escape sequences (faster than reaching for Esc)
:imap jk <Esc>
:imap kj <Esc>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EDITING BEHAVIOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enhanced command-line completion
set wildmenu

" Allow backspacing over everything in insert mode
set backspace=eol,start,indent

" History and undo settings
if has("vms")
  set nobackup		" VMS: use versions instead of backup files
else
  set backup		" Keep backup files
endif
set history=1000	" Command line history (more than default 50)

" Visual feedback
set ruler		" Show cursor position in status line
set showcmd		" Display incomplete commands
set incsearch		" Incremental search as you type
set title		" Update terminal/window title

" Indentation preferences (2-space soft tabs)
set expandtab		" Use spaces instead of tabs
set tabstop=2		" Tab width in spaces
set shiftwidth=2	" Indent width
set background=dark	" Dark terminal background

" File format compatibility
set fileformats+=dos	" Handle DOS line endings

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM UTILITIES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" JSON formatting shortcut: key-\ then run python -m json.tool

" Load search match blinking utility
source ~/.config/nvim/blinken.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY REMAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Q for formatting instead of dangerous Ex mode
map Q gq

" F5: Reload vim configuration
nnoremap <F5> :source $MYVIMRC<CR>

" Ctrl-P: FZF file explorer (muscle memory from other editors)
nnoremap <C-p> :Files<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VISUAL SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting if terminal supports colors
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch		" Highlight search matches
endif

" Enhanced bracket/paren highlighting
hi MatchParen cterm=none ctermbg=green ctermfg=yellow

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILE HANDLING & PERSISTENCE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keep backup files in a cleaner location
set backupdir=~/.vim/backups,.

" ✨ INFINITE UNDO - One of vim's best features! ✨
" Persistent undo across vim sessions
set undodir=~/.config/nvim/undo_dirs
set undofile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TEXT WRAPPING & FORMATTING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart text wrapping (visual only, no hard breaks)
set wrap		" Wrap long lines visually
set linebreak		" Break at word boundaries
set textwidth=0		" No automatic hard line breaks
set formatoptions-=t	" Don't auto-wrap text while typing

" Note: Commented out forced 81-column width (causes terminal width issues)
" set textwidth=81
" set columns=81

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SESSION PERSISTENCE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remember cursor position when reopening files
augroup remember_cursor_position
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   execute "normal! g`\"" |
        \ endif
augroup END
