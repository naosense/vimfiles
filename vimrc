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
set noimdisable
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
set guifont=Consolas:h14
set gfw=YouYuan:h14
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
autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

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
autocmd guienter * simalt ~x

" 将替换的/分隔符替换为:
noremap <leader>rr :%s:\v::g<left><left><left>
noremap <leader>rg :%s:::g<left><left><left>
noremap <leader>rc :%s:::cg<left><left><left><left>

" 去除搜索高亮
noremap <silent><C-l> :<C-u>nohlsearch<cr><C-l>

" 统计当前光标下单词的个数
nnoremap <leader>cc :%s/\(<c-r>=expand("<cword>")<cr>\)//gin\|norm!``<cr>

" 以逗号对齐
let g:sqlutil_align_comma = 1
let g:sqlutil_wrap_long_lines = 0

" 删除重复行
function! DelDulplicate()
    :%s:\v^\s*(.+)\s*$:\1:g
    :sort
    :g/^\(.\+\)$\n\1/d
endfunction

nnoremap <leader>dd :call DelDulplicate()<cr>

" pathogen插件管理
execute pathogen#infect()
execute pathogen#helptags()

" 设置plasticboy/vim-markdown
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_math = 1
let g:vim_markdown_conceal = 0
set nofoldenable

" markdown表格插入函数
function! InsertMKTable()
    echohl Identifier
    let l:args = split(input("row and col?"))
    echohl None
    if (len(l:args) !=? 2)
        echoerr "input row and col split by space"
        return
    endif
    let l:row = l:args[0]
    let l:col = l:args[1]
    let l:current = line("\.")
    call append(l:current, RepeatStr(l:col, "| title  ") . "|")
    call append(l:current + 1, RepeatStr(l:col, "| :---:  ") . "|")

    for i in range(l:row)
        call append(line("\.") + 2 + i, RepeatStr(l:col, "| center ") . "|")
    endfor
endfunction

function! RepeatStr(n, str)
    let l:s = ""
    for i in range(a:n)
        let l:s .= a:str
    endfor
    return l:s
endfunction

function! TrailSpace()
    :%s:\v\s+$::ge
    :normal! mqG
    let l:c = line("$")
    let l:trailing_c = 0
    for i in reverse(range(l:c))
        if (match(getline(i + 1), "^\s*$") > -1)
            :normal! dd
            let l:trailing_c += 1
        else
            break
        endif
    endfor
    :silent! normal! `q
    :delmarks q
endfunction

" 删除空白符的命令
nnoremap <leader>tr :call TrailSpace()<cr>

" 每次文件保存自动删除行
autocmd bufwrite * :call TrailSpace()

augroup markdown
    autocmd!
    autocmd filetype markdown nmap <leader>ft <Plug>(EasyAlign)ip*<bar>

    " markdown元素简写
    autocmd filetype markdown iab cb ```language<cr>```<esc>2bh
    autocmd filetype markdown iab im ![title](url)<esc>3bh
    autocmd filetype markdown iab lk [title](url)<esc>4b

    " 行内代码的快捷键
    autocmd filetype markdown nnoremap <leader>q ciw``<esc>P
    autocmd filetype markdown vnoremap <leader>q c``<esc>P
    " 粗体
    autocmd filetype markdown nnoremap <leader>b ciw****<esc>hP
    autocmd filetype markdown vnoremap <leader>b c****<esc>hP
    " 斜体
    autocmd filetype markdown nnoremap <leader>i ciw**<esc>P
    autocmd filetype markdown vnoremap <leader>i c**<esc>P

    autocmd filetype markdown nnoremap <leader>mt :call InsertMKTable()<cr>
    autocmd filetype markdown nnoremap <F9> :MarkSyncPreview<cr>
    autocmd filetype markdown nnoremap <S-F9> :MarkSyncClose<cr>
augroup end

augroup scheme
    autocmd!
    " 加上<esc>可以避免弹出命令行必须按两次enter才能回到代码
    autocmd filetype scheme nnoremap <F9> :w<cr>:! racket %<cr><esc>
augroup end

" 配置vim-flake8快捷键
autocmd filetype python nnoremap <buffer> <F6> :call Flake8()<cr>

let g:markdown_preview_sync_chrome_path = "C:/Program Files (x86)/Google/Chrome/Application/chrome.exe"
