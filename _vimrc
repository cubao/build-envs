"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim 配置文件
" 测试方法: \vim -u _vimrc _vimrc
" 安装：见 make install_vimrc
" https://github.com/cubao/build-envs/blob/dev/_vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 通用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " 使用vim的高级特性
let mapleader=","             " 设置leader键为逗号
set history=1000              " 命令历史记录数量
" set autoread                  " 当文件在外部被修改时自动重新读取
set backspace=indent,eol,start " 允许在这些情况下使用退格键
set mouse=""                  " 禁用鼠标
language messages en_US.utf-8 " 设置消息语言

" 关闭备份文件和交换文件
set nobackup
set nowritebackup
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 界面与显示设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nu                        " 显示行号
set cursorline                " 高亮当前行
set ruler                     " 在状态栏显示光标位置
set showcmd                   " 在状态栏显示正在输入的命令
set showmatch                 " 高亮显示匹配的括号
set showfulltag               " 显示完整的标签
set matchpairs=(:),{:},[:],<:> " 设置需要匹配的括号
set matchtime=5               " 匹配括号高亮的时间（0.5秒）
set linespace=3               " 行间距
set guioptions-=T             " 移除工具栏

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 文本、制表符与缩进
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab                 " 使用空格代替制表符
set tabstop=4                 " 制表符宽度为4
set shiftwidth=4              " 自动缩进宽度为4
set softtabstop=4             " 按下Tab键时插入4个空格
set ai                        " 自动缩进
set iskeyword-=_              " 将下划线视为单词分隔符
" set paste                     " 启用粘贴模式，防止粘贴时自动缩进；

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 搜索设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch                  " 高亮搜索结果
set incsearch                 " 实时搜索
set ignorecase                " 搜索时忽略大小写
set smartcase                 " 如果搜索包含大写字母，则区分大小写

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 编码设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8            " Vim 内部使用的字符编码
set termencoding=utf-8        " 终端使用的编码
set fileencoding=utf-8        " 新文件的编码
set fileencodings=ucs-bom,utf-8,chinese,cp936 " 尝试解码的顺序

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 键映射
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 可视模式下使用p不会覆盖当前寄存器的内容
xnoremap <leader>p "_c<C-r>0<Esc>

" 可视模式下的搜索和替换功能
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
vnoremap <silent> gv :call VisualSelection('gv')<CR>
vnoremap <silent> r :call VisualSelection('replace')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 辅助函数
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 处理可视模式下的选择操作
function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "") 
    if a:direction == 'b' 
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f' 
        execute "normal /" . l:pattern . "^M"
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" CmdLine函数可能缺失，添加一个简单实现
function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction
