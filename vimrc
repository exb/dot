"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Endrit Bajo — @bajoz
"
" Sections:
"    -> Plugins
"    -> General
"    -> Commands mapping
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Tab line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')
" Themes
Plug '/Users/ebajo/playground/minimo'

" Javascript
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'

" Linting
Plug 'w0rp/ale'
  let g:ale_fixers = {
  \   '*': ['remove_trailing_lines'],
  \   'javascript': ['prettier', 'eslint'],
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

" Set text wrapping rules
set tw=79

" Enable filetype plugins
filetype plugin on
filetype indent on

" Enable true color support
set termguicolors

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

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

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Commands mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast saving
nmap <leader>w :w!<cr>

" Reload buffer
nmap <leader>e :e!<cr>

" Esc to escape terminal mode
tnoremap <Esc> <C-\><C-n>

" Esc to close vim file explorer
autocmd FileType netrw nmap <silent> <buffer> <Esc> :bd<cr>

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

" Autofix errors
nnoremap + :ALEFix<cr>

" Go to definition
nnoremap <leader>g :ALEGoToDefinition<cr>

" Move arguments order
nmap <M-l> :SidewaysRight<cr>
nmap <M-h> :SidewaysLeft<cr>

" Open Netrw
map <C-n> :Explore<cr>

" Search
nmap <Leader>t :GFiles<CR>
nmap <Leader>s :GFiles?<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Ag 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Set the text width for automatic word wrapping (Visual selection + gq)
set tw=79

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

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Color overrides
highlight ALEErrorSign guibg=NONE ctermbg=NONE
highlight ALEWarningSign guibg=NONE ctermbg=NONE

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>q :bdelete<cr>

" Close all the buffers
map <leader>qa :bufdo bd<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%{expand('%:p:.')}        " path
set statusline+=%H%M%R%W                 " flags and buf no
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
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
"nnoremap 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

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

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" a little more informative version of the above
nmap <Leader>I :call <SID>SynStack()<CR>

function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
