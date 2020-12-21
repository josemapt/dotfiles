# autostart when log-in
if [[ "$(tty)" = "/dev/tty1" ]] && [[ "$(whoami)" != "root" ]]; then
    echo "\n\033[1;33mStarting session...\033[0m"
    [[ -f ~/.xinitrc ]] && startx || echo -e "~/.xinitrc hasn't been found"
fi

# Enable colors
autoload -U colors && colors
# Disable ctrl-s to freeze terminal
stty stop undef
# highlight config
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)       # enables main and brackets highlight

# Report time stats of commands running longer than 5 sec
#REPORTTIME=5

# bindkeys ===================================================================================
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word


# path-completion ==============================================================================
autoload -Uz compinit && compinit -d ~/.cache/zsh/zcompdump
# Allow hidden files autocompletion
_comp_options+=(globdots)
# Case insensitive
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# Selection theme
zstyle ':completion:*' menu select
# Aproximate completion and max errors allowed
zstyle ':completion:::::' completer _complete _approximate
zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/4 )) numeric )'
# Non matches warning
zstyle ':completion:*:warnings' format "%B$fg[red]%}---- no match for: $fg[white]%d%b"
# exclude from autocompletion
zstyle ':completion:*:*:nvim:*:*files' ignored-patterns '*.jpg|*.png|*.pdf|*.odt|*.o|*.so|*.docx'
# Ignore completion functions for commands you don't have:
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

# History settings ==============================================================================
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.cache/zsh/zsh_history

setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt SHARE_HISTORY             # share history between simultaneously running shells
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# git branch ==============================================================================
autoload -Uz vcs_info
precmd() { vcs_info }

# Information about changes (! for unstaged changes) (+ for staged changes)
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%b%F{red}[%B!%b]%f'
zstyle ':vcs_info:*' stagedstr '%b%F{yellow}[%B+%b]%f'

zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '

zstyle ':vcs_info:git:*' formats '%F{green}%f on %F{cyan}%B%b%f %u%c%a'

setopt PROMPT_SUBST

# prompt ==============================================================================
PS1='%F{yellow}%n@%m %F{blue}(%~) %(?.%F{green}.%F{red})%f%b '
RPROMPT='${vcs_info_msg_0_}'


# Sources -------------------------------------------------------------
for f in ~/.config/zsh/zsh_config/*; do source $f; done         # load all data from ~/.config/zsh/zsh_config

source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/fast-syntax-highlighting.plugin.zsh     # this must be the last one
