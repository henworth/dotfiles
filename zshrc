# Initialization code that may require console input (password prompts, [y/n]
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zsh-users/zsh-history-substring-search"
# zplug 'sorin-ionescu/prezto', as:plugin, use:init.zsh, hook-build:"ln -s $ZPLUG_ROOT/repos/sorin-ionescu/prezto ${ZDOTDIR:-$HOME}/.zprezto"
zplug "modules/environment", from:prezto
zplug "modules/terminal", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/history", from:prezto
zplug "modules/directory", from:prezto
zplug "modules/spectrum", from:prezto
zplug "modules/command-not-found", from:prezto
zplug "modules/archive", from:prezto
zplug "modules/utility", from:prezto
#zplug 'modules/tmux', from:prezto
# zplug 'modules/ssh', from:prezto
# zplug 'modules/gpg', from:prezto
zplug 'modules/fasd', from:prezto
# zplug 'modules/contrib-prompt', from:prezto
# zplug 'modules/prompt', from:prezto
zplug "modules/git", from:prezto
zplug 'modules/docker', from:prezto
zplug 'modules/python', from:prezto
zplug 'modules/ruby', from:prezto
zplug "modules/completion", from:prezto, defer:2
zplug "modules/syntax-highlighting", from:prezto, defer:3
# zplug "modules/history-substring-search", from:prezto, defer:3
zplug "modules/autosuggestions", from:prezto, defer:3

zplug "plugins/ansible", from:oh-my-zsh
zplug "plugins/ssh-agent", from:oh-my-zsh
zplug "plugins/pipenv", from:oh-my-zsh
zplug "plugins/pyenv", from:oh-my-zsh
# zplug "plugins/gpg-agent", from:oh-my-zsh

zstyle ':omz:plugins:ssh-agent' identities id_ed25519
# zstyle ':prezto:module:ssh:load' identities id_ed25519

# zstyle ':prezto:*:*' color 'yes'
# zstyle ':prezto:module:tmux:auto-start' local 'yes'
# zstyle ':prezto:module:tmux:auto-start' remote 'yes'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

export ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible/vault_pass.txt
export PYENV_ROOT="$HOME/.pyenv"
export GOROOT=/usr/local/go
export GOPATH=$HOME/work
export PATH="$HOME/.rbenv/bin:$PYENV_ROOT/bin:$PATH:$GOROOT/bin:$HOME/.local/bin"
# export HISTFILE=$HOME/.zsh_history

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi


#if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
#  source ~/.gnupg/.gpg-agent-info
#  export GPG_AGENT_INFO
#else
#  eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
#fi

#export GPG_TTY=$(tty)

eval "$(direnv hook zsh)"
autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"

test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

alias ls='ls --color=auto'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize
