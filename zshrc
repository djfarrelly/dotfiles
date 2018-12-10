# Add by adding this to the bottom of ~/.zshrc
# source /path/to/dotfiles/zshrc


DOTFILES_DIR=${0:a:h}

ZSH_THEME="djf"

# Aliases
# alias git="hub"
alias k="kubectl"
alias wk="watch kubectl"
alias dc="docker-compose"
alias vim="nvim"
alias docker-cleanup-all-containers='docker rm $(docker ps -a -q) -f'
alias vpn='osascript -e "tell application \"Tunnelblick\" to connect \"buffer-vpn\"";'
alias vpn-refresh='$DOTFILES_DIR/vpn-refresh.sh'

# Helpers
function reload {
  source ~/.zshrc
  echo "~/.zshrc reloaded"
}
function ipme {
  curl -s icanhazip.com
}
# b64 something-encode
# b64 -D something-to-decode
function b64 {
  ARG1="$1"
  ARG2="$2"
  if [[ "$ARG1" == "-D" ]]; then
    echo -n "$ARG2" | base64 -D
  else
    echo -n "$ARG1" | base64
  fi
}
# s <ip-address>
function s {
  ssh -i '/Users/danielfarrelly/Buffer/buffer.pem' ec2-user@$1
}
