# Defined in - @ line 1
function i3st --description 'alias i3st=vim .config/i3/config && i3-msg restart'
	vim .config/i3/config && i3-msg restart $argv;
end
