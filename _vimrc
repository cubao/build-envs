" test this vimrc:
"     \vim -u _vimrc _vimrc

set nocompatible
let mapleader=","
" xnoremap <leader>p "_dP
xnoremap <leader>p "_c<C-r>0<Esc>

set nu
set expandtab ts=4 sw=4 sts=4 ai
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,cp936
set cursorline
set hlsearch
set ruler
set backspace=indent,eol,start
set history=1000
set autoread
set showcmd
set incsearch                                               " do incremental searching
set ignorecase
set smartcase
set guioptions-=T                                           " set guioptions="", -m (menu bar), :help go-M
set showmatch
set showfulltag
set matchpairs=(:),{:},[:],<:>
set matchtime=5                                             " Show matchtime in 0.5s
set mouse=""
set iskeyword-=_                                            " two words: twenty_one
set nobackup
set nowritebackup
set noswapfile
set linespace=3
language messages en_US.utf-8

vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
vnoremap <silent> gv :call VisualSelection('gv')<CR>
vnoremap <silent> r :call VisualSelection('replace')<CR>
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
