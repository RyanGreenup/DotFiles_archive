#!/bin/bash

# Change Directory
cd ~/Documents/Calendar/


radicale -H 0.0.0.0:5232                                      \
    --storage-type multifilesystem                            \
    --storage-filesystem-folder ./data                        \
    --auth-type htpasswd                                      \
    --auth-htpasswd-filename ./radicale_password.passwd       \
    --ssl                                                     \
        --certificate ./radicale_ssl.cer                          \
        --key         ./radicale_ssl.key                                   "${@}"

