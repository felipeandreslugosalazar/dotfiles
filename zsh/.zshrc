# === Basic Oh My Zsh configuration ===
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  common-aliases 
  git
  gitfast
  history-substring-search 
  last-working-dir 
  rails 
  ruby
  ssh-agent 
  vscode 
  zsh-syntax-highlighting 
)

source "$ZSH/oh-my-zsh.sh"

# === Default editor ===
export EDITOR="code --wait"

# === rbenv (Ruby version manager) ===
export PATH="$HOME/.rbenv/bin:$PATH"
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# === pyenv (Python version manager) ===
export PATH="$HOME/.pyenv/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# === nvm (Node version manager) ===
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  source "$NVM_DIR/nvm.sh"
fi
if [ -s "$NVM_DIR/bash_completion" ]; then
  source "$NVM_DIR/bash_completion"
fi

# Load nvmrc functionality for managing node versions automatically
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"
  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# === Load personal aliases ===
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# === Language / encoding ===
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# === Custom PATH ===
export PATH="./bin:./node_modules/.bin:$HOME/.local/bin:$PATH"

# === PHPenv ===
export PHPENV_ROOT="$HOME/.phpenv"
if [ -d "$PHPENV_ROOT" ]; then
  export PATH="$PHPENV_ROOT/bin:$PATH"
  eval "$(phpenv init -)"
fi

# === Linuxbrew (optional, comment if unused) ===
if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# === OpenSSL custom paths (optional) ===
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
export SSL_CERT_DIR=/etc/ssl/certs

# === SSH Agent ===
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)"
fi

# Auto-add default SSH key (adjust path if needed)
if ! ssh-add -l &>/dev/null; then
  ssh-add "$HOME/.ssh/felipin"
fi

# === Activate direnv ===
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi
