#!/bin/bash
# Don't forget to adjust the permissions with:
#chmod +x ~/somecrazyfolder/script1

## Program


### Description
# This is the program you should use to copy in dotfiles,
# You can do it manually, but, by using this you have a record
# of what you're syncing and it will remain reproducable.

# I wanted to make it copy everything and exclude .git files but 
# doing so became a nightmare:

1. If there are git files

#scriptLoc=$(dirname $(realpath $0))
main () {
    for i in $@; do
        echo Copying without git $i to #$scriptLoc
        copyParentsNotGit $i
    done
    removeGitFiles
    mv ./home/$(basename $HOME) ./HomeDir
    rm -r ./home

}

copyParentsNotGit () {
    if [[ $1!=\.git* ]]; then

        NotGitFiles=$(find $1 -not -path \*\.git\*)
        for file in $NotGitFiles; do
            cp -lr --parents $file ./
        done

        # I cannot figure out how to exclude the git files and include the parents simultaneously, fuck it, who cares, there dot files and I have an ssd, I'll just delete them after the fact.
        # These don't work
#        find $1 -not -path \*\.git\*                 \
#                   -exec echo cp -lr --parents {} ./ \;
#        find $1 -not -path \*\.git\* \
#             -exec cp -lr --parents {} ./ \;
#        find $i -not -name \.git\* -exec echo cp -lr --parents {} ./ \;
#        find $i -not -name \.git\* -exec cp -lr --parents {} ./ \;

    fi
}

removeGitFiles () {
    # WARNING DRAGONS!!!!
    # [[https://unix.stackexchange.com/a/249503][Source]]
      # There has to be a less dicey way to do this
    # Don't touch it, one wrong space and well ...

#    find ./ -name \*\.git\* -exec rm -rvf {} +
    echo "Remove the .git files yourself, not gonna automate
 4           anything with rm -rfv"

    #Note: the + at the end will result in rm -rv file1 file2 ... while action of \; will be rm -rv file1; rm -rv file2; ...
    # could also have piped to xargs or used loop
}




#  WildCards are fine 
# NO Trailing Whitespace or comments between args !!!
   # (delete-trailing-whitespace) =SPC x d w=

# Don't backup .vim, because the plugins are managed seperately anyway
# Same with emacs, use the dotfiles to keep them in sync, not the actual files
  # If you need to install spacemacs:
     # 1. `snap install --classic emacs; git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d`
     # 2. sync the dotfiles and let spacemacs update automagically
# Do backup all of .config/fish because then you get history!
~/.config/omf*

main \
    ~/.bashrc            \
    ~/.profile           \
    ~/.config/autostart  \
    ~/.zshrc             \
    ~/.zprofile          \
    ~/.oh-my-zsh         \
    ~/.config/fish       \
    ~/.config/omf*       \
    ~/.inputrc           \
    ~/.config/i3         \
    ~/.conky*            \
    ~/.config/nvim/init.vim       \
    ~/.config/systemd    \
    ~/.systemd           \
    ~/.spacemacs         \
    ~/.config/ranger     \
    ~/bin                \
    ~/.xmodmap           #END

exit 0





## vim:fdm=expr:fdl=0
## vim:fde=getline(v\:lnum)=~'^##'?'>'.(matchend(getline(v\:lnum),'##*')-2)\:'='
