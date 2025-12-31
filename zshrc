# Add by adding this to the bottom of ~/.zshrc
# source /path/to/dotfiles/zshrc

export ZSH="$HOME/.oh-my-zsh"

DOTFILES_DIR=${0:a:h}

# ZSH_THEME="djf"

eval "$(starship init zsh)"

plugins=(git)

DISABLE_AUTO_TITLE="true"
# Disable with Ghostty
# function title { echo -en "\033]2;$1\007"; }
# function cd {
#   dir=$1;
#   if [ -z "$dir" ];
#   then dir=~; fi;
#   builtin cd "$dir" && title `basename $(pwd)`;
# }
# cd `pwd`

export PATH=$PATH:/opt/homebrew/bin:/usr/local/bin

# Aliases
alias k="kubectl"
alias wk="watch kubectl"
alias dc="docker-compose"
alias vim="nvim"
alias cat="ccat"
alias docker-cleanup-all-containers='docker rm $(docker ps -a -q) -f'
alias dev="cd ~/dev"
alias b64="$DOTFILES_DIR/utils/base64.js"
alias portkill="$DOTFILES_DIR/utils/portkill.js"

export GIT_EDITOR=vim

# Helpers
function reload {
  source ~/.zshrc
  echo "~/.zshrc reloaded"
}
function ipme {
  curl -s icanhazip.com
}
# s <ip-address>
# PEM_KEY="$HOME/x.pem"
function s {
  ssh -i $PEM_KEY ec2-user@$1
}
function ecr-login {
  source ~/dev/env
  aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com
}

function set_title {
  echo -en "\033]2;$1\007";
}

# Golang
# export GOPATH=$HOME/dev/golib:$HOME/dev
# NOTE - May need to add /usr/local/go/bin
export PATH=$PATH:$HOME/dev/bin
export GOBIN=$HOME/dev/bin

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# Android Studio
# export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools
alias adb="$HOME/Library/Android/sdk/platform-tools/adb"


# Inngest
alias inngest="$HOME/dev/inngest/inngest"

alias dps="docker ps --format 'table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}'"

source $DOTFILES_DIR/zsh-gh-cli

# Rust
source $HOME/.cargo/env

# Default to dev for new terminal sessions
[[ $(pwd) == $HOME ]] && cd ~/dev