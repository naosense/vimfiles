" GVim配置文件
"
" 这是一份Windows下的GVim配置文件，linux下可能略有不同，部分代码来自
" 互联网，随着时间的推移，一些新的代码和特性将会添加，同时一些代码将
" 可能会被删除，请结合自己的需求斟酌实用。
"
" 获得最新的代码请到https://github.com/pingao777。
" @author wocanmei
" @date 2013-5-21

set nocompatible
filetype plugin on
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" if has("vms")
set nobackup        " do not keep a backup file, use versions instead
" else
"  set backup       " keep a backup file
" endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""               我的个性化配置                    """"""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置编码，解决中文乱码问题
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1,gbk
" 解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" 解决输出信息乱码
language messages zh_CN.utf-8

" 显示行号
set number

" 相对行号
set relativenumber

set linespace=5

" 设置字体和配色方案
set guifont=Consolas:h12
set gfw=YouYuan:h12
set background=dark
set termguicolors
colorscheme material-monokai

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

" 禁用undo文件
set noundofile

" 当某一行输入注释，禁止下一行自动输入注释
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" 设置状态栏
set laststatus=2
set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%1*\ %<%F\                                "File+path
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..)
set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.

function! HighlightSearch()
  if &hls
    return 'H'
  else
    return ''
  endif
endfunction

hi User1 guifg=#ffdad8  guibg=#880c0e
hi User2 guifg=#000000  guibg=#F4905C
hi User3 guifg=#292b00  guibg=#f4f597
hi User4 guifg=#112605  guibg=#aefe7B
hi User5 guifg=#051d00  guibg=#7dcc7d
hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
hi User8 guifg=#ffffff  guibg=#5b7fbb
hi User9 guifg=#ffffff  guibg=#810085
hi User0 guifg=#ffffff  guibg=#094afe

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
" set guioptions-=m
set guioptions-=T

" 设置mapleader
let mapleader = "\<space>"

" 自定义格式化
function! MyFormatter()
    if (&filetype ==? "xml" || &filetype ==? "html" || &filetype ==? "htm" || &filetype == "")
        :set filetype=xml
        :%s/>\s*</>\r</ge  " 把>空格<替换成>回车<，不提示错误
        :%s/>\s\+\(\S\+\)\s\+</>\1</ge   " 去掉><之间的空格保留中间的文字，不提示错误（e）
        :normal! gg=G
    elseif(&filetype ==? "sql")
        :%SQLUFormatter
    else
        :normal! gg=G
    endif
endfunction

" 冒号前面必须要有空格
nnoremap <F5> :call MyFormatter()<cr>

" 打开vimrc文件
nnoremap <leader>ev :split $VIM/_vimrc<cr>

" 加载vimrc文件
nnoremap <leader>sv :source $VIM/_vimrc<cr>

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
        :normal! ggdG
        call append(0, "-------------------------------------------------------")
        call append(1, "-- author: name")
        call append(2, "-- date: " . strftime("%Y-%m-%d %X"))
        call append(3, "-- CommentHere")
        call append(4, "-------------------------------------------------------")
        call append(5, "prompt Created on " . strftime("%Y-%m-%d %X") . " by name")
        call append(6, "set feedback off")
        call append(7, "set define off")
        call append(8, "")
        call append(9, "set feedback on")
        call append(10, "set define on")
        call append(11, "prompt Done.")
        normal! 4ggw
    elseif (&filetype ==? "python")
        call append(0, "# -*- coding: utf-8 -*-")
        call append(1, "\"\"\"Comment here")
        call append(2, "")
        call append(3, "@author wocanmei")
        call append(4, "@date " . strftime("%Y-%m-%d %X"))
        call append(5, "\"\"\"")
        normal! 2ggw
    else
        echom "Unknow filetype!"
    endif
endfunction

nnoremap ## :call Addhead()<cr>

" 自动全屏
autocmd GUIEnter * simalt ~x

" sql关键字大写
let g:sqlutil_keyword_case = '\U'

" 将替换的/分隔符替换为:
noremap <leader>rr :%s:\v::g<left><left><left>
noremap <leader>rg :%s:::g<left><left><left>
noremap <leader>rc :%s:::cg<left><left><left><left>

" 去除搜索高亮
noremap <silent><C-l> :<C-u>nohlsearch<cr><C-l>

" 统计当前光标下单词的个数
nmap <leader>cc :%s/\(<c-r>=expand("<cword>")<cr>\)//gin\|norm!``<cr>

" 以逗号对齐
let g:sqlutil_align_comma = 1
let g:sqlutil_wrap_long_lines = 0

" 包管理器
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'gabrielelana/vim-markdown'
Plug 'skielbasa/vim-material-monokai'
call plug#end()

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

let g:markdown_enable_spell_checking = 0
let g:markdown_enable_input_abbreviations = 0
let g:markdown_enable_mappings = 0

" 删除重复行
function! DelDulplicate()
    :%s:\v^\s*(.+)\s*$:\1:g
    :sort
    :g/^\(.\+\)$\n\1/d
endfunction

nnoremap <leader>dd :call DelDulplicate()<cr>
nmap <leader>ft gaip*<bar>

iab mt <bar> title  <bar> title <bar> title <bar><cr><bar> :---:  <bar> :---  <bar> ---:  <bar><cr><bar> center <bar> left  <bar> right <bar>