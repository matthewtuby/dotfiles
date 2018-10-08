"shiny vim colors even when using tmux
set term=xterm-256color
colorscheme torte 

"plugin that detects filetpye
filetype plugin on

"line numbering
set nu

"clickable vim
set mouse=a

"syntax highlight
syntax on

"tabs be equal 4 space  
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

"statusline
set laststatus=2

"function! CurrentGitStatus()
"    let gitoutput = system('git status --show-current')
"    if stridx(gitoutput, "fatal: not a git repository") != -1
"        return ""
"    else
"        return gitoutput
"    endif
"endfunc

set statusline=
set statusline+=%#Identifier#
"set statusline=%{CurrentGitStatus()}
set statusline+=%#Question#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#WildMenu#
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

"autocomplete ctrl+n
set omnifunc=syntaxcomplete#Complete

"spellcheck
map <F4> :setlocal nospell <CR>
map <F5> :setlocal spell spelllang=en <CR>
map <F6> :setlocal spell spelllang=hu <CR>

"compilers
autocmd FileType cpp map <F7> :w <bar> :!clear ; g++ --std=c++17 -O3 -Wall -Wextra -Wdeprecated -pedantic % && ./a.out ; rm a.out <CR>
autocmd FileType cpp map <F8> :w <bar> :!clear ; g++ --std=c++17 -Wall -Wextra -Wdeprecated -pedantic -fno-elide-constructors -g % && ./a.out ; rm a.out <CR>
autocmd FileType cpp map <F9> :w <bar> :!clear ; g++ --std=c++17 -w -g % && valgrind --leak-check=full -v ./a.out; rm a.out<CR>
autocmd FileType tex map <F8> :w <bar> :!clear ; pdflatex % && pdflatex % && biber %<.bcf && pdflatex % && pdflatex % && pdflatex % ; rm %<.aux %<.bbl %<.bcf %<.blg %<.lof %<.log %<.lot %<.out %<.run.xml %<.toc %<.fls %<.fdb_latexmk <CR>
autocmd FileType python map <F8> :w <bar> !clear ; python3 % <CR>
autocmd FileType r map <F8> :w <bar> !clear ; Rscript % <CR>
autocmd FileType sh map <F8> :w <bar> !clear ; ./% <CR>

"no arrows in interactive mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
