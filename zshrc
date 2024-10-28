# shellcheck disable=all

eval "$(oh-my-posh init zsh --config "${HOME}/.oh-my-posh/zen.toml")"

# PATH="${HOME}/bin:${HOME}/.local/bin:${HOME}/go/bin:${PATH}"
if [[ `uname` == "Darwin" ]]; then
    homebrew_path="/usr/local"
    if [[ `uname -m` == "arm64" ]]; then
        homebrew_path="/opt/homebrew"
    fi
    # PATH="${homebrew_path}/opt/gnu-sed/libexec/gnubin:$PATH"
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ `uname` == "Linux" ]]; then
    homebrew_path="/home/linuxbrew/.linuxbrew"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "${ZINIT_HOME}" ]; then
  mkdir -p "$(dirname "${ZINIT_HOME}")"
  git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add zsh plugins
zsh_plugins=(
  Aloxaf/fzf-tab
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-completions
  zsh-users/zsh-autosuggestions
)
for plugin ($zsh_plugins); do
  zinit light ${plugin}
done

# Add oh my zsh snippets
ohmyzsh_snippets=(
  git
  sudo
  kubectl
  docker
  terraform
  pip
  python
  brew
  golang
  direnv
  aws
  command-not-found
  archlinux
)
for snippet ($ohmyzsh_snippets); do
  zinit snippet OMZP::${snippet} &>/dev/null
done

zinit snippet OMZL::clipboard.zsh
# zinit snippet OMZL::termsupport.zsh

command -v brew >/dev/null && FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE="${HOME}/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completions
eval "$(oh-my-posh completion zsh)"

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

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

function gen_rand() {
  length=24
  if [ ! -z $1 ]; then
    length=$1
  fi
  LC_ALL=C tr -dc 'A-Za-z0-9!#$%&()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c $length ; echo -n
}

# Aliases
alias cat="bat"
alias ls="eza --git --group-directories-first"
alias l="ls -blF"
alias la="ls -abghilmu"
alias less="bat"
alias ll="ls -al"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias tfi="terraform init"
alias tree="eza --tree"
alias v=nvim
alias vi=nvim
alias vim=nvim

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
export SSH_AUTH_SOCK="${HOME}/.1password/agent.sock"

if command -v pyenv >/dev/null; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# command -v aws-vault >/dev/null && eval "$(aws-vault --completion-script-zsh)"
# command -v trivy >/dev/null && eval "$(trivy completion zsh)"

source "${HOME}/.config/op/plugins.sh"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH:/Users/mike/.local/bin"
eval "$(direnv hook zsh)"
