source ${HOME}/.zplug/init.zsh

PATH="${HOME}/bin:${HOME}/.local/bin:${HOME}/go/bin:${PATH}"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

zplug "b4b4r07/enhancd", use:init.sh
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "/home/linuxbrew/.linuxbrew/share/zsh", from:local

ohmyzsh_plugins=(
    git
    kubectl
    docker
    terraform
    pip
    python
    brew
)
for plugin ($ohmyzsh_plugins); do
    zplug "plugins/${plugin}", from:oh-my-zsh
done

prezto_plugins=(
    "history"
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

source ${HOME}/.keybindings.zsh
source ${HOME}/.fzf.zsh
source ${HOME}/.p10k.zsh

[[ $(uname --kernel-release) == *"WSL2"* ]] && source ${HOME}/.ssh-agent-bridge.sh

(( ! ${+functions[p10k]} )) || p10k finalize

export BAT_THEME=Nord
export EDITOR="nvim"
export ENHANCD_DISABLE_HOME=1
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_DEFAULT_COMMAND="fd --type file"
export LS_COLORS="$(vivid generate nord)"
export SSH_AUTH_SOCK="${HOME}/.1password/agent.sock"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

zplug check b4b4r07/enhancd && export ENHANCD_FILTER=fzf-tmux

gen-rand() {
  length=24
  if [ ! -z $1 ]; then
    length=$1
  fi
  tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c $length ; echo
}

alias cat='bat'
alias l='ls -blF'
alias la='ls -abghilmu'
alias less="bat"
alias ll='ls -al'
alias ls='exa --git --group-directories-first'
alias tree='exa --tree'
alias v=nvim
alias vi=nvim
alias vim=nvim
