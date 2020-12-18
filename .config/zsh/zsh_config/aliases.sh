# Normal aliases===================================================================
alias sudo='sudo '

alias grep='grep --color=always'

alias ls='exa -F --group-directories-first'
alias ll='exa -lF --group-directories-first'
alias la='exa -aF --group-directories-first'
alias lla='exa -alF --group-directories-first'
alias tree='exa -T --level=2'

alias ..='cd ..'

alias cp='cp -vi'
alias rm='rm -rv'
alias mv='mv -v'

alias cat='ccat -G Plaintext="blink" -G Keyword="purple" -G String="darkgreen" -G Punctuation="brown" -G Comment="faint"'

alias yay='yay --nodiffmenu'
alias pacman='pacman --color=always'

alias test_qtile='Xephyr -br -ac -noreset -screen 1280x720 :1 & ; DISPLAY=:1 qtile'

alias mkex='chmod +x'

alias df='df -h'

alias dmenu="dmenu_run -nb '#454545' -nf '#ffffff' -sb '#458588' -sf '#ffffff'"

alias scrot='scrot -p'

alias feh='feh -g 1600x900+150+100 --scale-down'
alias mpv='mpv --geometry=90%x90%'

# Global aliases===================================================================
#alias -g nv='nvim'

# Git aliases=====================================================================
alias add='git add -v .'
alias commit='git commit -am'
alias push='git push -uv --progress origin'
alias pull='git pull -v --progress'

alias clone='git clone --progress'

# Suffix aliases===================================================================
#alias -s sh='nvim'
#alias -s pdf='evince'
