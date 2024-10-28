source ${HOME}/.zplug/init.zsh

PATH="${HOME}/bin:${HOME}/.local/bin:${HOME}/go/bin:${PATH}"
if [[ `uname` == "Darwin" ]]; then
    homebrew_path="/usr/local"
    if [[ `uname -m` == "arm64" ]]; then
        homebrew_path="/opt/homebrew"
    fi
    PATH="${homebrew_path}/opt/gnu-sed/libexec/gnubin:$PATH"
elif [[ `uname` == "Linux" ]]; then
    homebrew_path="/home/linuxbrew/.linuxbrew"
fi
eval "$(${homebrew_path}/bin/brew shellenv)"

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

zplug "b4b4r07/enhancd", use:init.sh
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "${homebrew_path}/share/zsh", from:local

ohmyzsh_plugins=(
    git
    kubectl
    docker
    terraform
    pip
    python
    brew
    golang
    direnv
    aws
)
for plugin ($ohmyzsh_plugins); do
    zplug "plugins/${plugin}", from:oh-my-zsh
done

prezto_plugins=(
    history
    command-not-found
)
for plugin ($prezto_plugins); do
    zplug "modules/${plugin}", from:prezto
done

# If the defer tag is given 2 or above, run after compinit command
zplug "zsh-users/zsh-syntax-highlighting", defer:2

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# autoload -Uz +X bashcompinit && bashcompinit

# source ${HOME}/.bash-completions.sh
source ${HOME}/.keybindings.zsh
source ${HOME}/.fzf.zsh
source ${HOME}/.p10k.zsh

[[ $(uname -r) == *"WSL2"* ]] && source ${HOME}/.ssh-agent-bridge.sh

(( ! ${+functions[p10k]} )) || p10k finalize

export BAT_THEME=Nord
export EDITOR="nvim"
export ENHANCD_DISABLE_HOME=1
export ENHANCD_FILTER=fzf-tmux
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_DEFAULT_COMMAND="fd --type file"
# export HOMEBREW_GITHUB_API_TOKEN=$(op item get "GitHub PAT - Homebrew" --fields credential)
export LS_COLORS="$(vivid generate nord)"
export SSH_AUTH_SOCK="${HOME}/.1password/agent.sock"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
export PYENV_ROOT="${HOME}/.pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PATH="${PYENV_ROOT}/bin:/opt/homebrew/opt/libpq/bin:${PATH}"

if command -v pyenv >/dev/null; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

command -v aws-vault >/dev/null && eval "$(aws-vault --completion-script-zsh)"
command -v trivy >/dev/null && eval "$(trivy completion zsh)"

function gen_rand() {
  length=24
  if [ ! -z $1 ]; then
    length=$1
  fi
  LC_ALL=C tr -dc 'A-Za-z0-9!#$%&()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c $length ; echo -n
}

function find_backend_file() {
  local root="${PWD}"
  local backend_file="config.s3.tfbackend"

  while ! [[ "${root}" =~ ^//[^/]*$ ]]; do
    if [ -e "${root}/${backend_file}" ]; then
      echo "${root}/${backend_file}"
      return 0
    fi

    [ -n "${root}" ] || break
    root="${root%/*}"
  done

  return 1
}

alias cat="bat"
alias ls="eza --git --group-directories-first"
alias l="ls -blF"
alias la="ls -abghilmu"
alias less="bat"
alias ll="ls -al"
alias tree="eza --tree"
alias v=nvim
alias vi=nvim
alias vim=nvim
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias tfi="terraform init -backend-config=$(find_backend_file)"

source "${HOME}/.config/op/plugins.sh"

export NVM_DIR="${HOME}/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

[[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "${HOME}/.gvm/scripts/gvm"
