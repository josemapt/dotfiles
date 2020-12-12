# Normal aliases===================================================================
alias sudo='sudo '

alias find='find . -iname'

alias grep='grep --color=always'

alias ls='exa -F --group-directories-first'
alias ll='exa -lF --group-directories-first'
alias la='exa -aF --group-directories-first'
alias lla='exa -alF --group-directories-first'
alias tree='exa -T --level=2'

alias ..='cd ..'

alias cp='cp -v'
alias rm='rm -rv'
alias mv='mv -v'

alias cat='ccat -G Plaintext="blink" -G Keyword="purple" -G String="darkgreen" -G Punctuation="brown" -G Comment="faint"'

alias ns='notify-send'

alias yay='yay --nodiffmenu'
alias pacman='pacman --color=always'

alias test_qtile='Xephyr -br -ac -noreset -screen 1280x720 :1 & ; DISPLAY=:1 qtile'

alias mkex='chmod +x'

alias scrot='scrot -p'

# Global aliases===================================================================
alias -g nv='nvim'

# Suffix aliases===================================================================
#alias -s sh='nvim'
#alias -s pdf='evince'