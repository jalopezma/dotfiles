#!/bin/bash
# Exit inmediatly if exits with a non-zero status.
set -o errexit
# The return value of a pipeline is the value of the last (right-most) command to exit with a non-zero status, or zero if all commands in the pipeline exit successfully.
set -o pipefail
# Treat unset variables and parameters other than the special parameters "@" and "*" as an error when performing parameter expansion. If expansion is attempted on an unset variable or parameter, the shell prints an error message, and, if not interactive, exits with a non-zero status.
set -o nounset

source ./functions.sh

function install_diff_so_fancy() {
  echo "[diff_so_fancy] Download script"
  curl -o diff-so-fancy --location \
    $(curl -s https://api.github.com/repos/so-fancy/diff-so-fancy/releases/latest |
      grep -Po 'https://github.com/so-fancy/diff-so-fancy/releases/download/.*/diff-so-fancy' |
      uniq)
  chmod +x ./diff-so-fancy
  mv ./diff-so-fancy ~/.local/bin/
}

function install_git_delta() {
  echo "[git] Download git-delta"
  curl -o /tmp/git-delta_amd64.deb --location \
    $(curl -s https://api.github.com/repos/dandavison/delta/releases/latest |
      grep -Po 'https://github.com/dandavison/delta/releases/download/.*git-delta_.*_amd64.deb' |
      uniq)
  chmod +x /tmp/git-delta_amd64.deb
  sudo dpkg -i /tmp/git-delta_amd64.deb
}

echo "[git] Link .gitconfig"
createSymlink ~/repos/dotfiles/git/.gitconfig ~/.gitconfig

echo "[git] Set user name and email"
git config --global user.name "Jose Lopez"
git config --global user.email "joseadrian.lopezmartin@gmail.com"

install_diff_so_fancy
install_git_delta
