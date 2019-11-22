" ~/.vimrc

" display a static vertical line at column 80
set colorcolumn=80

" tab settings
set tabstop=4
set shiftwidth=4
set expandtab

" syntax highlighting
syntax on
filetype plugin indent on

" statusline setup
set laststatus=2
set statusline=\
    \ %F\ \|\ %h%w%m%r\ \|\ %=%(\|\ L\:\ %l\ \|\ C\:\ %c%V\ \|\ %=\ %P\ %)
hi statusline cterm=none ctermbg=green ctermfg=black
let g:keyboard_backlight_controller=
            \'/sys/class/leds/system76::kbd_backlight/color_left'
function! InsertStatuslineColor(mode)
    if a:mode=='i'
        hi statusline ctermbg=red
        call writefile(['FF0000'], g:keyboard_backlight_controller)
    elseif a:mode=='r'
        hi statusline ctermbg=magenta
        call writefile(['FF00FF'], g:keyboard_backlight_controller)
    else
        hi statusline ctermbg=red
        call writefile(['FF0000'], g:keyboard_backlight_controller)
    endif
endfunction
function! NormalStatuslineColor()
    hi statusline ctermbg=green
    call writefile(['00FF00'], g:keyboard_backlight_controller)
endfunction
function! ExitStatuslineColor()
    call writefile(['0000FF'], g:keyboard_backlight_controller)
endfunction
au VimEnter * silent call NormalStatuslineColor()
au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * call NormalStatuslineColor()
au VimLeave * silent call ExitStatuslineColor()
"call NormalStatuslineColor()

" little trick that uses the terminal's bracketed paste mode to automatically
" set/unset Vim's paste mode when you paste.
let &t_SI.="\<Esc>[?2004h"
let &t_EI.="\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

" customize cursor based on mode
let &t_ti.="\e[2 q"
let &t_SI.="\e[5 q"
let &t_SR.="\e[3 q"
let &t_EI.="\e[2 q"
let &t_te.="\e[0 q"

" Options to address CVE-2019-12735
set modelines=0
set nomodeline

" Quick save
noremap <Leader>s :update<CR>
