[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias pz="$ pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
