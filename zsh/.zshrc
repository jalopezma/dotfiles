## Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# Don't show tracball battery
SPACESHIP_BATTERY_SHOW="true"
SPACESHIP_KUBECTL_CONTEXT_SHOW="false"
SPACESHIP_DOCKER_SHOW="false"

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_all_dups   # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

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
plugins=(zsh-autosuggestions H-S-MW z dotenv)

# https://github.com/jeffreytse/zsh-vi-mode
# plugins+=(zsh-vi-mode)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

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

# Add brew to PATH
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin


# We define a computer to differentiate config
HOSTNAME=$(hostname)
if [[ $HOSTNAME == 'Y-1123' ]]; then
  export COMPUTER='LAPTOP'
elif [[ $HOSTNAME =~ 'publicisgroupe.net' ]]; then
  export COMPUTER='MAC'
else
  export COMPUTER='DESKTOP'
fi
echo $COMPUTER > /tmp/computer

# For kubernetes
export GPG_TTY=$(tty)

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
alias gcma="g checkout main"
alias gpma="g pull upstream main"
alias gcms="g checkout master"
alias gpms="g pull upstream master"
alias gs="g status"
alias gc.="g checkout ."
alias gch="g checkout"
alias gco="g commit"
alias gd="g diff"
alias gds="g diff --staged"
alias gb="g branch"
alias gsw="g switch"
alias gr="g rebase"

alias d="databricks"

#alias do="docker"
#alias dc="docker compose"

alias p="pipenv"


# docker
alias docker-compose="docker compose"
# create a file in /bin/docker-compose and set the content to
# docker compose --compatibility "$@"
# sudo chmod +x /bin/docker-compose
alias docker-stop-all="docker stop $(docker ps -a -q)"

alias t=terraform

# Firefox is using snap
alias update-all="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"

alias l="eza --long --git --icons=always"
alias la="eza --long --all --git --icons=always"
alias cp="cp -i"

alias kx="kubectx"
alias kn="kubens"
alias k="kubectl"

alias kp="k get pods"
alias kpw="k get pods -w"
alias kl="k logs -f"
function ke() {
  local pod_name=$1
  if [[ -z $pod_name ]]; then
    echo "Missing pod name. Usage:"
    echo " ke <pod-name>"
    echo " k exec -it <pod-name> -- bash"
    return
  fi
  k exec -it $pod_name -- bash
}


alias tag="cd ~/repos/YieldifyLabs/khaleesi-tag"
alias builder="cd ~/repos/YieldifyLabs/khaleesi-tag-delivery"

function init_ssh() {
  if [[ -z $SSH_AGENT_PID ]]; then
    echo "init ssh: Seting up ssh-agent"
    eval `ssh-agent`
  else
    # Do something knowing the pid exists, i.e. the process with $PID is running
    echo "init ssh: ssh-agent is already running. PID: ${SSH_AGENT_PID}"
  fi
}

alias sshy="init_ssh && ssh-add ~/.ssh/yieldify.key"
alias sshp="init_ssh && ssh-add ~/.ssh/personal.key"

# Yieldify aliases
#alias helm="echo 'Use helm2 (for kops) or helm3 (for eks) binaries'"

# We wrap the yieldify function from faceless to load it only when called the first time
function yieldify() {
  which yieldify_fn &> /dev/null
  if [[ $? -ne 0 ]]; then
    # Rename `yieldify` by `yieldify_fn` so we can wrap it with the same name
    initFacesless=$(_facelesscmd env init 2>/dev/null | sed -e 's/yieldify/yieldify_fn/g')
    if [[ $? -ne 0 ]]; then
      echo "Error: faceless is not installed"
      return
    fi
    eval "$initFacesless"
  fi

  yieldify_fn "$@"
}

function y() {
  yieldify "$@"
}

function ys() {
  local env=$1
  echo "> yieldify aws switch $env"
  yieldify aws switch $env
}

