# Defined in - @ line 0
function ws --description alias\ ws=wmctrl\ -i\ -a\ \(wmctrl\ -l\ \|\ fzf\ \|\ cut\ -d\\\ \ -f1\)
	wmctrl -i -a (wmctrl -l | fzf | cut -d\  -f1) $argv;
end
