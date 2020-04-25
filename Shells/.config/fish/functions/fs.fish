# Defined in - @ line 1
function fs --wraps=fzf --description 'alias fs=fzf | xclip'
  fzf | xclip $argv;
end
