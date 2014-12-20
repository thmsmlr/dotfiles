"""""""""""""""""""
" Vundle Packages "
"""""""""""""""""""

" Type :BundleInstall to install everything.

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" My Bundles

" Helps me deal with Git
Bundle 'tpope/vim-fugitive'

" Helps me move
Bundle 'kien/ctrlp.vim'

" Extends % operator to match html tags.
Bundle 'tmhedberg/matchit'

" Helps me search
Bundle 'mileszs/ack.vim'
Bundle 'nelstrom/vim-visual-star-search'

" Helps me align things
Bundle 'godlygeek/tabular'

" Helps me comment "
Bundle 'tpope/vim-commentary'

" Helps me work with tmux
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'jgdavey/tslime.vim'

" Helps me work with Pig
Bundle 'motus/pig.vim'

" Helps me write HTML
Bundle 'tristen/vim-sparkup'

" Required!
call vundle#end()
filetype plugin indent on
syntax on

let mapleader = ","

"""""""""""""""
" Preferences "
"""""""""""""""

" Set 256 ANSI Colors
let &t_Co=256
:color sunburst

" enable syntax highlighting
syntax enable

" Set hightlight color for terminal
hi Search cterm=underline ctermfg=white ctermbg=black

set autoindent
" reload files when changed on disk, i.e. via `git checkout`
set autoread

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" yank and paste with the system clipboard
set clipboard=unnamed

set encoding=utf-8

" expand tabs to spaces
set expandtab

" search as you type
set incsearch

" Highlight all occurrences of a search
set hlsearch

" case-insensitive search
set ignorecase

" always show statusline
set laststatus=2

" show trailing whitespace
set list
set listchars=tab:▸\ ,trail:▫

" show line numbers
set number

" show where you are
set ruler

" show context above/below cursorline
set scrolloff=3

" normal mode indentation commands use 2 spaces
set shiftwidth=2

" Display incomplete commands
set showcmd

" Make rvm work in vim for whatever reason
set shell=bash

" case-sensitive search if any caps
set smartcase

" insert mode tab and backspace use 2 spaces
set softtabstop=2

" actual tabs occupy 8 characters
set tabstop=4

" show a navigable menu for tab completion
set wildmenu
set wildmode=longest,list,full

" minimum split width
set winwidth=100

" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase

" Fix escape delay
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

filetype plugin indent on

"Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Set files to ignore
set wildignore+=*.pdf,*/tmp/*,*.so,*.swp,*.zip,*/bin/*,*.pyc,*/bundle/*,*/node_modules/*,*/bower_components/*,*/*.egg/*,*/*.egg-info*/*

" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.hbs set filetype=html
autocmd BufRead,BufNewFile *.eex set filetype=html

"Easier movement around the page
noremap <C-j> 3<C-e>
noremap <C-k> 3<C-y>
noremap <S-j> 3j
noremap <S-k> 3k
noremap <S-l> 5l
noremap <S-h> 5h
noremap <C-w> :q<CR>
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
map 0 ^
nmap <leader>s :w<CR>
nmap <leader>f :Ack
nmap <leader>b :CtrlPBuffer<CR>
nmap <C-p> :CtrlP<CR>
nmap <leader><space> :call whitespace#strip_trailing()<CR>
nmap <leader>g :GitGutterToggle<CR>
nmap <leader>c gcc
vmap <leader>c gc
vmap <leader>a= :Tabularize /=<CR>
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Custom Characters
imap <C-\> λ

" plugin Settings
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window = 'order:ttb,max:20'
let g:ctrlp_arg_map = 't'
let g:gitgutter_enabled = 0
let g:Powerline_symbols = 'fancy'

" Use vim wildignore with ctrlp user command and The Silver Searcher
function! s:wig2cmd()
  " Change wildignore into space or | separated groups
  " e.g. .aux .out .toc .jpg .bmp .gif
  " or   .aux$\|.out$\|.toc$\|.jpg$\|.bmp$\|.gif$
  let pats = ['\**\([?_.0-9A-Za-z]\+\)\([*\/]*\)\(\\\@<!,\|$\)','\\\@<!,']
  let subs = ['\1\2\3', '\\|']
  let expr = substitute(&wig, pats[0], subs[0], 'g')
  let expr = substitute(expr, pats[1], subs[1], 'g')
  let expr = substitute(expr, '\\,', ',', 'g')

  " Set the user_command option
  " let g:ctrlp_user_command = 'ag %s -f -l --nocolor -g "" | grep -v -p "'. expr .'"'
  " let g:ctrlp_user_command = 'find %s -type f'
  let g:ctrlp_user_command = 'cd %s && ag . -f -l --nocolor | grep -v -p "' . expr . '"'
endfunction

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --nogroup --column -f'
  let g:ctrlp_user_command = 'cd %s && ag . -f -l --nocolor'

  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor\ -f

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " call s:wig2cmd()
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Align Stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! EasyTabularize()
    call inputsave()
    let key = input('Enter align token: ')
    call inputrestore()
    let m = mode(1)
    if m == 'n'
      execute "Tabularize /" . key . ".*/"
    else
      execute ":'<,'> Tabularize /" . key . ".*/"
    end
endfunction

nmap <leader>a :call EasyTabularize()<cr>
vmap <leader>a :call EasyTabularize()<cr>


" Manually source custom plugins
source ~/.vim/whitespace/plugin/whitespace.vim
