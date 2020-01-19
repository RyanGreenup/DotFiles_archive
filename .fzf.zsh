# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ryan/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/ryan/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ryan/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/ryan/.fzf/shell/key-bindings.zsh"
