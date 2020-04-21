#!/usr/bin/env bash
# set -euo pipefail
#
#This is symlinked to /usr/local/bin/ so that:
#
#    + It can be run as root
#    + Remain in the path
#

## Define Server and Notes Location
Server=/home/ryan/Public/html
Notes=/home/ryan/Notes # Location of mkdocs.yml

## Change Directory
cd $Notes/

## Build the Documentation
##
##
if [ "$1" == "-h" ]; then
  echo "Usage: `basename $0`
             # -c or --clean for clean build, defaults to --dirty"
  exit 0
elif [[ "$1" == *-c* || "$1" == *--clean* ]]; then
/home/ryan/.local/bin/mkdocs build --site-dir $Server/MD/
exit 0
else
/home/ryan/.local/bin/mkdocs build --dirty --site-dir $Server/MD/
exit 0
fi
## TODO Clean, Dirty
# /home/ryan/.local/bin/mkdocs build --dirty --site-dir $Server/MD/


## cd /home/ryan/Notes/
## /home/ryan/.local/bin/mkdocs build
##  [ -d "/home/ryan/Public/html/MD" ] && sudo rm -r /home/ryan/Public/html/MD
##  [ -d "./site" ] && sudo mv site /home/ryan/Public/html/MD/
