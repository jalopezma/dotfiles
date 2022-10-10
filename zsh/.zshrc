## Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Export nvm completion settings for zsh-nvm plugin
export NVM_COMPLETION=true
# Lazy loading is around 70x faster (874ms down to 12ms for me), however the first time
# you run nvm, npm, node or a global module you'll get a slight delay while nvm loads first.
# You'll only get this delay once per session.
export NVM_LAZY_LOAD=true
# Loads nvm when neovim is executed
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim')
export NVM_AUTO_USE=true

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# Don't show tracball battery
SPACESHIP_BATTERY_SHOW="true"
SPACESHIP_KUBECONTEXT_SHOW="false"
SPACESHIP_DOCKER_SHOW="false"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# $ git clone https://github.com/lukechilds/zsh-nvm $ZSH/custom/plugins/zsh-nvm
# $ git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# $ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#plugins=(git zsh-autosuggestions history-search-multi-word z zsh-completions docker dotenv zsh-nvm zsh-syntax-highlighting)
plugins=(zsh-autosuggestions history-search-multi-word z zsh-completions dotenv zsh-nvm)

# https://github.com/jeffreytse/zsh-vi-mode
# plugins+=(zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR=nvim

# Add go workspace path
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/repos/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

export PATH=$PATH:~/bin
export PATH=$PATH:$HOME/scripts
export PATH=$PATH:/usr/local/lib
export PATH=$PATH:$HOME/.local/bin

export XDG_CONFIG_HOME=~/.config

# We define a computer to differentiate config
HOSTNAME=$(hostname)
if [[ $HOSTNAME == 'Y-LD-WIN1123' ]]; then
  export COMPUTER='LAPTOP'
else
  export COMPUTER='DESKTOP'
fi
echo $COMPUTER > /tmp/computer


# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias n="nvim"
alias nt="nvim +terminal"
alias vi="nvim"
# Git
alias g="git"
# was called `g plum` by Ovi so now it's called mario
alias mario="g pull upstream master"
alias gcm="g checkout master"
alias gs="g status"
alias gc.="g checkout ."
# Using delta as default git diff https://github.com/dandavison/delta
alias gd="g diff"

# Firefox is using snap. We can run them in paralell
alias update-all="sudo snap refresh & sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"

alias l="exa --long --git"
alias la="exa --long --all --git"
alias cp="cp -i"

alias kx="kubectx"
alias kn="kubens"
alias k="kubectl"

alias tag="cd ~/repos/YieldifyLabs/khaleesi-tag"
alias builder="cd ~/repos/YieldifyLabs/khaleesi-tag-delivery"

alias yieldify-init="eval $(_facelesscmd env init)"

# kill bluetooth
alias killbluetooth="ps -aux | grep blue | grep -v 'grep' | tr -s ' ' | cut -d ' ' -f 2 | xargs sudo kill -9"

# Use trash instead of rm
# https://github.com/andreafrancia/trash-cli
alias rm="echo 'rm disabled. run /usr/bin/rm or use trash'"

# Sets a crontab to remove files over 30 days
# crontab -l to show your crontab
# (crontab -l ; echo "@daily $(which trash-empty) 30") | crontab -

# start vim mode for zsh ###
#bindkey -v

#bindkey '^P' up-history
#bindkey '^N' down-history
#bindkey '^?' backward-delete-char
#bindkey '^h' backward-delete-char
#bindkey '^w' backward-kill-word
#bindkey '^r' history-incremental-search-backward
#
#function zle-line-init zle-keymap-select {
    #VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    #RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$(git_custom_status) $EPS1"
    #zle reset-prompt
#}
#
#zle -N zle-line-init
#zle -N zle-keymap-select
#export KEYTIMEOUT=1
### end vim mode for zsh ###

# export npm token
if [[ -f ~/.npmrc && -r ~/.npmrc ]]; then
  export NPM_TOKEN=$(cat ~/.npmrc | sed -e 's/^.*authToken=//')
fi

# Store the last directory cd'd into so that we can start new shells in the
# same directory.
# Also chmod's it to 600 (rw owner) for a bit of security paranoia
# See ~/.config/i3/config for corresponding command to start urxvt
# Thanks Will!
function cd() {
  builtin cd "$@"
  echo $PWD > /tmp/.last_dir_$UID
  chmod 600 /tmp/.last_dir_$UID

  if [[ -z "$VIRTUAL_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
      if [[ -d ./.venv ]] ; then
        echo "> Enable venv: ./.venv/bin/activate"
        source ./.venv/bin/activate
      fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      parentdir="$(dirname "$VIRTUAL_ENV")"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
        echo "> Disable venv: deactivate"
        deactivate
      fi
  fi
}

# https://github.com/zdharma/history-search-multi-word
# zstyle ":history-search-multi-word" page-size "8"

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

if [[ $COMPUTER == 'LAPTOP' ]]; then
  export AWS_SDK_LOAD_CONFIG=1
  export AWS_SHARED_CREDENTIALS_FILE=$HOME/.aws/credentials
  export AWS_CONFIG_FILE=$HOME/.aws/config

  # Load faceless (yieldify command)
  # eval $(_facelesscmd env init)

  # Load pyenv automatically by appending
  # the following to ~/.bash_profile if it exists, otherwise ~/.profile (for login shells)
  # and ~/.bashrc (for interactive shells) :
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"

  # Restart your shell for the changes to take effect.
  # Load pyenv-virtualenv automatically by adding
  # the following to ~/.bashrc:
  # eval "$(pyenv virtualenv-init -)"

  # Golang version manager
  [ -s "$HOME/.gvm/scripts/gvm" ] && source "$HOME/.gvm/scripts/gvm"

  # Java version manager
  # [ -s "/home/jose/.jabba/jabba.sh" ] && source "/home/jose/.jabba/jabba.sh"
fi