function yclone() {
  local repo_name=$1

  if [[ -z "$repo_name" ]] ; then
    echo "Parameter missing. Example:"
    echo "$ yclone <repo-name>"
    return
  fi

  if [[ -d "$HOME/repos/YieldifyLabs/${repo_name}" ]]; then
    echo "Folder already exists. Going there"
    cd "$HOME/repos/YieldifyLabs/${repo_name}"
    return
  fi

  echo "Folder doesn't exists. Creating"

  cd ~/repos/YieldifyLabs && \
    g clone git@github.com:jalopezma/$repo_name.git \
    && cd $repo_name

  echo "$repo_name cloned. Adding upstream"
  g remote add upstream git@github.com:YieldifyLabs/$repo_name.git
}

# sudo xbacklight -set $1
# You will need to run `➜ sudo usermod -a -G video $LOGNAME`
# to no need to run it using sudo
function bl() {
  local value=$1

  if ! [[ $value =~ '^[0-9]+$' ]]; then
    echo "Value must be a number. \"${value}\" not valid"
    return
  fi

  if [[ $value -gt 100 ]] || [[ $value -lt 0 ]]; then
    echo "Set a value between 0 and 100. \"${value}\" not valid"
    return
  fi

  xbacklight -set $value
}
alias setbrightness="sudo sh -c 'echo 3000 > /sys/class/backlight/intel_backlight/brightness'"

# kill bluetooth
alias killbluetooth="ps -aux | grep blue | grep -v 'grep' | tr -s ' ' | cut -d ' ' -f 2 | xargs sudo kill -9"

# gvm
alias gvm-init="source \"$HOME/.gvm/scripts/gvm\""

# Yieldify vpn
alias yv="yvpn.sh"
# restart
alias yvr="yv && yv"
# status
alias yvs="openvpn3 sessions-list"


# Use trash instead of rm
# https://github.com/andreafrancia/trash-cli
# alias rm="echo 'rm disabled. run /usr/bin/rm or use trash'"

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

if [[ -f ~/.npmrc && -r ~/.npmrc ]]; then
  export GH_PACKAGE_TOKEN=$(cat ~/.npmrc | sed -e 's/^\/\/npm.pkg.github.com\/:_authToken=\(.*\)$/\1/' -e 't' -e 'd')
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
}

# In mac I couldn't make it work by the normal means so using Alex's alternative way
helm_secrets_edit () {
  ENV=$1 
  if [ -z "$ENV" ]
  then
    echo "No environment specified."
    return 1
  fi
  ys $ENV
  cd tools/charts/${PWD##*/} || return
  AWS_SDK_LOAD_CONFIG=1 helm secrets edit helm_vars/"$ENV"/eu-west-1/secrets.yaml
}

# https://github.com/zdharma/history-search-multi-word
# zstyle ":history-search-multi-word" page-size "8"

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# check if pyenv is present before trying to init it
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
which pyenv &> /dev/null
if [[ $? -eq 0 ]]; then
  eval "$(pyenv init -)"
fi

# Set up fzf key bidnings
eval "$(fzf --zsh)"

if [[ $COMPUTER == 'MAC' ]]; then
  export AWS_SDK_LOAD_CONFIG=1
  export AWS_SHARED_CREDENTIALS_FILE=$HOME/.aws/credentials
  export AWS_CONFIG_FILE=$HOME/.aws/config

  # Golang version manager
  [[ -s "/Users/joslopez7/.gvm/scripts/gvm" ]] && source "/Users/joslopez7/.gvm/scripts/gvm"

  # Java version manager
  # export SDKMAN_DIR="$HOME/.sdkman"
  # [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

  export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

  export PATH=$PATH:~/Downloads/nvim-macos/bin
  alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

  # Set up brew in the PATH
fi

if [[ $COMPUTER == 'LAPTOP' ]]; then
  # Anything installed with fzf needs to go below this eval
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi


export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

