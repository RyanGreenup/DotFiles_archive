#!/bin/bash
## This will fail if resources are not found in the path,
## So, instead of taking the input from the clipboard,
## this should be executed from the directory of the
## Markdown file, Pointing to the markdown file.

## Steps
## 1. Change to the MD File Location using realpath
## 2. Execute essentially this scripts
## 3. Decide whether to put the output in tmp or in the same Location
  ## I think the same location tbh.


function main() {
  parseArguments
  echo parsed
  WriteClipboardToFile
  echo made file
  ConvertToHTML
  echo first html
  AddMathJaxandStyle
  echo finally done
}

  function WriteClipboardToFile() {
    ClipFile=$(mktemp)
#    trap "rm $ClipFile" EXIT
    xclip -o -selection clipboard > $ClipFile.md
    echo $ClipFile.md
  }

  function ConvertToHTML() {
  echo $ClipFile.md
    pandoc -f markdown -t html -s --self-contained $ClipFile.md -o $ClipFile.html
  }

  function AddMathJaxandStyle() {
    CreateStyle
    pandoc -f html -t html $ClipFile.html -s -B $wrapped --mathjax -o $ClipFile.html
    atom $ClipFile.html
  }

  function CreateStyle() {
    wrapped=$(mktemp)
#    trap "rm $wrapped" EXIT

    echo "<style>" > $wrapped
    cat $style >> $wrapped
    echo "</style>" >> $wrapped
#    echo "<script type="text/javascript" async
#  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
  }

function parseArguments() {
  if [[ $1="" ]]; then
    style=~/Templates/CSS/jekyllTypora.css
  else
    echo "Using $style becuase nothing specified"
    style=$2
  fi
}
main
