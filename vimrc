" 我的GVim配置文件
" 作者：Hi卡文迪什
" 第4行到32行为原始的vimrc文件
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

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
colorscheme desert 

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
