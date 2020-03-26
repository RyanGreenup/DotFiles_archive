# Defined in - @ line 0
function xclip --description 'alias xclip=xclip -selection clipboard'
	command xclip -selection clipboard $argv;
end
