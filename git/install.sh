#!/bin/bash
source ./bash/library.sh

print "[git] Link .gitconfig"
createSymlink ~/repos/dotfiles/git/.gitconfig ~/.gitconfig
