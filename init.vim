" 
" Plugins managed with vim-plug (https://github.com/junegunn/vim-plug).
"
" LSP integration provided by CoC (https://github.com/neoclide/coc.nvim).
" CoC utilizes Node and npm to manage its own plugin ecosystem and is
" configured separately in $NEOVIM_CONF_DIR/coc-settings.json.
"
" I try to organize configs by what they modify, eg. global Vim settings,
" plugin1 settings, plugin2 settings. etc. Language-specific autocommands are
" defined at the bottom of the file in no particular order. Vim-plug requires
" that plugins to install be listed at the beginning of the file.
"
" For ease of reference, this is a list of added/modified keymappings:
"     <space>a      coc-action (Open menu of LSP-provided refactor ops)
"     <space>;      coc-action against current line
"     <space>A      coc-diagnostics (Quickfix window of LSP messages)
"     <space>o      coc outline (FZF window of buffer symbols
"     <space>s      coc symbols (FZF window of workspace symbols)
"     <space>j      :CocNext (default CocAction for next item)
"     <space>k      :CocPrev (default CocAction for previous item)
"     <space>p      resume previous coc list
"     <space>Esc    coc-refactor (Menu of refactor ops, larger scope)
"     <space>c      coc commands (list of available CoC commands)
"     <space>e      List of installed CoC extensions
"     <space>r      List references to symbol under cursor
"     <space>R      Rename symbol (refactor operation)
"     <space>f      Run formatter (rust-fmt, black, etc.) on selected code
"     <space>F      Run formatter (rust-fmt, black, etc.) on whole buffer
"     <space>q      Run LSP quickfix action on current line
"     <M-V>         Open Vista sidebar (symbol outline for buffer)
"     <M-C>         Search tags with Vista (provided by CoC)
"     <F5>          Run :makeprg and open Quickfix window with any errors
"     Shift-k       Show docstring for symbol
"     <F6>          (.c files, Windows only) Run the exe built from current file
"                   (.rs files) Run the rust module built by this project
"     <F2>          pastetoggle
"     <Leader>ig    Toggle indentguides
"     <Leader>ct    Toggle context window
"     <Leader>rn    Toggle relative line numbers
"     <C-W>%        Vsplit alternate buffer
"     [< and ]<     jump to the previous or the next line with the same indentation level as the current line.
"     [> and ]>     jump to the previous or the next line with an indentation level lower than the current line.
"
" And some default keymappings that I may forget about:
"     <C-W>}        Show tag definition in Preview window (tags provided by CoC)
"     <C-W>^        Hsplit alternate buffer
"     [I            List all occurrences of the string under cursor, starting
"                   from the beginning of the buffer
"     ]I            Same, but starting from cursor position



set nocompatible              " required

" Plugins
call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'junegunn/vim-plug'
"" Aesthetics and status lines
Plug 'doums/darcula'
Plug 'jnurmine/Zenburn'
Plug 'jaredgorski/SpaceCamp'
Plug 'morhetz/gruvbox'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'luochen1990/rainbow'
Plug 'nathanaelkane/vim-indent-guides'
"
"" IDE-like plugins
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"
""" Project navigation
"Plug 'scrooloose/nerdtree'
"Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'     " LSP-based, tags-compat. symbol browser
Plug 'wellle/context.vim'       " Shows cursor context in a floating window
"
""" LSP integration
Plug 'neoclide/coc.nvim', {'branch': 'release'}
""""" Coc has its own package management, by god
""""" :CocInstall <extension> / :CocUninstall <extensnion>
""""" :CocList extensions 
"""""" coc-snippets
"""""" coc-python
"""""" coc-yaml
"""""" coc-rls # Removed
"""""" coc-tag
"""""" coc-word
"""""" coc-syntax
"""""" coc-gocode
"""""" coc-json
"""""" coc-solargraph (ruby ls)
"""""" coc-ultisnips
"""""" coc-java
"""""" coc-react-refactor
"""""" coc-rust-analyzer
""" Language Server sources
" https://github.com/mads-hartmann/bash-language-server
" https://github.com/saibing/tools (golang)
" https://github.com/Alloyed/lua-lsp
" https://github.com/rust-lang/rls  " removed
" https://github.com/fannheyward/coc-rust-analyzer
" https://github.com/lingua-pupuli/puppet-editor-services  " removed
""" `,"--puppet-settings=--moduledir,/path/to/module/path"],` from the lsp
""" definition in the coc.json config.
"
"" Language-specific plugins
Plug 'fatih/vim-go'
Plug 'rodjek/vim-puppet'
Plug 'vim-scripts/indentpython.vim'
"Plug 'chemzqm/vim-jsx-improve'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
"
"" Holy shit, firefox integration???
"Plug 'glacambre/firenvim', { 'do': function('firenvim#install(0))') }

