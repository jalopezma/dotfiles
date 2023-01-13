#!/bin/bash

dir=$(cat /tmp/.last_dir_$UID || echo $HOME)
alacritty --working-directory="$dir"
