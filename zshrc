source ~/.zinit/zinit.zsh

zinit ice depth"1" lucid; zinit light romkatv/powerlevel10k

zinit wait lucid for \
  OMZP::ssh-agent \
  OMZP::git \
  PZTM::environment \
  PZTM::terminal \
  PZTM::spectrum \
  PZTM::history \
  PZTM::command-not-found \
  PZTM::tmux \
  PZTM::python \
  PZTM::ruby \
  zdharma/history-search-multi-word

#  OMZP::pipenv \
#  OMZP::pyenv

zinit wait svn lucid for \
  OMZP::gitfast \
  OMZP::osx \
  PZTM::docker \
  as"null" PZTM::archive

zinit wait"0c" lucid light-mode for \
  atinit"zicompinit; zicdreplay" zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
  blockf atpull"zinit creinstall -q ." zsh-users/zsh-completions

zinit ice as"completion" lucid; zinit snippet OMZP::docker/_docker
zinit ice use"init.sh"; zinit load b4b4r07/enhancd

zstyle ":omz:plugins:ssh-agent" identities id_ed25519 id_rsa
zstyle ":omz:plugins:ssh-agent" ssh-add-args -K
zstyle ":omz:plugins:ssh-agent" agent-forwarding on
zstyle ":history-search-multi-word" highlight-color "fg=yellow,bold"
# zstyle ":prezto:module:terminal" auto-title "yes"
# zstyle ":prezto:module:terminal:window-title" format "%n@%m: %s"
# zstyle ":prezto:module:terminal:tab-title" format "%m: %s"
# zstyle ":prezto:module:terminal:multiplexer-title" format "%s"

# zstyle ":prezto:module:ssh:load" identities id_ed25519
# zstyle ":prezto:*:*" color "yes"
# zstyle ":prezto:module:tmux:auto-start" local "yes"
# zstyle ":prezto:module:tmux:auto-start" remote "yes"
# zstyle ":prezto:module:tmux:iterm" integrate "yes"

# Initialization code that may require console input (password prompts, [y/n]
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#export ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible/vault_pass.txt
#export PYENV_ROOT="$HOME/.pyenv"
#export GOROOT=/usr/local/go
#export GOPATH=$HOME/work
#export PATH="$HOME/.rbenv/bin:$PYENV_ROOT/bin:$PATH:$GOROOT/bin:$HOME/.local/bin"

export ENHANCD_DISABLE_HOME=1
export BAT_THEME=Nord

#if command -v pyenv 1>/dev/null 2>&1; then
#  eval "$(pyenv init -)"
#  eval "$(pyenv virtualenv-init -)"
#fi

#if command -v rbenv 1>/dev/null 2>&1; then
#  eval "$(rbenv init -)"
#fi

#if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
#  source ~/.gnupg/.gpg-agent-info
#  export GPG_AGENT_INFO
#else
#  eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
#fi

#export GPG_TTY=$(tty)

#eval "$(direnv hook zsh)"
#autoload -U bashcompinit
#bashcompinit
#eval "$(register-python-argcomplete pipx)"

if [[ `uname` == "Darwin" ]]; then
  alias ls="exa"
  alias cat="bat"
  alias less="bat"
  PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
  export LESSOPEN="| src-hilite-lesspipe.sh %s"
  export LESS=' -R '
  test -e "${HOME}/.dircolors" && eval $(dircolors -b "${HOME}/.dircolors")
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
else
  test -e ~/.dircolors && eval $(dircolors ~/.dircolors)
  alias ls="ls --color=auto"
fi

#alias gitclean="git fetch -p && for branch in $(git branch -vv | grep ": gone]" | awk "{print $1}"); do git branch -D $branch; done"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize
