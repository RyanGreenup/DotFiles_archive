> cat ~/.config/fish/functions/fif.fish
function fif 
#ls -lh $argv
ag $argv --nobreak --nonumbers --noheading . | fzf
end
 


#  # Searching file Contents
#  grep --line-buffered --color=never -r "" * | fzf
#  
#  # with ag - respects .agignore and .gitignore
#  #ag --nobreak --nonumbers --noheading . | fzf
#  
#  # using ripgrep combined with preview
#  # find-in-file - usage: fif <searchTerm>
#  fif() {
#    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
#    rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
#  }
#  
