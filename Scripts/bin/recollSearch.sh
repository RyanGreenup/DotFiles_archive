#!/bin/bash

recollq -b $1 | cut -c 8- | fzf | xargs atom
