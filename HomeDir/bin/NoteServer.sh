#!/bin/bash
# Don't forget to adjust the permissions with:
#chmod +x ~/somecrazyfolder/script1

## Program


### Description
# This will print 'Hello World' to the STDOUT.

### Code
cd / # Do it from / because then you can more easily use 
         # Vims %, e.g.
	    # :! chromium "http://%"
python3 -m http.server 8128

echo "Local Python 3 server started on 8128,
      Listening on LocalHost,
      served from /
      use ps -ef to find the PID in order to kill it, 
      you could pipe this into grep and awk like so


ps -ef | grep 'python3 -m http.server 8128' | awk '{print \$2}' | xargs sudo kill


"



## vim:fdm=expr:fdl=0
## vim:fde=getline(v\:lnum)=~'^##'?'>'.(matchend(getline(v\:lnum),'##*')-2)\:'='

