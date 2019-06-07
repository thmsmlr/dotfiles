"""""""""""""""""""
" plug Packages "
"""""""""""""""""""

" Type :PlugInstall to install everything.

call plug#begin()

" Helps me deal with Git
Plug 'tpope/vim-fugitive'

" Helps me move
Plug 'kien/ctrlp.vim'

" Extends % operator to match html tags.
Plug 'tmhedberg/matchit'

" Helps me search
Plug 'mileszs/ack.vim'
Plug 'nelstrom/vim-visual-star-search'

" Helps me align things
Plug 'godlygeek/tabular'

" Helps me comment "
Plug 'tpope/vim-commentary'

" Helps me work with tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'jgdavey/tslime.vim'

" Helps me write HTML
Plug 'tristen/vim-sparkup'

" Helps with indentation in Javascript
Plug 'pangloss/vim-javascript'

" Helps with indentation in Javascript
Plug 'dag/vim-fish'

" Required!
call plug#end()

let mapleader = ","

"""""""""""""""
" Preferences "
"""""""""""""""

" Set 256 ANSI Colors
let &t_Co=256
:color Sunburst

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

" Allow mouse scrolling
set mouse=nicr

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

autocmd BufWritePost *.py silent! execute '!bash ~/.vim/run-yapf %' | redraw

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
" nmap <leader>b :CtrlPBuffer<CR>
" nmap <C-p> :CtrlP<CR>
nmap <leader><space> :call whitespace#strip_trailing()<CR>
nmap <leader>g :GitGutterToggle<CR>
nmap <leader>c gcc
vmap <leader>c gc
vmap <leader>a= :Tabularize /=<CR>
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
map <silent> <leader>C :CtrlPClearAllCaches<CR>:exe ":echo 'CtrlPCache reset'"<CR>
map ,T :map ,t :!

" Custom Characters
imap <C-\> λ

set timeoutlen=500
set ttimeoutlen=500

" plugin Settings
" let g:ctrlp_working_path_mode = 0
" let g:ctrlp_match_window = 'order:ttb,max:20'
" let g:ctrlp_arg_map = 't'
let g:gitgutter_enabled = 0
let g:Powerline_symbols = 'fancy'

if executable('ag')
  " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast, respects .gitignore
  " and .agignore. Ignores hidden files by default.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -f -g ""'
else
  "ctrl+p ignore files in .gitignore
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
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


" For editing crontabs
autocmd filetype crontab setlocal nobackup nowritebackup
