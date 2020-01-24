# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ryan/Dropbox/DotFiles/FZF/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/ryan/Dropbox/DotFiles/FZF/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ryan/Dropbox/DotFiles/FZF/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/ryan/Dropbox/DotFiles/FZF/.fzf/shell/key-bindings.zsh"
