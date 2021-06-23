source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'sorin-ionescu/prezto', as:plugin, use:init.zsh, hook-build:"ln -s $ZPLUG_ROOT/repos/sorin-ionescu/prezto ${ZDOTDIR:-$HOME}/.zprezto"
zplug "modules/environment", from:prezto
zplug "modules/terminal", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/history", from:prezto
zplug "modules/directory", from:prezto
zplug "modules/spectrum", from:prezto
zplug "modules/command-not-found", from:prezto
zplug "modules/archive", from:prezto
zplug "modules/utility", from:prezto
zplug 'modules/tmux', from:prezto
# zplug 'modules/ssh', from:prezto
# zplug 'modules/gpg', from:prezto
zplug 'modules/fasd', from:prezto
zplug 'modules/contrib-prompt', from:prezto
zplug 'modules/prompt', from:prezto
zplug 'modules/docker', from:prezto
zplug 'modules/python', from:prezto
zplug 'modules/ruby', from:prezto
zplug "modules/completion", from:prezto, defer:2
zplug "modules/syntax-highlighting", from:prezto, defer:3
zplug "modules/history-substring-search", from:prezto, defer:3
zplug "modules/autosuggestions", from:prezto, defer:3

zplug "plugins/ansible", from:oh-my-zsh
zplug "plugins/ssh-agent", from:oh-my-zsh
# zplug "plugins/gpg-agent", from:oh-my-zsh

zstyle ':omz:plugins:ssh-agent' identities id_ed25519
# zstyle ':prezto:module:ssh:load' identities id_ed25519

zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:tmux:auto-start' local 'yes'
zstyle ':prezto:module:tmux:auto-start' remote 'yes'

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
export PATH="$HOME/.rbenv/bin:$PYENV_ROOT/bin:$PATH:$GOROOT/bin"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

eval "$(pyenv virtualenv-init -)"

export VISUAL=vim
export EDITOR="$VISUAL"

if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
  source ~/.gnupg/.gpg-agent-info
  export GPG_AGENT_INFO
else
  eval $(gpg-agent --daemon) #--write-env-file ~/.gnupg/.gpg-agent-info)
fi

export GPG_TTY=$(tty)
