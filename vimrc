set nocompatible
filetype off "required

call plug#begin('~/.vim/plugged')

Plug 'udalov/kotlin-vim'
Plug 'leafgarland/typescript-vim'

Plug 'scrooloose/nerdtree'

"Plugin for git
Plug 'tpope/vim-fugitive'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  set pyxversion=3
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_PYTHON_LOG_LEVEL="DEBUG"

Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

Plug 'chromium/vim-codesearch'
let g:codesearch_source_root = '/home/yucwang/ruby/src/'

" All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required

"Some basic settings"
set guifont=Monaco:h14
"Do not use tab in vim editting"
set expandtab
set tabstop=2
set shiftwidth=2
set backspace=2
set cindent
set smartindent
set number
set showmatch
set ruler
set incsearch
set autoindent
set mouse=a
set hlsearch
set nowrapscan
set hidden
set list
set listchars=tab:\|\ 
set cursorline
set background=dark
set encoding=utf-8
set fenc=utf-8
set fileencodings=utf-8,gbk,cp936,latin-1
colorscheme molokai
 
syntax enable               
syntax on                    
filetype indent on           
filetype plugin on           
filetype plugin indent on
 
"Auto match"
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
:inoremap ` ``<ESC>i
:inoremap <c-v> <shift-insert>
 
"find the closest pair in the same line"
function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf
 
" TxtBrowser         
au BufRead,BufNewFile *.txt setlocal ft=txt
 
"Insert author name to the source file"
let g:vimrc_author='Yuchen Wang'
let g:vimrc_email='wyc8094@gmail.com'
let g:vimrc_homepage='aaron19960821.github.io'
 
" nt                 
map <C-l> :NERDTree<CR>
 
" tl                 
map tl :Tlist<CR><c-l>
 
 
func! CompileCode()
        exec "w"
        if &filetype == "c"
            exec "!gcc -Wall  -g %<.c -o %<"
        elseif &filetype == "cpp"
            exec "!g++ -Wall  -g %<.cpp -o %<"
        elseif &filetype == "cc"
            exec "!g++ -Wall  -g %<.cc -o %<"
        elseif &filetype == "java"
            exec "!javac %<.java"
        elseif &filetype == "haskell"
            exec "!ghc --make %<.hs -o %<"
        elseif &filetype == "lua"
            exec "!lua %<.lua"
        elseif &filetype == "perl"
            exec "!perl %<.pl"
        elseif &filetype == "python"
            exec "!python %<.py"
        elseif &filetype == "ruby"
            exec "!ruby %<.rb"
	elseif &filetype == "cs"
	    exec "!mcs %<.cs -debug"
        endif
endfunc
 
func! RunCode()
        exec "w"
        if &filetype == "c" || &filetype == "cpp" || &filetype == "haskell"
            exec "! %<.exe"
        elseif &filetype == "java"
            exec "!java %<"
        elseif &filetype == "lua"
            exec "!lua %<.lua"
        elseif &filetype == "perl"
            exec "!perl %<.pl"
        elseif &filetype == "python"
            exec "!python %<.py"
        elseif &filetype == "ruby"
            exec "!ruby %<.rb"
        endif
endfunc
 
map <c-c> :call CompileCode()<CR>
imap <c-c> <ESC>:call CompileCode()<CR>
vmap <c-c> <ESC>:call CompileCode()<CR>
 
map <c-r> :call RunCode()<CR>
imap <c-r> <ESC>:call RunCode()<CR>
vmap <c-r> <ESC>:call RunCode()<CR>

autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.swift,*.cs exec ":call SetTitle()"

func SetTitle() 
    if &filetype == 'sh' 
        call setline(1,"\#########################################################################") 
        call append(line("."), "\# File Name: ".expand("%")) 
        call append(line(".")+1, "\# Author: Yuchen Wang") 
        call append(line(".")+2, "\# mail: wyc8094@gmail.com") 
        call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
        call append(line(".")+4, "\#########################################################################") 
        call append(line(".")+5, "\#!/bin/bash") 
        call append(line(".")+6, "") 
    else 
        call setline(1, "/*************************************************************************") 
        call append(line("."), "    > File Name: ".expand("%")) 
        call append(line(".")+1, "    > Author: Yuchen Wang") 
        call append(line(".")+2, "    > Mail: wyc8094@gmail.com ") 
        call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
        call append(line(".")+4, " ************************************************************************/") 
        call append(line(".")+5, "")
    endif
    if &filetype == 'cpp' || &filetype == 'cc'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    autocmd BufNewFile * normal G
endfunc 

autocmd FileType python set omnifunc=pythoncomplete#Complete  
autocmd FileType javascrīpt set omnifunc=javascrīptcomplete#CompleteJS  
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags  
autocmd FileType css set omnifunc=csscomplete#CompleteCSS  
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags  
autocmd FileType php set omnifunc=phpcomplete#CompletePHP  
autocmd FileType c set omnifunc=ccomplete#Complete 

autocmd BufEnter *tex set sw =2
let g:tex_flavor ='latex'
