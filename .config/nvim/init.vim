" #### Imports ####
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
" Plug 'rafi/awesome-vim-colorschemes'
Plug 'ayu-theme/ayu-vim'
call plug#end()

" ### Auto commands ###
augroup AdamsAuto
    autocmd! 
    autocmd bufwritepost ~/.config/nvim/init.vim source %   " Autoload config when changed
    autocmd FileType markdown set wrap                      " Wrap markdown files
    autocmd FileType vimwiki set wrap                       " Wrap vimwiki files
augroup END

" ##### General Settings #####
set number                  " Line numbering
set guicursor=              " 
set scrolloff=5             " Start scrolling 5 lines before end

set tabstop=4               " Tab size in spaces
set shiftwidth=4            " Autoindent size in spaces
set expandtab               " Replaces tabs with spaces
set ai                      " Auto indent
set smartindent             " Smart indent

set hidden
set clipboard+=unnamedplus  " Copy vims yank to clipboard

" set spell
" set spelllang=en_us

" #### Theme ####
filetype plugin on
syntax on
set termguicolors
set background=dark
let ayucolor="mirage"
colorscheme ayu
set t_Co=16

" Status Line
set statusline=
set statusline+=%#CursorLineNr#
set statusline+=\ %m
set statusline+=%#NonText#
set statusline+=%=
set statusline+=\ %f
" set statusline+=\
set statusline+=\ %y
set statusline+=\ %r
" set statusline+=%#IncSearch#
" set statusline+=\ %l/%L
" set statusline+=\ [%c]


let mapleader=" "

" #### Window Management ####
" Split Window
nnoremap <leader>" :vsp<CR>
nnoremap <leader>% :sp<CR>

" Change window focus
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>

" Resize window
nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>


" #### Buffer Navigation ####
nnoremap <leader>m :bnext<CR>
nnoremap <leader>n :bprev<CR>
nnoremap <leader>x :bd<CR>



" ###### Functions #####
" Delete white spaces
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col -1] =~# '\s'
endfunction