#!/bin/bash

# Helps to print the output of the command if the verbose flag is set
run() {
  local output=$1
  local verbose=${2:-false}
  if $verbose; then
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
    echo "[zsh] File $to already exists"
  else
    run "$(ln -s $from $to)" $verbose
  fi
}

logFile=$1
verbose=$2

print "[zsh] install.sh"
run "$(sudo apt-get install zsh -y)"

print "[zsh] $(zsh --version)"
print "[zsh] Link .zshrc"
createSymlink ~/repos/dotfiles/zsh/.zshrc ~/.zshrc

print "[zsh] Install oh my zsh"
run "$(sh -c "$(wget -q -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc 2>&1)"

print "[zsh] Install theme spaceship-prompt"
# until we don't user zsh, the var is not set
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
run "$(git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" 2>&1)"
createSymlink "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# https://github.com/zplug/zplug
print "[zsh] Install zplug"
run "$(curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh)"

# Plugins
print "[zsh] Plugin zsh-autosuggestions"
run "$(git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>&1)"

print "[zsh] Plugin history-search-multi-word"
run "$(git clone git@github.com:zdharma/history-search-multi-word.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom/plugins/history-search-multi-word} 2>&1)"

print "[zsh] Plugin zsh-completions"
run "$(git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom/plugins/zsh-completions} 2>&1)"

print "[zsh] Set zsh by default"
chsh -s $(which zsh)
print "[zsh] Shell for $(whoami): $SHELL"
grep $(whoami) /etc/passwd
