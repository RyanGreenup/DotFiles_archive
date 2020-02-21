# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ryan/DotFiles/FZF/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/ryan/DotFiles/FZF/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ryan/DotFiles/FZF/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/ryan/DotFiles/FZF/.fzf/shell/key-bindings.bash"
