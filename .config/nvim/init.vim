source ~/.config/nvim/theme.vim
source ~/.config/nvim/statusline.vim
source ~/.config/nvim/autopair.vim
source ~/.config/nvim/indentline.vim

set number		    " add line numbers
set title		      " add title

" Theme options
set termguicolors
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

" set nowrap          " do not wrap lines

set history=500     " The number of command and search history to keep

set nobackup        " do not make copies of the file
set noswapfile      " Disable creating swapfiles

set mouse=a		      " enable mouse
set ruler           " Show the cursor position all the time

set cursorline		" highlighting of the current line
set background=dark	" foregrounf color theme acording to background theme
set scrolloff=3		" set lines from border

set showtabline=1   " set 2 to show topbar
set noshowmode      " hide mode
set laststatus=2    " Set height of status line

set ignorecase		" ignore uppercase in search
set smartcase		" not ignore upercase if search contains uppercase

set encoding=utf-8  " The encoding displayed

set smartindent     " Makes indenting smart
set autoindent      " Good auto indent



syntax enable       " Enables syntax highlighing


" remaps ==============================================================================
" quit with Ctr+q
nnoremap <C-q> :q!<CR>

" save with Ctr+s
nnoremap <C-s> :w<CR>

" search with Ctr+f
nnoremap <C-f> /

" undo with Ctr+z
nnoremap <C-z> :u<CR>

" copy with Ctr+c
nnoremap <C-c> y	    
vnoremap <C-c> y

" cut with Ctr+x
nnoremap <C-x> d
vnoremap <C-x> d

" paste with Ctr+v
nnoremap <C-v> p
vnoremap <C-v> p


" plugins ======================================================================
" call plug#begin('~/.local/share/nvim/plugged')

    " Plug 'scrooloose/nerdtree'      " file explorer
    " Plug 'vim-airline/vim-airline'  " airline
    " Plug 'Yggdroot/indentLine'      " indent line
    " Plug 'haya14busa/incsearch.vim' " better search
    " Plug 'jiangmiao/auto-pairs'     " double commas, parentesis...

" call plug#end()
