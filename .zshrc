# autostart when log-in
if [[ "$(tty)" = "/dev/tty1" ]] && [[ "$(whoami)" != "root" ]]; then
    echo "\n\033[1;33mStarting qtile...\033[0m"
    pgrep qtile || startx
fi


# Enable colors
autoload -U colors && colors


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
zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
# Non matches warning
zstyle ':completion:*:warnings' format "%B$fg[red]%}---- no match for: $fg[white]%d%b"
# exclude from autocompletion
zstyle ':completion:*:*:nvim:*:*files' ignored-patterns '*.jpg|*.png|*.pdf|*.odt|*.o|*.so|*.docx'


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
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# prompt ==============================================================================
PS1="%F{magenta}(%~) %F{blue}%n%f %(?.%F{green}.%F{red})%f "


# highlight config
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)       # enables main and brackets highlight


# Sources -------------------------------------------------------------
for f in ~/.config/zsh/zsh_config/*; do source $f; done         # load all data from ~/.config/zsh/zsh_config

source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh     # this must be the last one