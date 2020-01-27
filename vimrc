"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Endrit Bajo — @bajoz
"
" Sections:
"    -> Plugins
"    -> General
"    -> User interface
"    -> Colors and Fonts
"    -> Status line
"    -> Tab line
"    -> Maps: normal mode
"    -> Maps: visual mode
"    -> Maps: command-line mode
"    -> Maps: other
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Themes
Plug 'bajoz/minimo'

" Javascript
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

" Linting
Plug 'w0rp/ale'
  let g:ale_linters = {
  \   'typescript': ['tsserver', 'tslint'],
  \}
  let g:ale_fixers = {
  \   '*': ['remove_trailing_lines'],
  \   'javascript': ['prettier', 'eslint'],
  \   'typescript': ['prettier'],
  \}
  let g:ale_sign_error = '●'
  let g:ale_sign_warning = '▲'

" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Utils
Plug 'AndrewRadev/sideways.vim'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Enable filetype plugins
filetype plugin on
filetype indent on

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Enable true color support
set termguicolors

" Set to auto read when a file is changed from the outside
set autoread

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Set the text width for automatic word wrapping (Visual selection + gq)
set lbr
set tw=79

" Auto indent
set ai

" Smart indent
set si

" Wrap lines
set wrap

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the Wild menu
set wildmenu
set wildmode=full

" Ignore files
set wildignore=**/node_modules/**,*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Netrw
let g:netrw_banner = 0
autocmd FileType netrw set nolist

" Vertical split border style
set fillchars+=vert:\|

" Always show current position
set ruler

" Always show sign column
set signcolumn=yes

" Height of the command bar
set cmdheight=1

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Switch buffers without the need to save current file
set hidden

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Show hidden characters
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
set list

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

silent colorscheme minimo

" Color overrides
highlight ALEErrorSign guibg=NONE ctermbg=NONE
highlight ALEWarningSign guibg=NONE ctermbg=NONE

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%{expand('%:p:.')}        " path
set statusline+=%H\ %1M\ %1R\ %1W         " flags and buf no
set statusline+=%=%10((%l,%c)%)\          " line and column
set statusline+=%P                        " percentage of file
set statusline+=%<\                       " cut at end

""""""""""""""""""""""""""""""
" => Tab line
""""""""""""""""""""""""""""""
function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        let tabnr = i + 1 " range() starts at 0
        let winnr = tabpagewinnr(tabnr)
        let buflist = tabpagebuflist(tabnr)
        let bufnr = buflist[winnr - 1]
        let bufname = fnamemodify(bufname(bufnr), ':p:.')

        let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')

        let s .= '  '
        let s .= empty(bufname) ? '[No Name] ' : bufname . ' '

        let bufmodified = getbufvar(bufnr, "&mod")
        if bufmodified | let s .= '+ ' | endif
    endfor
    let s .= '%#TabLineFill#'
    return s
endfunction

set tabline=%!MyTabLine()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Maps: normal mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map alt keys
execute "set <M-j>=∆"
execute "set <M-k>=˚"
execute "set <M-h>=˙"
execute "set <M-l>=¬"

" Fast saving
nmap <leader>w :w!<cr>

" Reload buffer
nmap <leader>r :e!<cr>

" Edit files located in the same dir as the current file
nmap <leader>e :e <C-R>=expand("%:h") . "/" <CR>

" Autofix errors
nnoremap + :ALEFix<cr>

" Go to definition
nnoremap <leader>g :ALEGoToDefinition<cr>

" Move arguments order
nmap <M-l> :SidewaysRight<cr>
nmap <M-h> :SidewaysLeft<cr>

" Open Netrw
nmap <C-n> :Explore<cr>

" Search
nmap <Leader>t :GFiles<CR>
nmap <Leader>f :Ag 

" Show git diff
nmap <Leader>s :GFiles?<CR>

" Show open buffers
nmap <c-b> :Buffers<CR>

" Turn off highlighting
nmap <C-m> :nohl<CR>

" Switch CWD to the directory of the open buffer
nmap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
endif

" Quickly open a markdown buffer for scribble
nmap <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
nmap <leader>pp :setlocal paste!<cr>

" Insert timestamp at EOF
nmap <F3> Go<Esc>()dGo<Esc>0Do[<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>]<CR>
imap <F3> <Esc>Go<Esc>()dGo<Esc>0Do[<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>]<CR>

" Information about the highlighting group
nmap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Maps: visual mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Move a line of text using ALT+[jk] or Command+[jk] on mac
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Maps: command-line mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Movement in command line mode
function! EnterSubdir()
    call feedkeys("\<Down>", 't')
    return ''
endfunction
" Command-line mappings (<Tab>, <Down>, etc) aren't interpreted in wildmenu mode
cnoremap <expr> <C-j> EnterSubdir()
cnoremap <c-k> <Up>
cnoremap <c-h> <Left>
cnoremap <c-l> <Right>
cnoremap <c-a> <c-b>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Maps: other
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Esc to escape terminal mode
tnoremap <Esc> <C-\><C-n>

" Esc to close vim file explorer
autocmd FileType netrw nmap <silent> <buffer> <Esc> :bd<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save, useful for some filetypes ;)
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
