# ~/.bashrc: executed by bash(1) for non-login shells.


# SHELL OPTIONS / FEATURES ####################################################


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth


# append to the history file, don't overwrite it
shopt -s histappend


# for setting history length 
HISTSIZE=10000
HISTFILESIZE=20000


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar


# make less more friendly for non-text input files
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"


# colored GCC warnings and errors
export GCC_COLORS=\
    'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# ensure programmable completion features are enabled
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# no emacs, all vi
EDITOR='vi'
VISUAL='vi'

# no emacs, all vi (hardcore)
#set -o vi


# TERMINAL PROMPT OPTIONS (pimp my command line) ##############################


# force a colored prompt, if the terminal capability
force_color_prompt=yes


# set variable identifying the chroot you work in (used in the prompt below)
if [[ -z ${debian_chroot:-} ]] && [[ -r /etc/debian_chroot ]]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


# set a fancy prompt 
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
if [[ -n $force_color_prompt ]]; then
    if [[ -x /usr/bin/tput ]] && tput setaf 1>&/dev/null; then
	    # We have color support; assume it's compliant with Ecma-48
	    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	    # a case would tend to support setf rather than setaf.)
	    color_prompt=yes
    else
	    color_prompt=
    fi
fi
if [[ $color_prompt == yes ]]; then
    ps1_1='${debian_chroot:+($debian_chroot)}'
    ps1_2='\[\033[01;32m\]\n\u\[\033[01;34m\]@\[\033[01;35m\]\h '
    ps1_3='\[\033[01;33m\]\w\n\[\033[01;36m\]bash\[\033[01;00m\]\$ ' 
    PS1="${ps1_1}${ps1_2}${ps1_3}"
    unset ps1_1 ps1_2 ps1_3
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# ADDITIONAL BASH CONFIGS #####################################################


# Alias definitions.
# Put all aliases into ~/.bash_aliases, instead of adding them here directly.
if [[ -f ~/.bash_aliases ]]; then
    . ~/.bash_aliases
fi


# Function definitions.
# Put all functions into ~/.bash_functions, instead of adding them here
# directly.
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi


## MORE DIFFERENT STUFF GOES BELOW HERE ###################################### 


