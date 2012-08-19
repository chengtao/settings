map <c-e> :q<CR>:q<CR>:q<CR>
map <F5> :call g:Jsbeautify()<CR>
set nocompatible          " We're running Vim, not Vi!
syntax on                 " Enable syntax highlighting
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

augroup myfiletypes
" Clear old autocmds in group
autocmd!
" autoindent with two spaces, always expand tabs
autocmd FileType ruby,c,eruby,yaml set ai sw=2 sts=2 et
augroup END

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

set tabstop=2
set shiftwidth=2
set expandtab
set incsearch
set autoread
set showcmd
set ic                                " Ignore case in search
" set nu                                " Always with the line numbers
set hlsearch
set bs=2
:let g:netrw_browse_split = 3

au BufRead,BufNewFile *.thrift set filetype=thrift
au! Syntax thrift source ~/.vim/thrift.vim

let arc_rainbow=1
au BufRead,BufNewFile *.arc set filetype=arc
au! Syntax arc source ~/.vim/arc.vim

autocmd! bufwritepost .vimrc source ~/.vimrc

" kill help (I'm sure there's a bitter way to do this)
map <F1> lh
map <F2> :set

" lisp
map <F10> 99[(=%<%
map <C-l>( 99[(
map <C-l>) 99])

map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h

set autowrite
set nowritebackup
set guioptions-=T " no toolbar

syntax enable
set background=dark
" colorscheme solarized
" colorscheme pablo
colorscheme desert

" set cursorline


" Highlight trailing whitespace etc
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocm ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" Strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" my split windows will <3 you so much
" set colorcolumn=80
" ... in case that's ugly with your setup you can change the color
" highlight ColorColumn ctermbg=green guibg=orange

" An alternative option (I don't use)
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

cnoremap %% <C-R>=expand('%:h').'/'<cr>
let mapleader = ";"
map <leader>e :edit %%
map <leader>v :view %%
nnoremap <leader><leader> <c-^> " go to previous location
map <leader>nt :NERDTree<CR>

imap <Nul> <Esc>:w<CR>
:set mouse=a

" Underline when searching
highlight Search cterm=underline

" Commenting
vmap o :s/^/# /<CR>
vmap i :s/^# //<CR>

" Xavier's special needs
set wildmode=longest,list,full
set wildmenu
imap <Nul> <Esc>:w<CR>
set mouse=a
"set colorcolumn=80
highlight ColorColumn ctermbg=7

" Command-T
let g:CommandTMaxHeight=20
let g:NERDSpaceDelims=1

nmap <leader>t :CommandT<CR>
nmap <leader>T :CommandTFlush<CR>:CommandT<CR>

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne=1000


"func GitGrep(...)
"  let save = &grepprg
"  set grepprg=git\ grep\ -n\ $*
"  let s = 'grep'
"  for i in a:000
"    let s = s . ' ' . i
"  endfor
"  exe s
"  let &grepprg = save
"endfun
"command -nargs=? G call GitGrep(<f-args>)
"
"func GitGrepWord()
"  normal! "zyiw
"  call GitGrep('-w -e ', getreg('z'))
"endf
"nmap <C-x>G :call GitGrepWord()<CR>



"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

