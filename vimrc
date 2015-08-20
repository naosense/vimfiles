" 我的GVim配置文件
" 作者：Hi卡文迪什
" 第4行到32行为原始的vimrc文件
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" if has("vms")
set nobackup		" do not keep a backup file, use versions instead
" else
"  set backup		" keep a backup file
" endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""               我的个性化配置                    """"""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置编码，解决中文乱码问题
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
if has("win32")
set fileencoding=chinese
else
set fileencoding=utf-8
endif
" 解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" 解决输出信息乱码
language messages zh_CN.utf-8 

" 显示行号
set number

" 设置字体和配色方案
set guifont=Consolas:h12
colorscheme darkblue

" 语法高亮
syntax on

" 当添加括号等时，自动缩进
set smartindent

" 将tab转换为4个空格
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

set scrolloff=999

" 当某一行输入注释，禁止下一行自动输入注释
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" 设置状态栏
set laststatus=2
set statusline=
set statusline+=%-3.3n\                             " 缓存区号码
set statusline+=%f\                                 " 文件名
set statusline+=%h%m%r%w                            " 状态标志
set statusline+=\[%{strlen(&ft)?&ft:'none'}]        " 文件类型
set statusline+=%=                                  " 右对齐下面的三个状态
set statusline+=0x%-8B                              " 光标处字符的unicode值
set statusline+=%-14(%l,%c%V%)                      " 行号，
set statusline+=%<%P                                " 光标处在文件的位置(百分比)

" 行号，光标位置
set ruler

" 显示未完成的命令
set showcmd

" 逐步搜索模式，对当前键入的字符进行搜索而不必等待输入完成
set incsearch

" 搜索时忽略大小写
set ignorecase

" 在命令模式下使用 Tab 自动补全的时候， 将补全内容使用一个漂亮的单行菜单形式显示出来
set wildmenu

" 显示你所处的模式
set showmode

" 设置窗口显示大小
set lines=35 columns=99

" 禁止显示菜单和状态栏
set guioptions-=m
set guioptions-=T

" 设置mapleader
let mapleader = ";"

" 自定义格式化
function! MyFormatter()
    if (&filetype ==? "xml" || &filetype ==? "html" || &filetype ==? "htm" || &filetype == "")
        :set filetype=xml
	:%s/>\s*</>\r</ge  " 把>空格<替换成>回车<，不提示错误
	:%s/>\s\+\(\S\+\)\s\+</>\1</ge   " 去掉><之间的空格保留中间的文字，不提示错误（e）
	:normal! gg=G
    else
	:normal! gg=G
    endif
endfunction

" 冒号前面必须要有空格
nnoremap <F5> :call MyFormatter()<cr>

" 打开vimrc文件
nnoremap <leader>ev :vsplit $VIM/../DefaultData/settings/vimrc<cr>

" 加载vimrc文件
nnoremap <leader>sv :source $VIM/../DefaultData/settings/vimrc<cr>

" 禁用箭头键
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>


" 插入日期署名
function! Addhead()
    if (&filetype ==? "sql")
        call append(0, "-- =========================================================")
        call append(1, "-- Comment here")
        call append(2, "-- author\: liupa")
	call append(3, "-- Created on " . strftime("%Y-%m-%d %X"))
        call append(4, "-- =========================================================")
        call append(5, "prompt Created on " . strftime("%Y-%m-%d %X") . " by liupa")
	normal! 2ggw
    elseif (&filetype ==? "py")
        call append(0, "# -*- coding: utf-8 -*-")
        call append(1, "\"\"\"Comment here")
        call append(2, "")
        call append(3, "@author wocanmei")
        call append(4, "Created on " . strftime("%Y-%m-%d %X"))
	normal! 2ggw
    else
        echom "Unknow filetype!"
    endif
endfunction

nnoremap ## :call Addhead()<cr>
