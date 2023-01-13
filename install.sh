#!/bin/bash
verbose=false
logFolder=/tmp/jalopezma-install
logFile="$logFolder/install.log"

setLogFile() {
  if [ ! -d "$logFolder" ]; then
    mkdir $logFolder
  fi

  if [ ! -f "$logFile" ]; then
    touch $logFile
  fi

  echo "$(date)" >> $logFile
}

# Helps to print the output of the command if the verbose flag is set
run() {
  local output=$1
  local verbose=${2:-false}
  if $verbose && [ ! -z $output ]; then
    echo "$output"
  fi
  echo "$output" >> $logFile
}

# Prints to stdout and log file
print() {
  echo "$1"
  echo "$1" >> $logFile
}

createSymlink() {
  local from=$1
  local to=$2
  if [ -f $to ] || [ -d $to ]; then
    echo "[main] File/folder \"$to\" already exists"
  else
    run "$(ln -s $from $to)" $verbose
  fi
}

showHelp() {
  # To update the link to the script
  echo "
$ ./install.sh <arguments>
$ sh -c "\$\(wget -O- https://raw.githubusercontent.com/jalopezma/dotfiles/master/install.sh\)" "" <arguments>
    -h, --help: Shows this message
    -v, --verbose: Enables a more verbose output
    -d, --debug: Sets the xtrace and verbose mode"
}

parseArguments() {
  # $@ is all command line parameters passed to the script.
  # -o is for short options like -v
  # -l is for long options with double dash like --help
  # the comma separates different long options
  # -a is for long options with single dash like -version
  options=$(getopt -l "help,debug,verbose" -o "hdv" -- "$@")

  # set --:
  # If no arguments follow this option, then the positional parameters are unset. Otherwise, the positional parameters are set to the arguments, even if some of them begin with a ‘-’.
  eval set -- "$options"

  while true
  do
  case $1 in
  -h|--help)
      showHelp
      exit 0
      ;;
  -v|--verbose)
      export verbose=true
      ;;
  -d|--debug)
      set -xv  # Set xtrace and verbose mode.
      ;;
  --)
      shift
      break;;
  esac
  shift
  done
}

parseArguments $@
setLogFile

print "[main] install.sh"
print "[main] update & upgrade"
run "$(sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get autoremove -y)" $verbose

print "[main] Install wget curl git firefox flameshot snapd"
run "$(sudo apt-get install wget curl git firefox flameshot snapd -y)" $verbose
print "[main] $(git --version)"

googleChromeVersion=$(google-chrome --version)
if [[ $? -eq 0 ]]; then
  print "[main] Google chrome already installed ${googleChromeVersion}"
else
  print "[main] Download Google chrome"
  run "$(wget -q -P /tmp/ https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb)" $verbose
  print "[main] Install Google chrome"
  run "$(sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb)" $verbose
fi

reposFolder=~/repos
if [ -d $reposFolder ]; then
  print "[main] \"$reposFolder\" folder already exists"
else
  print "[main] Create \"$reposFolder\" folder"
  mkdir -p $reposFolder
fi
cd "$reposFolder"

if [ -d ~/repos/dotfiles ]; then
  dotfilesTmp=/tmp/dotfiles_$(date +%s)
  print "[main] Move existing dotfiles repo to $dotfilesTmp"
  mv ~/repos/dotfiles $dotfilesTmp
fi
print "[main] Clone jalopezma/dotfiles.git"
run "$(git clone https://github.com/jalopezma/dotfiles.git 2>&1)" $verbose
cd ~/repos/dotfiles
print "[main] Change directory to $(pwd)"

print "[fonts] Copy Ubuntu font"
mkdir -p ~/.fonts
run "$(cp fonts/Ubuntu\ Mono\ Nerd\ Font\ Complete.ttf ~/.fonts/)"

print "[scripts] Link scripts"
createSymlink ~/repos/dotfiles/scripts ~/scripts

print "[wallpapaers] Link wallpapers"
createSymlink ~/repos/dotfiles/wallpapers ~/wallpapers

bash ./git/install.sh "$verbose"
bash ./zsh/install.sh "$verbose"
bash ./nvm/install.sh "$verbose"
bash ./nvim/install.sh "$verbose"
bash ./tmux/install.sh "$verbose"

bash ./rofi/install.sh "$verbose"
bash ./monitors/install.sh "$verbose"
bash ./i3/install.sh "$verbose"
bash ./polybar/install.sh "$verbose"
bash ./alacritty/install.sh "$verbose"
bash ./beekeper-studio/install.sh "$verbose"

# Already installed ✓
# git
# zsh
# nvm
# nvim
# tmux
#
# rofi
# monitors - script/service
# i3
# polybar
# alacritty
# beekeeperstudio

# ssh: keys and agent?
# aws credentials ?
# programs that I use
# - bluetooth?
# - yvpn
# - pyenv
# - gvm (golang virtual manager)
