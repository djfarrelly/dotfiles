# Add by adding this to the bottom of ~/.zshrc
# source /path/to/dotfiles/zshrc


DOTFILES_DIR=${0:a:h}

ZSH_THEME="djf"

export PATH=$PATH:/opt/homebrew/bin

# Aliases
alias k="kubectl"
alias wk="watch kubectl"
alias dc="docker-compose"
alias vim="nvim"
alias cat="ccat"
alias docker-cleanup-all-containers='docker rm $(docker ps -a -q) -f'
alias dev="cd ~/dev"
alias b64="$DOTFILES_DIR/utils/base64.js"

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
PEM_KEY="$HOME/buffer.pem"
function s {
  ssh -i $PEM_KEY ec2-user@$1
}
function dev {
  cd ~/dev
}

# Golang
# export GOPATH=$HOME/dev/golib:$HOME/dev
# NOTE - May need to add /usr/local/go/bin
export PATH=$PATH:$HOME/dev/bin

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