call plug#end()
filetype plugin indent on

" Global Editor Options
"let mapleader = '\'  " Default <Leader>, made explicit
syntax on
set hidden    " Don't flip out if I open a new buffer without saving
set showcmd
set nu 
set rnu
"" Make it easy to turn relative line numbers on and off
let g:rnu_on = 1
function Toggle_rnu()
    if g:rnu_on == 1
        let g:rnu_on = 0
        set nornu
    else
        let g:rnu_on = 1
        set rnu
    endif
endfunction
nnoremap <Leader>rn :call Toggle_rnu()<CR>
"
"" Default tab key behavior
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
filetype indent on
"
"" Windowing options
set splitbelow
set splitright
nnoremap <C-W>% :vsplit #<CR>
" 
"" netrw (file browser) options
let g:netrw_liststyle=3
"
"" Compile/run programs with F5 (must set makeprg first--au cmds at bottom
"" handle this for .py and .c files only)
nnoremap <F5> :w<CR>:make<CR>:cw<CR>
"" Turn paste mode on/off with F2
set pastetoggle=<F2>
"
"" Colors
set termguicolors
"colorscheme  seattle
"colorscheme darcula
"colorscheme spacecamp
"" Change terminal's blue color for legibility on dark backgrounds
let g:terminal_color_4 = '#3298F1'
" Gruv-y
set background=dark
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox 
"
" The following function and mappings were taken from 
" https://vim.fandom.com/wiki/Move_to_next/previous_line_with_same_indentation
" and slightly modified:
"
" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction
"" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [< :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]< :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [> :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]> :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [< <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]< <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [> <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]> <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [< :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]< :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [> :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]> :call NextIndent(1, 1, 1, 1)<CR>
"
"" Keep folds on save+quit
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" Plugins configs
"
"" Context.vim
""" This plugin is a little slow, and is mostly useful for deeply-nested code
""" blocks where the top of the block has scrolled off screen. So, off by
""" default, but easy to turn on with \ct
let g:context_enabled = 0
nnoremap <Leader>ct :ContextToggle<CR>
"
"" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
""" Default toggle is <leader>ig.
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 1
"hi IndentGuidesOdd ctermbg=black  " Example color customization
"hi IndentGuidesEven ctermbg=darkgrey
"
"" Airline
"let g:airline_theme='bubblegum' "Works well with seattle
"let g:airline_theme='base16_spacemacs' "Works perfectly with spacevim (less so with redshift at full)
"let g:airline_theme='jellybeans' "Almost identical to spacemacs, with more legible black text
let g:airline_theme = 'gruvbox'
set ttimeoutlen=1
""" We don't need Vim's native mode indicator with airline:
set noshowmode                  " see :help 'showmode'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline_powerline_fonts = 1
""" Troubleshooting characters not displaying correctly:
""" * Make sure Vim is using utf-8.
""" * Tmux: close it out and run it as `tmux -u`. 
""" * Locale enables utf-8.
""" * Terminal has a Powerline-patched font. 
""" See :help Airline for a list of UTF-8 symbols that help if Powerline fonts
""" aren't available.
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
""" Add the window number to the far left section of the status line.
""" Taken from https://github.com/vim-airline/vim-airline/wiki/Configuration-Examples-and-Snippets
function! WindowNumber(...)
    let builder = a:1
    let context = a:2
    call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
    return 0
