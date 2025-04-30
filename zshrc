
# \e[30m → Negro
# \e[31m → Rojo
# \e[32m → Verde
# \e[33m → Amarillo
# \e[34m → Azul
# \e[35m → Magenta
# \e[36m → Cian
# \e[37m → Blanco

# echo -e "\e[31mEste es un texto en rojo\e[0m"
# echo -e "\e[32mEste es un texto en verde\e[0m"
# echo -e "\e[34mEste es un texto en azul\e[0m"

ZSH=$HOME/.oh-my-zsh

# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
#robbyrussell

# Useful oh-my-zsh plugins for Le Wagon bootcamps
plugins=(
git 
gitfast 
last-working-dir 
common-aliases 
sublime 
vscode 
history-substring-search 
heroku 
ssh-agent 
zsh-syntax-highlighting
rails
ruby
)

# (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
# export HOMEBREW_NO_ANALYTICS=1
# ZSH_DISABLE_COMPFIX=true

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

#default editor
export EDITOR="code --wait"

# Load rbenv if installed (To manage your Ruby versions)
export PATH="${HOME}/.rbenv/bin:${PATH}" # Needed for Linux/WSL
type -a rbenv > /dev/null && eval "$(rbenv init -)"

# Load pyenv (To manage your Python versions)
export PATH="${HOME}/.pyenv/bin:${PATH}" # Needed for Linux/WSL
type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)"

# >>> Load nvm if installed (To manage your Node versions)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

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
# Load nvm if installed (To manage your Node versions) <<<

# >>>
# Rails and Ruby uses the local `bin` folder to store binstubs.

# Binstubs are wrapper scripts around executables (sometimes referred to as "binaries", although they don't have to be compiled) whose purpose is to prepare the environment before dispatching the call to the original executable.

# In the Ruby world, the most common binstubs are the ones that RubyGems generates after installing a gem that contains executables. But binstubs can be written in any language, and it often makes sense to create them manually.

# So instead of running `bin/rails` like the doc says, just run `rails`
# Same for `./node_modules/.bin` and nodejs
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"
# <<<

# Load 'lewagon' virtualenv for the Data Bootcamp. You can comment these 2 lines to disable this behavior.
# export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# pyenv activate lewagon 2>/dev/null && echo "🐍 Loading 'lewagon' virtualenv"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1 -a"
export BROWSER=/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe

source /home/jundev/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# The scripts f2py, f2py3 and f2py3.8 are installed in'/home/cyd/.local/bin' which is not on PATH
export PATH=/home/jundev/.local/bin/:$PATH
# export DISPLAY=172.20.208.1:0# phpenv
export PHPENV_ROOT="$HOME/.phpenv"
if [ -d "${PHPENV_ROOT}" ]; then
  export PATH="${PHPENV_ROOT}/bin:${PATH}"
  eval "$(phpenv init -)"
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# phpenv
export PHPENV_ROOT="$HOME/.phpenv"
if [ -d "${PHPENV_ROOT}" ]; then
  export PATH="${PHPENV_ROOT}/bin:${PATH}"
  eval "$(phpenv init -)"
fi

# START POSTGREsql
sudo /etc/init.d/postgresql start
# START mysql
sudo /etc/init.d/mysql start
# START apache2
sudo /etc/init.d/apache2 start
# START cron
# sudo /etc/init.d/cron start


# env vars for openssl
#export PATH="/usr/local/ssl/bin:$PATH"
#export LD_LIBRARY_PATH="/usr/local/ssl/lib:$LD_LIBRARY_PATH"

export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
export SSL_CERT_DIR=/etc/ssl/certs


export PATH="/usr/local/openssl-1.1.1/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/openssl-1.1.1/lib"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# assuming that rbenv was installed to `~/.rbenv`
FPATH=~/.rbenv/completions:"$FPATH"
autoload -U compinit
compinit
sudo /etc/init.d/postgresql start

if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval "$(ssh-agent -s)"
fi

ssh-add -l &>/dev/null
if [ $? -ne 0 ]; then
    ssh-add ~/.ssh/jundev
fi

# LOADS NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 

# Activate DIRENV
eval "$(direnv hook zsh)"

export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1 -a"
