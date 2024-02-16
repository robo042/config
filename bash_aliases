# ~/.bash_aliases 

# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || {
        eval "$(dircolors -b)"
    }
    alias ls='ls -hF --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alert_var='notify-send --urgency=low -i'
alert_var+=' "$([ $? = 0 ] && echo terminal || echo error)"'
alert_var+=' "$(history|tail -n1|sed'
alert_var+=' -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias alert="$alert_var"
unset alert_var

# even more
alias cls='clear'
alias cp='cp -i'
alias df='df -h'
alias du='du -h'
alias mv='mv -i'
alias rm='rm -I'
alias vi='vim'
alias whence='type -a'

# from .bash_functions
alias cd='cd_func'

