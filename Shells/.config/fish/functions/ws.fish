# Defined in - @ line 0
function ws --description alias\ ws=wmctrl\ -i\ -a\ \(wmctrl\ -l\ \|\ fzf\ \|\ cut\ -d\\\ \ -f1\)\;exit
	wmctrl -i -a (wmctrl -l | fzf | cut -d\  -f1);exit $argv;
end
