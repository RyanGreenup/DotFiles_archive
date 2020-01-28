#!/bin/bash
# Don't forget to adjust the permissions with:
#chmod +x ~/somecrazyfolder/script1

# use spacemacs and:
  #Use C-c C-n and C-c C-x and C-c C-z and C-c C-( and sh-if and sh-for
  # There's also snippets, use =company-yasnippet=
    # LaTeX in Vim but Bash in emacs
        # Probably R in Rstudio (and some vim for math and maybe emacs for folding)



## Program

### Description
# This will search and filter tags in the ~/Notes directory, returning results into temporary file and working from that

### Code

     cd ~/Notes/MD/notes

## Help Statement
if [ "$1" == "-h" ] || [ "$1" == "--help"  ]; then
  echo "

Table of Contents
─────────────────

1. `basename $0`
2. `basename $0` -s
.. 1. `basename $0` -s m/e/z/t/c


1 `basename $0`
═══════════════

  This will offer, concurrently, tags to filter notes by and write files
  that match into a temporary file.


2 `basename $0` -s
════════════════════

  This will create symlinks to the filtered files and use ag to locate
      the last tags line number.


2.1 `basename $0` -s m/e/z/t/c
────────────────────────────────

  This will open that directory in /MarkText/, emacs, /Zettler/,
  	/Typora/ or /VSCode/ respectively.

	       "
  exit 0
elif [[ "$1" == *-s* ]]; then
     # make sure newlines not spaces are seperators
      IFS=$'\n'

     # restore the last TagValue
     tagval=$(cat /tmp/thelasttagfromTagFilter)
     # This is supposed to be run second,
     # In order to take the filtered tags and put them in the symlinked directory
     echo "Symlinking and Showing the Filtered tags"
     mkdir 00TagMatch
      rm 00TagMatch/*
      ln -s $(realpath $(cat 00TagMatchList)) ./00TagMatch; rm 00TagMatchList
      cd 00TagMatch;
      sag -f "\s#$tagval" ./
      if [[ "$2" == *m* ]]; then
          marktext . & disown;
      fi
      if [[ "$2" == *t* ]]; then
          typora . & disown;
      fi
      if [[ "$2" == *e* ]]; then
          emacsclient --create-frame . & disown
      fi
      if [[ "$2" == *z* ]]; then
          zettlr . & disown
      fi
      if [[ "$2" == *c* ]]; then
          code . & disown
      fi
else
    # This is supposed to be run first, as many times as necessary
    # It will filter out the tags

      # Make new line Characters seperators for for loops
      IFS=$'\n'

      # Make a temp file to store results if necessary
     if test -f 00TagMatchList; then
            	echo "subsequent search";
     else
              # List in order of modification Date, top newest
            	ls -t *.md > 00TagMatchList; 
     fi
     
     # Have the user choose a tag from all the tag matches
#     tagval=$(for i in $(cat 00TagMatchList); do
#        rg --pcre2 --no-pcre2-unicode --no-filename '(?<=[\n\s]#)[a-zA-z]+(?=[\s\n$])' -o $i;
#     done | fzf)

	     # Remove Duplicates (This is slower, because the tags are listed by recency by default,
                     #  duplicates act as frequency for fzf I guess shrug)
#	     tagval=$(for i in $(cat 00TagMatchList); do
#	        rg --pcre2 --no-pcre2-unicode --no-filename '(?<=[\n\s]#)[a-zA-z]+(?=[\s\n$])' -o $i;
#	     done | sort -u | fzf)


    # Don't do the loop, this is like 10 times faster
        # With Repetition
     # tagval=$(cat 00TagMatchList | xargs -d '\n' rg --pcre2 --no-pcre2-unicode --no-filename '(?<=[\n\s]#)[a-zA-z]+(?=[\s\n$])' -o | fzf)
         # Duplicates Removed
     tagval=$(cat 00TagMatchList | xargs -d '\n' rg --pcre2 --no-pcre2-unicode --no-filename '(?<=[\n\s]#)[a-zA-z]+(?=[\s\n$])' -o | sort -u | fzf)


     # Return any files that contain that tag 
       # TODO join this with the above step for efficiency
     # Have ripgrep find files that contain that tag
      if [[ -z $tagval ]]; then
          echo '
 	         wait for fzf to finish otherwise ripgrep has
		 nothing with which to filter files with and
		 returns everything, recursively, 
		 TODO This breaks symlinks but shouldnt?
 	 '
          exit 1
      else
	     cat 00TagMatchList | xargs rg ":$tagval:|\s#$tagval\s" -l > 00TagMatchList;
      fi
     
     # Space 
     echo "
     
     "

     # Print Tags
     bat 00TagMatchList

     # Save the last used tag so you can use `ag` on the preview later with it
     echo $tagval > /tmp/thelasttagfromTagFilter
     
     exit 0
fi

## vim:fdm=expr:fdl=0
## vim:fde=getline(v\:lnum)=~'^##'?'>'.(matchend(getline(v\:lnum),'##*')-2)\:'='



# If you need GNU tools, use grep not ripgrep
    # grep -P --no-filename '(?<=[\n\s]#)[a-zA-z]+(?=[\s\n$])' -o $i;
