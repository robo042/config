" ~/.vimrc

" default colorscheme
colorscheme ron

" syntax highlighting
filetype plugin indent on
syntax on

" tab settings
set tabstop=4 shiftwidth=4 expandtab

" indicate lines longer than 80 characters
set textwidth=0
match Error /\%>80c/
highlight Error ctermbg=Red ctermfg=Yellow

" custom StatusLine setup
set laststatus=2 statusline=\
    \ %F\ \|\ %h%w%m%r\ \|\ %=%(\|\ L\:\ %l\ \|\ C\:\ %c%V\ \|\ %=\ %P\ %)
highlight StatusLine cterm=none ctermbg=green ctermfg=black
function! InsertStatuslineColor(mode)
    if a:mode=='i'
        highlight StatusLine ctermbg=red
    elseif a:mode=='r'
        highlight StatusLine ctermbg=magenta
    else
        highlight StatusLine ctermbg=red
    endif
endfunction
function! NormalStatuslineColor()
    highlight StatusLine ctermbg=green
endfunction
autocmd VimEnter * silent call NormalStatuslineColor()
autocmd InsertEnter * call InsertStatuslineColor(v:insertmode)
autocmd InsertChange * call InsertStatuslineColor(v:insertmode)
autocmd InsertLeave * call NormalStatuslineColor()

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

" Quick save
noremap <Leader>s :update<CR>

" Highlight search, as you type
set hlsearch incsearch

" Disable annoying beeping
set noerrorbells
set vb t_vb=

" Options to address CVE-2019-12735
set modelines=0 nomodeline

