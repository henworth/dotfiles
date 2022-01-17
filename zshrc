source ${HOME}/.zinit/zinit.zsh

zinit ice depth"1" lucid; zinit light romkatv/powerlevel10k

zturbo(){ zinit depth'1' lucid ${1/#[0-9][a-d]/wait"${1}"} "${@:2}"; }

case "$OSTYPE" in
  linux*) bpick='*((#s)|/)*(linux|musl)*((#e)|/)*' ;;
  darwin*) bpick='*(macos|darwin)*' ;;
  *) echo 'WARN: unsupported system -- some cli programs might not work' ;;
esac

zi light-mode for \
  atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  as'completion' \
    OMZL::{'completion','key-bindings','termsupport'}.zsh \
  zdharma-continuum/zinit-annex-{'submods','patch-dl','bin-gem-node','rust'}

zturbo light-mode for \
  vladdoster/gitfast-zsh-plugin \
  pack'bgn-binary+keys' id-as'junegunn/fzf' fzf \
  has'brew' as'completion' https://raw.githubusercontent.com/Homebrew/brew/master/completions/zsh/_brew \
  has'docker' as'completion' OMZP::docker/_docker \
  has'docker-compose' as'completion' OMZP::docker-compose/_docker-compose \
  has'go' OMZP::golang as'completion' OMZP::golang/_golang \
  has'pip' OMZP::pip as'completion' OMZP::pip/_pip \
  has'rsync' PZTM::rsync \
  has'terraform' OMZP::terraform as'completion' OMZP::terraform/_terraform \
  svn submods'zsh-users/zsh-completions -> external' \
  blockf atpull'zinit creinstall -q .' \
    PZTM::completion \
  svn submods'zsh-users/zsh-history-substring-search -> external' \
    PZT::modules/history-substring-search OMZL::history.zsh \
  svn submods'zsh-users/zsh-autosuggestions -> external' \
    PZTM::autosuggestions \
  OMZP::ssh-agent \
  PZTM::environment \
  PZTM::terminal \
  PZTM::spectrum \
  PZTM::history \
  PZTM::command-not-found \
  PZTM::tmux \
  PZTM::python \
  PZTM::ruby

zinit for \
    atclone'
      autoreconf -fi \
      && ./configure --with-oniguruma=builtin \
      && make \
      && ln -sfv $PWD/jq.1 $ZPFX/man/man1' \
    as'null' \
    if'(( ! ${+commands[jq]} ))' \
    lucid    \
    sbin'jq' \
    wait     \
  stedolan/jq

zturbo from'gh-r' as'command' for \
  sbin'glow' charmbracelet/glow \
  sbin'grex' pemistahl/grex

zturbo from'gh-r' as'program' for \
  sbin'bat*/bat'     @sharkdp/bat     \
  sbin'delta*/delta' dandavison/delta \
  sbin'fd*/fd'       @sharkdp/fd      \
  sbin'ripgrep*/rg'  BurntSushi/ripgrep \
  sbin'hyperfine*/hyperfine' @sharkdp/hyperfine \
  sbin'shfmt* -> shfmt'      @mvdan/sh          \
  sbin'nvim*/**/nvim' \
  atinit"alias v=nvim; alias vi=nvim; alias vim=nvim" \
    neovim/neovim \
  sbin'**/exa'        atclone'cp -vf completions/exa.zsh _exa' \
  atload"alias l='ls -blF'; alias la='ls -abghilmu'
         alias ll='ls -al'; alias tree='exa --tree'
         alias ls='exa --git --group-directories-first'" \
    ogham/exa

# OMZP::pipenv \
# OMZP::pyenv

zinit wait svn lucid for \
  OMZP::git \
  OMZP::gitfast \
  OMZP::macos \
  as"null" PZTM::archive

#PZTM::docker \

#zinit ice svn pick"completion.zsh" src"git.zsh"; zinit snippet OMZ::lib

# zinit for \
#   atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
#   awsume

zinit ice lucid nocompile wait'0e' nocompletions
zinit load MenkeTechnologies/zsh-more-completions

#zinit ice as"completion" lucid; zinit snippet OMZP::docker/_docker
zinit ice use"init.sh"; zinit load b4b4r07/enhancd

zstyle ":omz:plugins:ssh-agent" identities id_ed25519
zstyle ":omz:plugins:ssh-agent" ssh-add-args --apple-use-keychain
zstyle ":omz:plugins:ssh-agent" agent-forwarding on
#zstyle ":history-search-multi-word" highlight-color "fg=yellow,bold"
#zstyle ':completion:*:*:git:*' script ~/.zinit/snippets/OMZP::gitfast/git-completion.bash
# zstyle ':completion:*:*:awsume:*' script /usr/local/bin/awsume-autocomplete
zstyle ":prezto:module:terminal" auto-title "yes"
zstyle ":prezto:module:terminal:window-title" format "%n@%m: %s"
zstyle ":prezto:module:terminal:tab-title" format "%m: %s"
zstyle ":prezto:module:terminal:multiplexer-title" format "%s"

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

PATH="${HOME}/bin:${HOME}/go/bin:${PATH}"

if [[ `uname` == "Darwin" ]]; then
  PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
  MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"
  export LESSOPEN="| src-hilite-lesspipe.sh %s"
  export LESS=' -R '
  test -e "${HOME}/.dircolors" && eval $(dircolors -b "${HOME}/.dircolors")
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
else
  test -e ~/.dircolors && eval $(dircolors ~/.dircolors)
fi

alias cat="bat"
alias less="bat"

# alias gitclean="git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D $branch; done"
alias tf="terraform"

# file rename magick
bindkey '^[m' copy-prev-shell-word

source ${HOME}/.zinit/plugins/junegunn---fzf/_fzf_completion
source ${HOME}/.zinit/plugins/junegunn---fzf/key-bindings.zsh

load-tfswitch() {
  local tfswitchrc_path=".terraform-version"

  if [ -f "$tfswitchrc_path" ]; then
    tfswitch
  fi
}
#add-zsh-hook chpwd load-tfswitch
#load-tfswitch

load-tgswitch() {
  local tgswitchrc_path=".terragrunt-version"

  if [ -f "$tgswitchrc_path" ]; then
    tgswitch
  fi
}
#add-zsh-hook chpwd load-tgswitch
#load-tgswitch

#if [[ `echo $(pyenv which awsume 2>/dev/null)` != "" ]]; then
#  alias awsume="source \$(pyenv which awsume)"
#  fpath+=( ${HOME}/.awsume/zsh-autocomplete )
#fi

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
export EDITOR="nvim"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize
