#!/bin/bash
# Exit inmediatly if exits with a non-zero status.
set -o errexit
# The return value of a pipeline is the value of the last (right-most) command to exit with a non-zero status, or zero if all commands in the pipeline exit successfully.
set -o pipefail
# Treat unset variables and parameters other than the special parameters "@" and "*" as an error when performing parameter expansion. If expansion is attempted on an unset variable or parameter, the shell prints an error message, and, if not interactive, exits with a non-zero status.
set -o nounset

showHelp() {
  # To update the link to the script
  echo "
$ ./install.sh <arguments>
$ sh -c "\$\(wget -O- https://raw.githubusercontent.com/jalopezma/dotfiles/master/install.sh\)" "" <arguments>
    -h, --help: Shows this message
    -d, --debug: Sets the xtrace and verbose mode"
}

parseArguments() {
  # $@ is all command line parameters passed to the script.
  # -o is for short options like -v
  # -l is for long options with double dash like --help
  # the comma separates different long options
  # -a is for long options with single dash like -version
  options=$(getopt -l "help,debug" -o "hd" -- "$@")

  # set --:
  # If no arguments follow this option, then the positional parameters are unset. Otherwise, the positional parameters are set to the arguments, even if some of them begin with a ‘-’.
  eval set -- "$options"

  while true; do
    case $1 in
      -h | --help)
        showHelp
        exit 0
        ;;
      -d | --debug)
        set -o xtrace
        set -o verbose
        ;;
      --)
        shift
        break
        ;;
    esac
    shift
  done
}

function install_dependencies() {
  echo "[main] Installation script"
  echo "[main] Update, upgrade and autoremove"
  sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get autoremove -y

  echo "[main] Install wget curl git"
  sudo apt-get install wget curl git -y

  echo "[main] $(git --version)"
}

function clone_repository() {
  REPOS_FOLDER=~/repos
  if [[ -d $REPOS_FOLDER ]]; then
    echo "[main] \"$REPOS_FOLDER\" folder already exists"
  else
    echo "[main] Creating \"$REPOS_FOLDER\" folder"
    mkdir -p $REPOS_FOLDER
  fi
  cd "$REPOS_FOLDER"

  if [[ -d ~/repos/dotfiles ]]; then
    DOTFILES_TMP_FOLDER=/tmp/dotfiles_$(date +%s)
    echo "[main] Move existing dotfiles repo to $DOTFILES_TMP_FOLDER"
    mv ~/repos/dotfiles $DOTFILES_TMP_FOLDER
  fi

  echo "[main] Clone jalopezma/dotfiles.git"
  git clone https://github.com/jalopezma/dotfiles.git 2>&1
  cd ~/repos/dotfiles
  echo "[main] Change directory to $(pwd)"
}

function installation() {
  install_dependencies
  clone_repository
  bash ./post-init-install.sh
}

parseArguments $@
installation
