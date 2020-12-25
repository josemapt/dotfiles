#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History config
export HISTFILE=~/.cache/bash/bash_history
HISTCONTROL=ignoreboth
HISTSIZE=1000

# aliases
source ~/.config/zsh/aliases

# colored man
source ~/.config/zsh/colored_man

# prompt
PS1="\[\033[01;32m\]\u@\h\[\033[00m\]: \[\033[01;34m\](\w)\[\033[33m\] \[\033[1;37m\]\$\[\033[00m\] "