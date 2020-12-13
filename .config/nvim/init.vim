set number		    " add line numbers
set title		    " add title

set nobackup        " do not make copies of the file

set mouse=a		    " enable mouse
set ruler           " Show the cursor position all the time

set cursorline		" highlighting of the current line
set background=dark	" foregrounf color theme acording to background theme
set scrolloff=3		" set lines from border

set showtabline=1   " set 2 to show topbar
set noshowmode      " hide mode

set ignorecase		" ignore uppercase in search
set smartcase		" not ignore upercase if search contains uppercase

set encoding=utf-8  " The encoding displayed

set smartindent     " Makes indenting smart
set autoindent      " Good auto indent

syntax enable       " Enables syntax highlighing

" Colors and theming =================================================================
" 1:red 2:green 3:yellow 4:blue 5:purple 6:cyan 7:gray 8:gray+ 9-> dim
highlight LineNr           ctermfg=11    ctermbg=none    cterm=none     " line numbers
highlight CursorLineNr     ctermfg=11    ctermbg=8       cterm=bold     " current line number

highlight Comment          ctermfg=12    ctermbg=none    cterm=italic    " comment

highlight String           ctermfg=4     ctermbg=none    cterm=none      " string
highlight Number           ctermfg=2     ctermbg=none    cterm=none      " number
highlight Constant         ctermfg=12    ctermbg=none    cterm=none      " constants
highlight Function         ctermfg=9     ctermbg=none    cterm=italic    " functions

highlight Statement        ctermfg=13    ctermbg=none    cterm=bold      " def, return ...
highlight PreProc          ctermfg=13    ctermbg=none    cterm=bold      " from, import ...


highlight CursorLine       ctermfg=none     ctermbg=8     cterm=none      " cursor line


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
call plug#begin('~/.local/share/nvim/plugged')

    " Plug 'scrooloose/nerdtree'      " file explorer
    " Plug 'vim-airline/vim-airline'  " airline
    Plug 'Yggdroot/indentLine'      " indent line
    Plug 'haya14busa/incsearch.vim' " better search
    Plug 'jiangmiao/auto-pairs'     " double commas, parentesis...

call plug#end()


" Plugins config ===============================================================

" nerdtree configs
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" nnoremap <C-t> :NERDTreeToggle<CR>

" necessary for search
map /  <Plug>(incsearch-forward)

" airline config
" let g:airline_powerline_fonts = 1           " enables powerline in airline
" let g:airline_skip_empty_sections = 1       " hiddes empty sections

" set indent character
let g:indentLine_char = '|'



" Statusbar config ================================================================
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Cyan ctermfg=6 guifg=Black ctermbg=0
  elseif a:mode == 'r'
    hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
  else
    hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

" default the statusline to gray when entering Neovim
hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

" Formats the statusline
set statusline=%f                           " file name
" set statusline+=[%{strlen(&fenc)?&fenc:'none'}, " file encoding
" set statusline+=%{&ff}] " file format
" set statusline+=%y      " filetype
set statusline+=%h        " help file flag
set statusline+=%m        " modified flag
set statusline+=%r        " read only flag

set statusline+=\ %=                        " align left
set statusline+=Line:%l/%L[%p%%]            " line X of Y [percent of file]
set statusline+=\ Column:%c                    " current column
" set statusline+=\ Buf:%n                    " Buffer number
" set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor