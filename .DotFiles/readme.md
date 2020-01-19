---
tags: [Notebooks/bash]
title: Syncing Dotfiles
created: '2020-01-17T08:42:52.935Z'
modified: '2020-01-17T08:43:47.976Z'
---

# Syncing Dotfiles

The easiset way to sync your dot files is to:

1. Create a directory just for dotfiles, ideally `~/Dropbox/.DotFiles`.

2. Execute the following where `[[MYDOTFILES]]` is the path to any dotfile (or folder of dotfiles) you wish to back up:

   * `cd ~/Dropbox/.DotFiles` `
   * `cp -lr --parents [[MYDOTFILES]] ./`

so for example any of these is fine:

   * `cp -lr --parents ~/.config ./`
   * `cp -lr --parents ~/.bashrc ./`

3. henceforth presuming it is only desirable to back up personal DotFiles (alter accordingly):

   * `cd  home/ `
   * `mv $(basename $HOME) HomeFolder`
   * `echo 'rsync -av HomeFolder/ $HOME' > install.sh`
     * the trailing slashes are super important here.

4. At this stage I would recommend making a git to track the changes:
   
    * `git init; git add .; git commit -m "First Commit"`
    
    * if you have a repository you want to use for dotfiles:
    
      * ```bash
        git remote add origin URL-FOR-REPO; # set remote location
        git remove -v # Verify URL
        git push -u origin master # Pushes to master
        ```
        
        * you may end up having embedded git repo's, don't sync all of `~/.vim` because it's just plugins and don't sync all of `~/.emacs.d` again because all of the plugins, let the respective package managers deal with that and you worry about setting files; If there are embedded git repos just delete the `.git` directories manually, don't write something like `find ./ -name \*\.git\* -exec rm -rvf {} +`, you're just going to make a mess of your home directory by mistake.
5. Now the idea is to create Hardlinks from this git repo and/or cloud folder so that all changes are synced,hardlinks help here because, hardlinks point to the same inode value meaning:

    * If one file is deleted from dropbox, nothing changes
    * If the file changes in either location both files will sync to represent that change
    * Git will push Hardlinks as if they were ordinary files
	* I believe pulling will break the hardlink though, so the idea is to have this dotfile repo as the master and always make hardlinks out of it after pulling by using `rdfind`

In order to do this use `rdfind` like so:

```bash
# rdfind -makehardlinks true master slave
    # Master slave isn't quite the right term but whatever.
       # you can also give it more directories 
         # in order of descending precedence.

rdfind -makehardlinks true HomeFolder $HOME
```

This will go through, find any identical files and replace them with hardlinks, it will only do this to identical files and it will not remove anything, they will be hardlinks so there is no real risk of data loss.

## Installation Instructions

In order to install these dotfiles:

1. Clone the Repo
    * `cd ~/Downloads; git clone URL`
2. remove all the dotfiles you don't want
3. `rsync -av HomeFolder/ $HOME`
4.  `rdfind -makehardlinks true HomeFolder/ $HOME` to replace them with hardlinks.
    1. this is going to be really helpful if the files are on the cloud
        1. even if they're not though, making a habit of hardlinking will help keep you sane


### Included Files

Currently I'm syncing `:r ./copyDotFiles.sh`:


* Shells
cp -lr --parents ~/.bashrc        ./
cp -lr --parents ~/.profile       ./
cp -lr --parents ~/.zshrc         ./
cp -lr --parents ~/.zprofile      ./
cp -lr --parents ~/.config/fish   ./
cp -lr --parents ~/.inputrc       ./
* DE
cp -lr --parents ~/.config/i3*    ./
cp -lr --parents ~/.conky*        ./
* Vim
~/.vim*  ./
cp -lr --parents ~/.config/nvim   ./
* Emacs
cp -lr --parents ~/.config/systemd*./
cp -lr --parents ~/.emacs*         ./
cp -lr --parents ~/.spacemacs*     ./
* Ranger
cp -lr --parents ~/.config/ranger* ./

* Binaries
cp -lr --parents ~/bin         ./

* Shells
cp -lr --parents ~/.bashrc        ./
cp -lr --parents ~/.profile       ./
cp -lr --parents ~/.zshrc         ./
cp -lr --parents ~/.zprofile      ./
cp -lr --parents ~/.config/fish   ./
cp -lr --parents ~/.inputrc       ./
* DE
cp -lr --parents ~/.config/i3*    ./
cp -lr --parents ~/.conky*        ./
* Vim
rsync -av --exclude=".*" ~/.vim*  ./
cp -lr --parents ~/.config/nvim   ./
* Emacs
cp -lr --parents ~/.emacs*         ./
cp -lr --parents ~/.spacemacs*     ./
* Ranger
cp -lr --parents ~/.config/ranger* ./

* Binaries
cp -lr --parents ~/bin         ./


