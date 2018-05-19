""""" Vundle boilerplate and Plugin List
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-surround'
Plugin 'jiangmiao/auto-pairs'
Plugin 'w0rp/ale'
Plugin 'luochen1990/rainbow'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on

""""" set termguicolors
colorscheme seattle

""""" Keymappings
set pastetoggle=<F2>

""""" Python-recommended tabbing
set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4

""""" Required by YCM
set encoding=utf-8
set fileencoding=utf-8
set enc=utf-8

""""" Airline Options
" AirlineTheme dark             " Original, default theme
let g:airline_theme='bubblegum'
set ttimeoutlen=1
" We don't need Vim's native mode indicator:
set noshowmode                  " see :help 'showmode'

let g:airline_powerline_fonts = 1
" Unicode stuff for Airline
""" Note that a lot of things can mess with Unicode. If Airline isn't
""" displaying properly, make sure Vim is using utf-8. If you're running
""" tmux, close it out and run it as `tmux -u`. Your locale and terminal
""" also must enable utf-8 AND have a Powerline-patched font. UTF-8 is 
""" bloat, but so are statuslines xP Also, it seems that urxvt hates
""" Powerline fonts, for all that it's supposed to be king of UTF-8.
""" There's some improvement using the airline_powerline_fonts setting 
""" above, but some symbols won't display--I think those ones are particular
""" to airline as they must be defined below. 
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"" Uncomment the seperators for terminals that don't support Powerline fonts.
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

""""" Auto-pairs settings
" Enable FlyMode
let g:AutoPairsFlyMode = 1

""""" Enable color-coded brackets
let g:rainbow_active = 1 " Use :RainbowToggle to turn it off/on in the editor.
