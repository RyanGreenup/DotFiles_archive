#!/bin/bash
# Don't forget to adjust the permissions with:
#chmod +x ~/somecrazyfolder/script1

# use spacemacs and:
  #Use C-c C-n and C-c C-x and C-c C-z and C-c C-( and sh-if and sh-for
  # There's also snippets, use =company-yasnippet=
    # LaTeX in Vim but Bash in emacs
        # Probably R in Rstudio (and some vim for math and maybe emacs for folding)


## Help Statement
if [ "$1" == "-h" ]; then
  echo "Usage: `basename $0` then just press enter
  
 It will pull the repo and overwrite your config files with those 
 from the repos, they'll be replaced as symlinks

 -f will install the dotfiles as actual files,
     this will make syncing a pain, but, it serves as a
     type of uninstall:

         0. If the dotfiles are symlinks, this is already installed so add and commit the repo:
	     git add -u ; git commit
	 1../`basename $0` -f
	      This will overwrite all the symlinks with files
	         Alternatively just cp/mv the files or use sed -i ./, that will also fix it. 
  "
  exit 0
fi

## Program


### Description
# This will pull dot files from git, merge them into the home directory and then replace them with hardlinks so that they will sync over git.

### Code
cd ./HomeDir
git pull

# Copy HomeDir onto Home, HomeDir overwrites Home, '/' are important!
rsync -av $HomeDir/ $HOME



if [ "$1" == "-f" ]; then
rdfind -makehardlinks true $hmDir $HOME;
else 
rdfind -makesymlinks true $hmDir $HOME;
fi






exit 0


## vim:fdm=expr:fdl=0
## vim:fde=getline(v\:lnum)=~'^##'?'>'.(matchend(getline(v\:lnum),'##*')-2)\:'='

