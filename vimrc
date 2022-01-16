"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: Endrit Bajo — @exb
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'exb/minimo'
Plug 'arzg/vim-colors-xcode'

" Javascript
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'sheerun/vim-wombat-scheme'
Plug 'wojciechkepka/vim-github-dark'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
  let g:prettier#exec_cmd_async = 1

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=500 " Sets how many lines of history VIM has to remember
set encoding=utf8 " Set utf8 as standard encoding and en_US as the standard language
filetype plugin on
filetype indent on
set ffs=unix,dos,mac " Use Unix as the standard file type
set autoread " Set to auto read when a file is changed from the outside
set nobackup " Turn backup off, since most stuff is in SVN, git et.c anyway...
set nowb
set noswapfile
set expandtab " Use spaces instead of tabs
set smarttab
set shiftwidth=4 " 1 tab == 4 spaces
set tabstop=4
set lbr
set tw=79 " Set the text width for automatic word wrapping (Visual selection + gq)
set ai " Auto indent
let mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu " Turn on the Wild menu

" Ignore files
set wildignore=*/node_modules/*,*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" Netrw
let g:netrw_banner = 0
autocmd FileType netrw set nolist

" Do not map enter inside quickfix list
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

set ruler " Always show current position
set number " Always show line number
set cmdheight=1 " Height of the command bar

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set backspace=2

set ignorecase " Ignore case when searching
set smartcase " When searching try to be smart about cases 
set hlsearch " Highlight search results
set hidden " Switch buffers without the need to save current file
set incsearch " Makes search act like search in modern browsers
set lazyredraw " Don't redraw while executing macros (good performance config)
set magic " For regular expressions turn magic on
set showmatch " Show matching brackets when text indicator is over them
set mat=2 " How many tenths of a second to blink when matching brackets

" Show hidden characters
" set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
" set list

" Specify the behavior when switching between buffers 
" try
"   set switchbuf=useopen,usetab,newtab
"   set stal=2
" catch
" endtry
" set showtabline=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable 

silent color minimo

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Maps: normal mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast saving
nmap <leader>w :w!<cr>

" Reload buffer
nmap <leader>r :e!<cr>

" Edit files located in the same dir as the current file
nmap <leader>e :e <C-R>=expand("%:h") . "/" <CR>

" Autofix errors
nnoremap + :PrettierAsync<cr>

" Go to definition
nnoremap <leader>g gf<cr>

" Replace occurence
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Open Netrw
nmap <C-n> :Explore<cr>

" Switch CWD to the directory of the open buffer
nmap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Toggle paste mode on and off
nmap <leader>pp :setlocal paste!<cr>

" Insert timestamp at EOF
nmap <F3> Go<Esc>()dGo<Esc>0Do[<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>]<CR>
imap <F3> <Esc>Go<Esc>()dGo<Esc>0Do[<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>]<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Maps: other
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Esc to close vim file explorer
autocmd FileType netrw nmap <silent> <buffer> <Esc> :bd<cr>

" Format js files on save
" autocmd BufWritePost *.js PrettierAsync

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Project specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path+=src/**
set path+=nerdlets/**
set path+=common/**
set path+=components/**
