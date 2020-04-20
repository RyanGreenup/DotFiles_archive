#!/usr/bin/env bash
# set -euo pipefail

cd ~/Notes/
/home/ryan/.local/bin/mkdocs build
 [ -d "/var/www/html/MD" ] && sudo rm -r /var/www/html/MD
 [ -d "./site" ] && sudo mv site /var/www/html/MD
