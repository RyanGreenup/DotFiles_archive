#!/bin/bash
# Don't forget to adjust the permissions with:
#chmod +x ~/somecrazyfolder/script1

## Program


### Description
# This will print 'Hello World' to the STDOUT.

### Code
echo "Hello World"




## vim:fdm=expr:fdl=0
## vim:fde=getline(v\:lnum)=~'^##'?'>'.(matchend(getline(v\:lnum),'##*')-2)\:'='
