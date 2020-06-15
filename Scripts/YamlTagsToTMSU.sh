#!/bin/bash

## Make New lines not be new commands
IFS=$'\n'

## Loop over every file name.
## For each file name print the contents, get out the front,
## matter, extract the json and then clean it up into 
## a bunch of commands for TMSU.

## Now pass those commands to bash.
for i in $(fd .md); do cat $i | yaml-front-matter | jq .tags | sd '\[|\]|,' '' | sd -s '"' '' | sd  'null.*\n' '' | sd -s 'notebooks/' '' | sd  '/' '\n' | sd '^' "tmsu tag ${i}"; done > /tmp/tmsuTagsScript

  ##   this will fail in really bad ways if files have spaces in the name.









## TODO Rewrite this so it looks like this:

for i in $(fd .md); do cat $i | yaml-front-matter | jq .tags |\
    sd    '\[|\]|,' ''    | \
    sd -s '"' ''          | \ 
    sd    'null.*\n' ''   | \
    sd -s 'notebooks/' '' | \
    sd    '/' '\n' | \
    sd    '^' "tmsu tag ${i}";\
done | \
    bash






## TODO Now obviously this would be much faster
## if I could avoid the for loop, but I can't
## See an easy way to do that.

## I tried something like this but I didn't have any luck.
## find ./ -name '*.md' | xargs cat | yaml-front-matter | jq .tags
## The issue was that the yaml got merged and I need the
## front matter to correspond to each file on it's own
