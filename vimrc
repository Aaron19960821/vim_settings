set nocompatible
filetype off "required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" alternatively, pass a path where Vundle should install plugins
"

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'toyamarinyon/vim-swift'
Bundle 'gmarik/vundle'
Plugin 'artur-shaik/vim-javacomplete2'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

let g:OmniSharp_host = "http://localhost:2000"
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

"Some basic settings"
set guifont=Monaco:h14
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
 
syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on    " 启用自动补全
 
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
 
" nt                  打开NERDTree [非插入模式]
map <C-l> :NERDTree<CR>
 
" tl                  打开Taglist [非插入模式]
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


"进行Tlist的设置
"TlistUpdate可以更新tags
map <F3> :silent! Tlist<CR> "按下F3就可以呼出了
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
let Tlist_Use_Right_Window=1 "让窗口显示在右边，0的话就是显示在左边
let Tlist_Show_One_File=0 "让taglist可以同时展示多个文件的函数列表，如果想只有1个，设置为1
let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
let Tlist_Process_File_Always=0 "是否一直处理tags.1:处理;0:不处理。不是一直实时更新tags，因为没有必要
let Tlist_Inc_Winwidth=0


