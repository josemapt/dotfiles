#
# ~/.bashrc
#

export EDITOR=nvim
export VISUAL=codium

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History config
export HISTFILE=~/.cache/bash/bash_history
HISTCONTROL=ignoreboth
HISTSIZE=1000

# Completions
complete -cf sudo man which pacman

# Wrap lines on window resize
shopt -s checkwinsize


# prompt
PS1="\[\033[01;32m\]\u@\h\[\033[00m\]: \[\033[01;34m\](\w)\[\033[33m\] \$? \[\033[1;37m\]>\[\033[00m\] "


# colored man pages
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'

# aliases
alias grep='grep --color=auto'

alias ls='ls --color=auto --group-directories-first'
alias la='ls -A --color=auto --group-directories-first'
alias ll='ls -l --color=auto --group-directories-first'
alias lla='ls -lA --color=auto --group-directories-first'

alias ..='cd ..'

alias cp='cp -rvi'
alias rm='rm -rv'
alias mv='mv -vi'
