#!/bin/bash

# Exit inmediatly if exits with a non-zero status.
set -o errexit
# The return value of a pipeline is the value of the last (right-most) command to exit with a non-zero status, or zero if all commands in the pipeline exit successfully.
set -o pipefail
# Treat unset variables and parameters other than the special parameters "@" and "*" as an error when performing parameter expansion. If expansion is attempted on an unset variable or parameter, the shell prints an error message, and, if not interactive, exits with a non-zero status.
set -o nounset

source ./functions.sh

echo "[zsh] install.sh"
sudo apt-get install zsh -y &> /dev/null

echo "[zsh] Install oh my zsh"
#   --unattended: sets both CHSH and RUNZSH to 'no'
#   --keep-zshrc: sets KEEP_ZSHRC to 'yes'
sh -c "$(wget -q -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc &> /dev/null

if [[ -f ~/.zshrc ]]; then
  echo "[zsh] .zshrc already exists. Moving it to ~/.zshrc.old"
  mv ~/.zshrc ~/.zshrc.old
fi
echo "[zsh] Link .zshrc"
createSymlink ~/repos/dotfiles/zsh/.zshrc ~/.zshrc

echo "[zsh] Install theme spaceship-prompt"
# until we don't user zsh, the var is not set
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1 2>&1
createSymlink "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Plugins
echo "[zsh] Plugin zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>&1

echo "[zsh] Plugin H-S-MW (History Search Multi Word)"
git clone https://github.com/z-shell/H-S-MW.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/H-S-MW 2>&1

echo "[zsh] Plugin zsh-completions"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions 2>&1

echo "[zsh] Plugin zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>&1

echo "[zsh] Set zsh by default"
chsh -s $(which zsh)
echo "[zsh] Shell for $(whoami): $SHELL"
grep $(whoami) /etc/passwd
