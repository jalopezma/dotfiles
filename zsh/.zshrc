# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# tmux
# export TERM=xterm-256color
export EDITOR=vim

# Add go binary to path
export PATH=$PATH:/usr/local/go/bin
# Add robomongo
export PATH=$PATH:/opt/robomongo-0.9.0-rc10-linux-x86_64-33c89ea/bin/robomongo
# Add mongodb
export PATH=$PATH:/usr/bin/mongo

# Add go workspace path
export GOPATH=$HOME/repos/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# Add scripts path
export PATH=$PATH:$HOME/scripts
# Add /usr/local/lib
export PATH=$PATH:/usr/local/lib

# For stack (haskell) add ~/.local/bin
# Add betterlockscreen to PATH:
export PATH=$PATH:$HOME/.local/bin

# NPM Global without sudo
NPM_PACKAGES="$HOME/.npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export XDG_CONFIG_HOME=~/.config
#export VIMINIT="$XDG_CONFIG_HOME/nvim/init.vim"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#
# previous one
#ZSH_THEME="robbyrussell"
ZSH_THEME="spaceship"

# Don't show tracball battery
SPACESHIP_BATTERY_SHOW="false"
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
plugins=(git zsh-autosuggestions history-search-multi-word z)
# https://github.com/zsh-users/zsh-autosuggestions
# plugins=(zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# User configuration

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
alias vi="nvim"
# Git
alias g="git"
# was called `g plum` by Ovi so now it's called mario
alias mario="g pull upstream master"
alias gcm="g checkout master"
alias gs="g status"
alias gc.="g checkout ."
alias gd="g dsf"

alias update-all="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"

alias l="exa --long --git"
alias la="exa --long --all --git"
alias cp="cp -i"
#alias rm='echo "rm is disabled, use remove or trash or /bin/rm instead."'
alias stranger-tunnel-dev="ssh -4 -N -L 6379:stranger.kckpzs.0001.euw1.cache.amazonaws.com:6379 -p 2222 jose.lopez@bastion.yieldify-dev.com 1>&2"
alias stranger-tunnel-staging="ssh -4 -N -L 6379:stranger.pipwu6.0001.euw1.cache.amazonaws.com:6379 -p 2222 jose.lopez@bastion.yieldify-staging.com 1>&2"
alias stranger-tunnel-production="ssh -4 -N -L 6379:stranger.tueblu.0001.euw1.cache.amazonaws.com:6379 -p 2222 jose.lopez@bastion.yieldify-production.com 1>&2"
alias kx="kubectx"
alias kn="kubens"
alias kc="kubectl"

alias tag="cd ~/repos/YieldifyLabs/khaleesi-tag"
alias builder="cd ~/repos/YieldifyLabs/khaleesi-tag-delivery"
alias iron="cd ~/repos/YieldifyLabs/ironbank"
alias gendry="cd ~/repos/YieldifyLabs/gendry/packages"

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


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# start nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# export npm token
if [[ -f .npmrc && -r .npmrc ]]; then
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
}

# browserstack
export EXEC_REMOTE=false
export BS_USER=joselopez47
export BS_ACCKEY=eM3sYRp1Q9Cr4ND72g3L

# EXEC_REMOTE=true \ BS_USER=joselopez47 \ BS_ACCKEY=eM3sYRp1Q9Cr4ND72g3L npm test

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/joselopez/repos/YieldifyLabs/khaleesi-tag-delivery/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/joselopez/repos/YieldifyLabs/khaleesi-tag-delivery/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/joselopez/repos/YieldifyLabs/khaleesi-tag-delivery/node_modules/tabtab/.completions/sls.zsh ]] && . /home/joselopez/repos/YieldifyLabs/khaleesi-tag-delivery/node_modules/tabtab/.completions/sls.zsh

# Auto-switch node version based on the project's package lock version
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default) ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# browserstack
export EXEC_REMOTE=false
export BS_USER=joselopez47
export BS_ACCKEY=eM3sYRp1Q9Cr4ND72g3L

# to add a check for the machine here and run only if its the laptop
#
# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
# [[ -f /home/joselopez/repos/YieldifyLabs/khaleesi-tag-delivery/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/joselopez/repos/YieldifyLabs/khaleesi-tag-delivery/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
# [[ -f /home/joselopez/repos/YieldifyLabs/khaleesi-tag-delivery/node_modules/tabtab/.completions/sls.zsh ]] && . /home/joselopez/repos/YieldifyLabs/khaleesi-tag-delivery/node_modules/tabtab/.completions/sls.zsh

# Load faceless (yieldify command)
# eval $(_facelesscmd env init)

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
# [[ -f /home/joselopez/repos/YieldifyLabs/khaleesi-tag-delivery/node_modules/tabtab/.completions/slss.zsh ]] && . /home/joselopez/repos/YieldifyLabs/khaleesi-tag-delivery/node_modules/tabtab/.completions/slss.zsh

# export AWS_SDK_LOAD_CONFIG=1
# export AWS_SHARED_CREDENTIALS_FILE=$HOME/.aws/credentials
# export AWS_CONFIG_FILE=$HOME/.aws/config
