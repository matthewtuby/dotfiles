"shiny vim colors even when using tmux
set term=xterm-256color
colorscheme torte

"line numbering
set nu

"clickable vim
set mouse=a

"switch cursor between modes
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[3 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

"tabs be equal 4 space
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

"show invisibles
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅

" NERD_tree config
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '\.swp$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <F3> :NERDTreeToggle<CR>
"au VimEnter *  NERDTree
"autocmd VimEnter * wincmd w

"remove white space on save
autocmd BufWritePre * :%s/\s\+$//e
"linting
"let g:ale_linters = {
"\    'python': ['flake8', 'pylint', 'bandit', 'mypy'],
"\   'sh': ['bashate','shell'],
"\   'dockerfile': ['hadolint','dockerfile_lint'],
"\   'tex': ['hadolint','dockerfile_lint']}
"
"let g:ale_fixers = {
"\   '*': ['remove_trailing_lines', 'trim_whitespace'],
"\   'python': ['black','isort']}
"
"let g:ale_fix_on_save = 1
"let g:ale_lint_on_save = 1
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_insert_leave = 0
"let g:ale_lint_on_enter = 0

"autocomplete tab and it's wrapper
"set omnifunc=syntaxcomplete#Complete
"function! InsertTabWrapper()
"    let col = col('.') - 1
"    if !col || getline('.')[col - 1] !~ '\k'
"        return "\<tab>"
"    else
"        return "\<c-p>"
"    endif
"endfunction
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" Viewport Controls
" ie moving between split panes
map <silent>,h <C-w>h
map <silent>,j <C-w>j
map <silent>,k <C-w>k
map <silent>,l <C-w>l

"plugin that detects filetpye
filetype plugin indent on

"syntax highlight
syntax on

"file specific auto runs
au FileType py set autoindent
au FileType py set smartindent
au FileType py set textwidth=79 " PEP-8 Friendly

"statusline
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction
set laststatus=2
set statusline=
set statusline+=%#Identifier#
set statusline+=%#Question#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#WildMenu#
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
"set statusline+=\ %{LinterStatus()}
set statusline+=\ %p%%

"spellcheck
map <F4> :setlocal nospell <CR>
map <F5> :setlocal spell spelllang=en <CR>
map <F6> :setlocal spell spelllang=hu <CR>

"""""""""""
"compilers"
"""""""""""
"CPP
"F7 hella optimized
"F8 not optimized
"F9 check for leaks
autocmd FileType cpp map <F7> :w <bar> :!clear ; g++ --std=c++17 -O3 -Wall -Wextra -Wdeprecated -pedantic % && ./a.out ; rm a.out <CR>
autocmd FileType cpp map <F8> :w <bar> :!clear ; sudo g++ --std=c++17 -Wall -Wextra -Wdeprecated -pedantic -fno-elide-constructors -g % && sudo ./a.out ; rm a.out <CR>
autocmd FileType cpp map <F9> :w <bar> :!clear ; g++ --std=c++17 -w -g % && valgrind --leak-check=full -v ./a.out; rm a.out<CR>

"LATEX
autocmd FileType tex map <F8> :w <bar> :!clear ; pdflatex % && pdflatex % && biber %<.bcf && pdflatex % && pdflatex % && pdflatex % ; rm %<.aux %<.bbl %<.bcf %<.blg %<.lof %<.log %<.lot %<.out %<.run.xml %<.toc %<.fls %<.fdb_latexmk <CR>

"BEAMER
autocmd FileType markdown map <F8> :w <bar> :!clear ; pandoc % -t beamer -o presentation.pdf <CR>

"PYTHON
autocmd FileType python map <F8> :w <bar> !clear ; python3 % <CR>
autocmd BufWritePost *.py execute ':Black'

"R
autocmd FileType r map <F8> :w <bar> !clear ; Rscript % <CR>

"BASH
autocmd FileType sh map <F8> :w <bar> !clear ; ./% <CR>

"vyper
autocmd FileType sh map <F8> :w <bar> !clear ; vyper ./% <CR>

call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'ambv/black' ,{'for':'python'}
    Plug 'tomlion/vim-solidity'
    Plug 'vyperlang/vim-vyper'
    Plug 'neomake/neomake'
    "Plug 'vim-syntastic/syntastic'
call plug#end()

"call neomake#configure#automake('w')
"call neomake#configure#automake('rw', 1000)
call neomake#configure#automake('nrwi', 500)
