# start gnome (wayland) at login
if status --is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        set MOZ_ENABLE_WAYLAND 1
        set QT_QPA_PLATFORM wayland
        set XDG_SESSION_TYPE wayland
        exec dbus-run-session gnome-session
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
