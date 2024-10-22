# mtxrun
# Autogenerated from man page /usr/share/man/man1/mtxrun.1.gz
complete -c mtxrun -l script --description 'run an mtx script (lua prefered method) (--noquotes), no script gives list.'
complete -c mtxrun -l evaluate --description 'run code passed on the commandline (between quotes).'
complete -c mtxrun -l execute --description 'run a script or program (texmfstart method) (--noquotes).'
complete -c mtxrun -l resolve --description 'resolve prefixed arguments.'
complete -c mtxrun -l ctxlua --description 'run internally (using preloaded libs).'
complete -c mtxrun -l internal --description 'run script using built in libraries (same as --ctxlua).'
complete -c mtxrun -l locate --description 'locate given filename in database (default) or system (--first --all --detail…'
complete -c mtxrun -l autotree --description 'use texmf tree cf.  env texmfstart_tree or texmfstarttree.'
complete -c mtxrun -l tree --description 'use given texmf tree (default file: setuptex. tmf).'
complete -c mtxrun -l environment --description 'use given (tmf) environment file.'
complete -c mtxrun -l path --description 'go to given path before execution.'
complete -c mtxrun -l ifchanged --description 'only execute when given file has changed (md checksum).'
complete -c mtxrun -l iftouched --description 'only execute when given file has changed (time stamp).'
complete -c mtxrun -l makestubs --description 'create stubs for (context related) scripts.'
complete -c mtxrun -l removestubs --description 'remove stubs (context related) scripts.'
complete -c mtxrun -l stubpath --description 'paths where stubs wil be written.'
complete -c mtxrun -l windows --description 'create windows (mswin) stubs.'
complete -c mtxrun -l unix --description 'create unix (linux) stubs.'
complete -c mtxrun -l verbose --description 'give a bit more info.'
complete -c mtxrun -l trackers --description 'enable given trackers.'
complete -c mtxrun -l progname --description 'format or backend.'
complete -c mtxrun -l systeminfo --description 'show current operating system, processor, etc.'
complete -c mtxrun -l edit --description 'launch editor with found file.'
complete -c mtxrun -l launch --description 'launch files like manuals, assumes os support (--all).'
complete -c mtxrun -l timedrun --description 'run a script and time its run.'
complete -c mtxrun -l autogenerate --description 'regenerate databases if needed (handy when used to run context in an editor).'
complete -c mtxrun -l usekpse --description 'use kpse as fallback (when no mkiv and cache installed, often slower).'
complete -c mtxrun -l forcekpse --description 'force using kpse (handy when no mkiv and cache installed but less functionali…'
complete -c mtxrun -l prefixes --description 'show supported prefixes.'
complete -c mtxrun -l generate --description 'generate file database.'
complete -c mtxrun -l variables --description 'show configuration variables.'
complete -c mtxrun -l configurations --description 'show configuration order.'
complete -c mtxrun -l directives --description 'show (known) directives.'
complete -c mtxrun -l experiments --description 'show (known) experiments.'
complete -c mtxrun -l expand-braces --description 'expand complex variable.'
complete -c mtxrun -l resolve-path --description 'expand variable (completely resolve paths).'
complete -c mtxrun -l expand-path --description 'expand variable (resolve paths).'
complete -c mtxrun -l expand-var --description 'expand variable (resolve references).'
complete -c mtxrun -l show-path --description 'show path expansion of .'
complete -c mtxrun -l var-value --description 'report value of variable.'
complete -c mtxrun -l find-file --description 'report file location.'
complete -c mtxrun -l find-path --description 'report path of file.'
complete -c mtxrun -l pattern --description 'filter variables AUTHOR More information about ConTeXt and the tools that com…'

