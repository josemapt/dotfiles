#
# ~/.zshrc
#

# autostart when log-in
if [[ "$(tty)" = "/dev/tty1" ]] && [[ "$(whoami)" != "root" ]]; then
    echo "\n\033[1;33mStarting session...\033[0m"
    [[ -f ~/.xinitrc ]] && startx || echo -e "~/.xinitrc hasn't been found"
fi


# Enable colors
autoload -U colors && colors
# Disable ctrl-s to freeze terminal
stty stop undef
# prompt substitution
setopt PROMPT_SUBST


# bindkeys ===================================================================================
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#bindkey '^a' beginning-of-line
#bindkey '^e' end-of-line

bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word


for f in ~/.config/zsh/*; do source $f; done         # load all data from ~/.config/zsh/

source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# colored ls output
eval `dircolors ~/.dir_colors`

# prompt =======================================================================================
PS1='%F{yellow}%n@%m %F{blue}(%~) %(?.%F{green}.%F{red})%f%b '
RPROMPT='${vcs_info_msg_0_}'