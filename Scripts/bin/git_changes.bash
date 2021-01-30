#!/bin/bash
# git log | grep '^commit' | sed 's/^commit\ //' 
git log | grep '^commit' | sed 's/^commit\ //'  | \
    sk --ansi --preview 'git diff {}^! | bat --color always' \
     --bind 'ctrl-f:interactive,pgup:preview-page-up,pgdn:preview-page-down'   

