##  Fish Generic Settings
#
#What you do here, you must do for bash and zsh
#  use `gf` to travel there
#   [[~/.bashrc][Bash RunCommand]]
#   [[~/.zshrc][ Bash RunCommand]]


# Set Vim Keybindings
#fish_vi_key_bindings
#read this on spacemacs warnings
# https://github.com/syl20bnr/spacemacs/issues/12221
fish_vi_key_bindings 2>/dev/null #supress warnings for emacs


# Make the keybindings just work
 fzf_key_bindings

# Make the default Editor NVim (vim is aliased to nvim)
set -x EDITOR "/usr/bin/nvim"
set -x VISUAL "/usr/bin/nvim"

# Starship Prompt (Minimal, looks nice, notification for
# things like python and git)
	 # I'm just happy with the `es` theme
#eval (starship init fish)


#function fish_user_key_bindings
#  fzf_key_bindings
#end


# ~/.config/fish/config.fish

#starship init fish | source

# Searching file Contents
#grep --line-buffered --color=never -r "" * | fzf

# with ag - respects .agignore and .gitignore
#ag --nobreak --nonumbers --noheading . | fzf

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
# fif() {
#   if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
#   rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
# }
# 
# Use Powerline
#set fish_function_path $fish_function_path "{repository_root}/powerline/bindings/fish"
#powerline-setup


# Bulshit Ruby stuff
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"




## vim:fdm=expr:fdl=0
## vim:fde=getline(v\:lnum)=~'^##'?'>'.(matchend(getline(v\:lnum),'##*')-2)\:'='



## Start Python Server to access notes
#ps -ef | grep 'python3 -m http.server 8128' | awk '{print \$2}' | xargs sudo kill
#$HOME/bin/NoteServer.sh & disown
