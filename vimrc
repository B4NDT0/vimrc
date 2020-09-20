

set nowrap
set number
set hlsearch
set clipboard=unnamedplus
filetype off                  " required

call plug#begin('~/.vim/plugged')
" Specify a directory for plugins call plug#begin('~/.vim/plugged')

Plug 'python-mode/python-mode'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'
Plug 'scrooloose/nerdtree'
Plug 'python-rope/ropevim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'plasticboy/vim-markdown'
Plug 'mgedmin/coverage-highlight.vim'
Plug 'vim-scripts/mako.vim'
Plug 'vim-scripts/vim-auto-save'
Plug 'tell-k/vim-autopep8'
Plug 'liuchengxu/space-vim-dark'
Plug 'neovimhaskell/haskell-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" To be removed
"Plug 'kien/ctrlp.vim'
"Plug 'jistr/vim-nerdtree-tabs'
"Plug 'godlygeek/tabular'
"Plug 'itchyny/lightline.vim'
"
" Front-end related plugins:
"Plug 'posva/vim-vue'
"Plug 'mattn/emmet-vim'
"Plug 'valloric/matchtagalways'

call plug#end()

syntax on
filetype plugin indent on    " required

" Using system's clipboard
set clipboard=unnamed

" Spell checking
setlocal spell spelllang=en_us
set nospell

" split and navigation
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=79
set colorcolumn=79


" Enable folding with the space bar
nnoremap <space> za
" you have changed me
set textwidth=200
set tabstop=4
set softtabstop=4
set autoindent
set cindent
set noexpandtab
set shiftwidth=4   
 
" PEP8
au BufNewFile,BufRead *.py  
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal textwidth=79 |
    \ setlocal expandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix

" yml
au BufReadPost *.yml set syntax=yaml
au BufNewFile,BufRead *.yml,*.yaml
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal shiftwidth=2 |
    \ setlocal textwidth=99 |
	\ setlocal colorcolumn=99 |
    \ setlocal expandtab |
    \ setlocal autoindent |


" js, css , HTML
au BufReadPost *.mak set syntax=html
au BufNewFile,BufRead *.js,*.html,*.css,*.vue
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal shiftwidth=2 |
    \ setlocal textwidth=99 |
	\ setlocal colorcolumn=99 |
    \ setlocal expandtab |
    \ setlocal autoindent |

" c
set cindent
au BufRead,BufNewFile *.c,*.h
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal textwidth=79 |
    \ setlocal autoindent |
    \ setlocal expandtab |
    \ setlocal fileformat=unix

" haskell
au BufRead,BufNewFile *.hs
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal textwidth=79 |
    \ setlocal autoindent |
    \ setlocal expandtab |
    \ setlocal fileformat=unix

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:haskell_classic_highlighting = 0

" Other (miscellaneous)
au BufRead,BufNewFile *.md,*.txt,*.rst
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal textwidth=79 |
    \ setlocal expandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" ignore files in NERDTree
let NERDTreeIgnore=['^data$', '\.pyc$', '\~$', '^__pycache__$', '\.egg-info$', '^build$', '^dist$', '\.so$', '\.o$'] 

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let g:NERDTreeGitStatusShowIgnored = 1

