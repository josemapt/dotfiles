function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Cyan ctermfg=6 guifg=Black ctermbg=0
  elseif a:mode == 'r'
    hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
  else
    hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
  endif
endfunction

let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ '' : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'R ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
\}


" default the statusline to gray when entering Neovim
hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

" set groups colors
hi User1 guifg=0 guibg=#c678dd
hi User2 guifg=gray guibg=0

" Formats the statusline
set statusline=
set statusline+=%1*
" Show current mode
set statusline+=\ %{toupper(g:currentmode[mode()])}
set statusline+=%{&spell?'[SPELL]':''}

set statusline+=%#Warnings#
set statusline+=%{&paste?'[PASTE]':''}

set statusline+=%2*
" File path, as typed or relative to current directory
set statusline+=\ %F

set statusline+=%{&modified?'\ [+]':''}
set statusline+=%{&readonly?'\ []':''}

" Truncate line here
set statusline+=%<

" Separation point between left and right aligned items.
set statusline+=%=

set statusline+=%{&filetype!=#''?&filetype.'\ \|\ ':'none\ '}

" Encoding & Fileformat
set statusline+=%#Warnings#
set statusline+=%{&fileencoding!='utf-8'?'['.&fileencoding.']':''}

set statusline+=%2*
set statusline+=%-7(%{&fileformat}%)

" Warning about byte order
set statusline+=%#Warnings#
set statusline+=%{&bomb?'[BOM]':''}

set statusline+=%2*
" Percent through file
set statusline+=%P\ 

set statusline+=%1*
" Location of cursor line
set statusline+=\ %l:%L\ 

" Column number
" set statusline+=\ col:%2c