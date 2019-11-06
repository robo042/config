" ~/.vimrc
" Jon Red's personal vim config file

" display static virtical line at column 80
set colorcolumn=80

" Tab settings
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" syntax highlighting
syntax on
filetype plugin indent on

" custom statusline setup
set laststatus=2
set statusline=\
    \ %F\ \|\ %h%w%m%r\ \|\ %=%(\|\ L\:\ %l\ \|\ C\:\ %c%V\ \|\ %=\ %P\%)
hi statusline cterm=none ctermbg=green ctermfg=black
function! InsertStatuslineColor(mode)
    if a:mode=='i'
        hi statusline ctermbg=red
    elseif a:mode=='r'
        hi statusline ctermbg=magenta
    else
        hi statusline ctermbg=red
    endif
endfunction
function! NormalStatuslineColor()
    hi statusline ctermbg=green
endfunction
au VimEnter * silent call NormalStatuslineColor()
au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * call NormalStatuslineColor()
au VimLeave * silent call NormalStatuslineColor()

" custom cursor setup
let &t_ti.="\e[2 q"
let &t_SI.="\e[5 q"
let &t_SR.="\e[3 q"
let &t_EI.="\e[2 q"
let &t_te.="\e[0 q"

" trick that uses the terminal's bracketed paste mode to automatically
" set/unset Vim's past mode when you paste
let &t_SI.="\<Esc>[?2004h"
let &t_EI.="\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

" quick save
noremap <Leader>s :update<CR>

" CVE-2019-12735
set modelines=0
set nomodeline
