map <c-e> :q<CR>:q<CR>:q<CR>
map <F5> :call g:Jsbeautify()<CR>
set nocompatible          " We're running Vim, not Vi!
syntax on                 " Enable syntax highlighting
" call pathogen#runtime_append_all_bundles()
call pathogen#infect()
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

let g:solarized_termtrans=1
let g:solarized_termcolors=256
syntax enable
set background=light
" colorscheme solarized
" colorscheme pablo
" colorscheme desert
colorscheme solarized

" set cursorline


" Highlight trailing whitespace etc
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocm ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

let mapleader = ";"
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
" let g:CommandTMaxHeight=20
" let g:NERDSpaceDelims=1
" nmap <leader>t :CommandT<CR>
" nmap <leader>T :CommandTFlush<CR>:CommandT<CR>
nmap <leader>t :CtrlP<CR>

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

augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()
augroup END

map <leader>y "*y
nnoremap <leader><leader> <c-^>

cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') || match(current_file, '\<helpers\>') != -1

  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end

    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction

nnoremap <leader>. :call OpenTestAlternate()<cr>

" map <leader>t :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
map <leader>a :call RunTests('')<cr>
map <leader>c :w\|:!script/features<cr>
map <leader>w :w\|:!script/features --profile wip<cr>

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif
    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction


function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number . " -b")
endfunction


function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction


function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w

    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature$') != -1
        exec ":!script/features " . a:filename
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec --color " . a:filename
        else

            exec ":!rspec --color " . a:filename
        end
    end
endfunction

noremap <c-l> <c-l>:syntax sync fromstart<CR>
inoremap <c-l> <esc><c-l>:syntax sync fromstart<CR>a
map <leader>r :NERDTreeFind<cr>
nmap <leader>g :let @/="\\<<C-R><C-W>\\>"<CR>:set hls<CR>:silent Ggrep -w "<C-R><C-W>"<CR>:ccl<CR>:copen20<CR><c-w>K<CR><cr><c-l><c-l>
vmap <leader>g y:let @/=escape(@", '\\[]$^*.')<CR>:set hls<CR>:silent Ggrep -F "<C-R>=escape(@", '\\"#')<CR>"<CR>:ccl<CR>:copen20<CR><c-w>K<CR><cr><c-l><c-l>
let g:Powerline_symbols = 'fancy'
function! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfunction
map <Leader>vp :VimuxPromptCommand<CR>
vmap <Leader>vs "vy :call VimuxSlime()<CR>

