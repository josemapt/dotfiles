# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        echo -e "\n\033[1;33mStarting session...\033[0m" && exec startx
    end
end

# aliases
alias ls='exa --color=auto --group-directories-first'
alias la='exa -a --color=auto --group-directories-first'
alias ll='exa -l --color=auto --group-directories-first'
alias lla='exa -la --color=auto --group-directories-first'

alias cat='bat'
alias find='fd -Hg'
#alias du='dust'

alias grep='grep --color=auto'

alias ..='cd ..'

alias cp='cp -rvi'
alias rm='rm -rv'
alias mv='mv -vi'

alias diff='diff --color=auto'
alias pacman='pacman --color=auto'

alias add='git add -v .'
alias commit='git commit -am'
alias push='git push -uv --progress origin'
alias pull='git pull -v --progress'
alias clone='git clone --progress'
