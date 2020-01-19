# Defined in - @ line 1
function xclip --description 'alias xclip=xclip -selection clipboard'
	command xclip -selection clipboard $argv;
end
