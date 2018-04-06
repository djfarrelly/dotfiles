# Add by adding this to the bottom of ~/.zshrc
# source /path/to/dotfiles/zshrc

# Aliases
alias dc="docker-compose"
alias vim="nvim"
alias docker-cleanup-all-containers='docker rm $(docker ps -a -q) -f'
alias vpn='osascript -e "tell application \"Tunnelblick\" to connect \"danfarrelly\"";'

# Helpers
function ipme {
  curl -s icanhazip.com
}
function b64 {
  echo -n "$1" | base64
}
function reload {
  source ~/.zshrc
  echo "~/.zshrc reloaded"
}
