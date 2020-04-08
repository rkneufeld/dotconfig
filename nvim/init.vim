" Plugins to explore:
"
" - vim-test
" - UltiSnips // other snippet plugin
" - vim-dispatch
"
call plug#begin('~/.local/share/site/autoload/plug.vim')

" Editor Style
Plug 'nanotech/jellybeans.vim' " Preferred theme
Plug 'vim-airline/vim-airline' " Status line
Plug 'vim-airline/vim-airline-themes' " Themes for airline

" General Editing
Plug 'godlygeek/tabular', {'on': 'Tabularize'}  " Align blocks of text
Plug 'jiangmiao/auto-pairs' " Automatically complete pairs
Plug 'mileszs/ack.vim' " Search with :Ack
Plug 'tpope/vim-commentary' " Comment out with gc.* commands
Plug 'tpope/vim-endwise' " Add end and other language-aware completions for fn syntax
Plug 'tpope/vim-repeat' " Support repeat for plugins
Plug 'tpope/vim-surround' " Manage delimiters (ys)
Plug 'tpope/vim-projectionist' " Move to related files easily using :E*

" Language Support
Plug 'tpope/vim-markdown', {'for': 'markdown'} " .md support

"" Lisps
Plug 'guns/vim-sexp', { 'for': 'clojure' } " S-expression text-objects and manipulations
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' } " Better bindings for vim-sexp
Plug 'luochen1990/rainbow', { 'for': 'clojure' } " Rainbow parentheses

" Clojure plugins
Plug 'liquidz/vim-iced', {'for': 'clojure'}


" Utilities
Plug 'gcmt/taboo.vim' " Vim :tabe manager
Plug 'tpope/vim-eunuch' " Unix utilities
Plug 'svermeulen/vim-easyclip' 

"" Navigation Utilities
Plug 'scrooloose/nerdtree', {'on': ['NERDTree','NERDTreeToggle']} " Tree-based directory viewer

"" Git Utilities
Plug 'airblade/vim-gitgutter' " Git status in gutter

" Neovim Plugins
Plug 'w0rp/ale' " Async linting engine. Use w/ joker 

" Search & Completions
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

" Editor Style  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme jellybeans
set background=dark

set laststatus=2  " always show the status bar

let g:airline_powerline_fonts = 1
let g:airline_theme='badcat'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#neomake#enabled=0

" Editor Config """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set directory=/tmp/
set encoding=utf-8
set showcmd                     " display incomplete commands
set list
set listchars=""
set listchars+=tab:▸\ 
set listchars+=trail:·
set listchars+=extends:>
set listchars+=precedes:<

" set wildignore+=target,*.jar,*.class,ivyrepo
" set wildignore+=*.so,*.swp,*.zip,*.un~,.DS_Store,.gitkeep,*/vendor/*,.*,*/coverage/*,*.pyc

set foldlevelstart=99
set number                         " Show numbers gutter
set numberwidth=3                  " Numbers gutter 3 cols wide
set ruler       " show the cursor position all the time
set cursorline
set scrolloff=3
set scrolljump=8
set shortmess=atI
set lazyredraw

set comments+=fb:*              " Make bullet lists reflow nicely

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

""" Strip all trailing whitespace, but not this vim files
augroup striptrailing
  autocmd!
  autocmd BufWritePre * if &ft != "vim" | :%s/\s\+$//e
augroup END

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set gdefault                    " Always assume /g on substitutions

"" Splits
set splitbelow
set splitright

set mouse=a " Enable mouse events (scrolling), particularly over tmux+iTerm2

if v:version >= 703
  set undofile
  let &undodir=&directory
endif

" Clojure """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" See also after/ftplugin/clojure.vim

let g:rainbow_active = 1

augroup cljautopairs
  autocmd!
  au FileType clojure let b:AutoPairs = {'(':')','{':'}',"'":"'",'"':'"', '[':']'}
augroup END

" Status Line """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

" nnoremap <C-n> :call NumberToggle()<cr>

augroup numbering
  autocmd!
  autocmd FocusLost * :set number
  autocmd FocusGained * :set relativenumber
  autocmd InsertEnter * :set number
  autocmd InsertLeave * :set relativenumber
  autocmd CursorMoved * :set relativenumber
augroup END

" Remember last location in file, but not for commit messages.
" see :help last-position-jump
augroup lastposnjump
  autocmd!
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g`\"" | endif
augroup END

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Keybindings """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = " "
let maplocalleader = " "

"" No help please
nmap <F1> <Esc>
nmap <F1> <nop>

"" easier navigation between split windows
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l
tnoremap <c-h> <C-\><C-N><C-w>h
tnoremap <c-j> <C-\><C-N><C-w>j
tnoremap <c-k> <C-\><C-N><C-w>k
tnoremap <c-l> <C-\><C-N><C-w>l
inoremap <c-h> <C-\><C-N><C-w>h
inoremap <c-j> <C-\><C-N><C-w>j
inoremap <c-k> <C-\><C-N><C-w>k
inoremap <c-l> <C-\><C-N><C-w>l
nnoremap <c-h> <C-w>h
nnoremap <c-j> <C-w>j
nnoremap <c-k> <C-w>k
nnoremap <c-l> <C-w>l

"" Add some nice short cuts for tab swapping
nnoremap <silent> <Leader>N :tabnext<CR>
nnoremap <silent> <Leader>P :tabprevious<CR>

"" Reselect visual block after indent/outdent - vimbits.com/bits/20
vnoremap < <gv
vnoremap > >gv

"" Rename current file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

map <leader>mv :call RenameFile()<cr>

command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>
map <leader>ws :call KillWhitespace

"" Search Assistance

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  let g:ackprg = 'rg --vimgrep --no-heading'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Ctrl-N and Ctrl-P navigate history
let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_command_prefix = 'Fzf' 

let g:fzf_layout = { 'down': '~30%' }

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap <silent> <Leader>p :FZF<CR>
nnoremap <silent> <Leader>a :Ag<CR>

nnoremap <silent> <leader>c :ccl<CR>

"" Git
" See also after/ftplugin/git{commit,rebase}.vim

let g:gitgutter_map_keys = 0

nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk


nmap <leader>l :set list!<CR>
nmap <leader>w :set wrap!<CR>
command! -nargs=* Wrap set wrap linebreak nolist

nnoremap <Leader>m m

set hidden
let g:iced_enable_default_key_mappings = v:true
nmap <buffer> cp <Plug>(iced_eval)