endfunction
call airline#add_statusline_func('WindowNumber')
call airline#add_inactive_statusline_func('WindowNumber')
"
"" Rainbow
let g:rainbow_active = 1 " Use :RainbowToggle to turn it off/on in the editor.
let g:rainbow_conf = {
\    'guifgs': ['cyan4', 'darkorange3', 'seagreen3', 'firebrick'],
\    'seperately': {
\       'ruby': {
\           'parentheses': ['start=/do/ end=/end/ fold', 'start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\           'parentheses_options': ['containedin=rubyDoBlock'],
\           'after': ['syn clear rubyDoBlock']
\       }
\   }
\}

" CoC
"" Note: much of CoC's config is in its JSON file somewhere in the nvim
"" confdir.
set updatetime=300      " Supposedly this is good for UX
"" Have Vim rely on CoC for tag lookups
set tagfunc=CocTagFunc
"" Code navigation
nmap <silent> <space>d <Plug>(coc-definition)
nmap <silent> <space>D <Plug>(coc-declaration)
nmap <silent> <space>y <Plug>(coc-type-definition)
nmap <silent> <space>i <Plug>(coc-implementation)
nmap <silent> <space>r <Plug>(coc-references)
"" Function and keymap for previewing docstrings.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
"" Using CocList
""" Show all diagnostics
nnoremap <silent> <space>A  :<C-u>CocList diagnostics<cr>
""" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
""" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
""" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
""" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -A -I symbols<cr>
""" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
""" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
""" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"" Refactoring
""" Open refactor window for symbol under cursor with space-esc
nmap <space>  <Plug>(coc-refactor)
""" These bring up a menu of possible refactor operations on Visual-select
""" text or text under the cursor.
xmap <space>a  <Plug>(coc-codeaction-selected)
nmap <space>;  <Plug>(coc-codeaction-line)
""" Rename symbol under cursor
nmap <space>R <Plug>(coc-rename)
""" Format selection
xmap <space>f  <Plug>(coc-format-selected)
""" Format buffer
nmap <space>F  <Plug>(coc-format)
""" Run quickfix action on the current line
nmap <space>q  <Plug>(coc-fix-current)
""" Hide floating window
nmap <space>h  <Plug>(coc-float-hide)

" Vista.vim
"" How each level is indented and what to prepend.
"" This could make the display more compact or more spacious.
"" e.g., more compact: ["▸ ", ""]
"" Note: this option only works the LSP executives, doesn't work for `:Vista
"" ctags`.
"let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
"let g:vista#renderer#enable_icon = 1
"" Executive used when opening vista sidebar without specifying it.
"" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = "coc"
"let g:vista_echo_cursor_strategy = "floating_win"
"let g:vista_update_on_text_changed = 1
"let g:vista_update_on_text_changed_delay = 1000
nnoremap <silent><M-v> :Vista!!<CR>
nnoremap <silent><M-c> :Vista finder coc<CR>

"
"" NERDTree Configuration
"""Ignore .pyc files in NerdTree
"let NERDTreeIgnore=['\.pyc$', '\~$'] 
""" Open the browser with CTRL-n in normal mode
"nnoremap <C-n> :NERDTree<CR>

" Language-specific configs
"" Python
au BufRead,BufNewFile *.py set makeprg=python3\ -q\ %
     \ textwidth=79
"    \ textwidth=120 " ATC Projects use 120 -_- and i don't care right now
     \ fileformat=unix
     \ erroformat=\%*\\sFile\ \"%f\"\\,\ line\ %l\\,\ %m,\%*\\sFile\ \"%f\"\\,\ line\ %l
"     \ foldmethod=indent
"
"" C
""" Use GCC for both :make and :Neomake by default in C source files
"au BufNewFile,BufRead *.c:
au FileType c set makeprg=gcc\ -g\ -o\ %<\ %
"   \ | set tags+=~/.vim/systags
"   \ | let b:ale_linters = { 'c': ['clang'] }
    \ | nnoremap <F6> :!./%.exe
"
"" Rust
""" :makeprg is set automatically by rust.vim to `:!cargo`, but for the <F5>
""" binding to do what's expected we need to add the `build` arg to the
""" invocation.
au FileType rust nnoremap <F5> :make build<CR>:cw<CR>
    \ | nnoremap <F6> :make run<CR>:cw<CR>

"" Javascript/Typescript
""" Note: (this is in :help, but for easier reference)
""" `au!` deletes any existing autocmd for the pattern, then defines the given
""" new command. Here, I'm using the events BufNewFile and BufReadPost to
""" match the file extension and set the filetype in Vim. THEN, in a separate
""" command, I check the FileType value and match it, and ADD the command to
""" the list of defined commands (no deleting/resetting).
"au! BufNewFile,BufReadPost *.js set filetype=javascript
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab

"au! BufNewFile,BufReadPost *.ts set filetype=typescript
autocmd FileType typescript setlocal ts=2 sts=2 sw=2 expandtab
""" React
"au! BufNewFile,BufReadPost *.jsx set filetype=javascriptreact
autocmd FileType javascript.jsx setlocal ts=2 sts=2 sw=2 expandtab

"au! BufNewFile,BufReadPost *.tsx set filetype=typescriptreact
autocmd FileType typescript.tsx setlocal ts=2 sts=2 sw=2 expandtab

"" Go
au BufRead,BufNewFile *.go nnoremap <F5> :GoBuild

"" Yaml and Puppet
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

au! BufNewFile,BufReadPost *.pp set filetype=puppet
autocmd FileType puppet setlocal ts=2 sts=2 sw=2 expandtab

"" Securely edit gopass files
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
