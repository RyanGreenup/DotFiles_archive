# Defined in - @ line 0
function wS --description alias\ wS=wmctrl\ -i\ -R\ \(wmctrl\ -l\ \|\ fzf\ \|\ cut\ -d\\\ \ -f1\)
	wmctrl -i -R (wmctrl -l | fzf | cut -d\  -f1) $argv;
end