fun! NoseTestCurrentScope()
    " Find function under cursor
    let l:scope = ""
    let l:save = winsaveview()
    normal [[
    let l:class_matches = filter(matchlist(getline('.'), '\s*class \(\w*\)(.*'), 'v:val !=# ""')
    if len(l:class_matches) > 0
        let l:scope = l:class_matches[1]
    endif
    call winrestview(l:save)
    normal [m
    let l:func_matches = filter(matchlist(getline('.'), '\s*\(async\sdef|def\)\s\(test_[\w_]*\).*'), 'v:val !=# ""')
    if len(l:func_matches) > 1
        let l:scope = join([l:scope, l:func_matches[1]], '.')
    endif
    execute ':!nosetests -s --pudb %\:' . l:scope
    call winrestview(l:save)
endfun

let test#python#runner = 'nose2'


fun! PyTestCurrentScope()
    " Find function under cursor
    let l:scope = ""
    let l:save = winsaveview()
	for i in [1, 2, 3, 4, 5, 6, 7, 8, 9]
		normal [m
		let l:func_matches = matchlist(getline('.'), '\s*def \(test_\w*\)(.*')
		echo l:func_matches
        if len(l:func_matches) > 1
            let l:scope = l:func_matches[1]
			break
        endif
	endfor
	if len(l:scope) > 0	
		execute ':!pytest -vv ' . shellescape(@%, 1) . ' -k ' . l:scope
	endif
    call winrestview(l:save)
endfun

augroup python_test
    autocmd!
    autocmd Filetype python nnoremap <Leader>t :write<cr> :call PyTestCurrentScope()<CR>
augroup end

" Themes

"set termguicolors
colorscheme space-vim-dark
let g:space_vim_dark_background = 233
set background=dark
color space-vim-dark
"highlight Comment cterm=italic
"let g:solarized_termcolors=256
"let g:spacevim_enable_guicolors=0
"color dracula

" ColorColumn Color
hi ColorColumn guibg=#262626 ctermbg=235
hi Search cterm=NONE ctermfg=white ctermbg=darkblue

" Cursorline
set cursorline
highlight CursorLineNr ctermbg=0 ctermfg=6

" python-mode
" let g:pymode_virtualenv = 1
" let g:pymode_virtualenv_path = $VIRTUAL_ENV
" let g:pymode_run = 1
" let g:pymode_run_bind = '<leader>r'
" let g:pymode_breakpoint = 1
" let g:pymode_breakpoint_bind = '<leader>b'
" let g:pymode_python = 'python'
let g:pymode_breakpoint_cmd = 'from pudb import set_trace; set_trace()'
let g:pymode_python = 'python3'

" Rope
let g:pymode_rope = 1

" Lint
" Lint is activated to fix pep8 errors
let g:pymode_lint = 1
let g:pymode_lint_on_write = 1
let g:pymode_lint_checkers = ['pep8', 'pep257']

"change parameters to open go to definition in vertical splited window
"possible parameters are 'e', 'new', 'vnew
let g:pymode_rope_goto_definition_cmd = 'new'
let g:pymode_rope_organize_imports_bind = '<Leader>q'
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 1
let g:pymode_rope_autoimport = 1
let g:pymode_rope_rename_bind = '<C-c>rr'

set completeopt=longest,menuone
let ropevim_vim_completion=1
let ropevim_extended_complete=1
map <C-]> <C-C>g
map <Leader>i <C-c>ro

" Bash aliases
"set shellcmdflag=-ic
let $BASH_ENV = "~/.bash_aliases"


" Python code comment
vnoremap <silent> # :s/^/#/<cr>:noh<cr>
vnoremap <silent> -# :s/^#//<cr>:noh<cr>

nnoremap <Leader>c :HighlightCoverage<CR>
autocmd FileType python nnoremap <buffer> <F9> :write<cr> :exec '!python3' shellescape(@%, 1)<cr>
autocmd FileType python nnoremap <buffer> <F8> :write<cr> :exec '!pytest -vvv' shellescape(@%, 1)<cr>
autocmd FileType python nnoremap <buffer> <F7> :write<cr> :exec '!P=`basename $(pwd)`; py.test --cov=$P tests'<cr>
"autocmd FileType python nnoremap <buffer> <F7> :write<cr> :exec '!P=`basename $(pwd)`; py.test --cov=$P $P/tests'<cr>
noremap <F10> :write<cr> :exec '!coverage run --source $(python3 -c "from setuptools import find_packages; print(find_packages()[0])") $(which nosetests)'<cr>

" autocmd FileType python,*.pyx nnoremap <Leader>B :exec '!python setup.py build_ext --force --inplace --define=CYTHON_TRACE'<cr>
nnoremap <Leader>B  :write<cr> :exec '!python3 setup.py build_ext --force --inplace --define=CYTHON_TRACE'<cr>
nnoremap <Leader>m  :write<cr> :exec '!make'<cr>
nnoremap <Leader>f  :write<cr> :exec '!make flash'<cr>
autocmd FileType python,*.pyx nnoremap <Leader>l :PymodeLintAuto <cr>
autocmd Filetype python,*.pyx nnoremap <Leader>8 :Autopep8 <cr>

let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_no_updatetime = 1  " do not change the 'updatetime' option
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
autocmd InsertLeave * write

set t_Co=256

" Double o within 1 second to insert new line and back to normal mode.
nmap oo o<Esc>

" Added sopport for HTML (and other languages) matching tags with %
runtime macros/matchit.vim

" Press Leader+Space to turn off highlighting and clear any message already displayed.
nnoremap <Leader><Space> :nohlsearch<Bar>:echo<CR>

" PEP8
let g:autopep8_max_line_length=79

" NERDTree costomization
" Quite NerdTree when closing the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeAutoDeleteBuffer = 1
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:NERDTreeWinSize=22

" Vim slow scrolling
set lazyredraw
set synmaxcol=160
syntax sync minlines=256

" Paste multiple times
xnoremap p pgvy

" Open new tab
nnoremap <C-t> <esc>:tabnew<CR>

" Close current tab
nnoremap <C-y> <esc>:tabclose<CR>

" Using local config. Uncomment line below. 
"source ~/.vimrc-local


