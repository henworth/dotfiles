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
  PZTM::ruby

# OMZP::pipenv \

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

zinit pack"bgn" git for pyenv

zinit wait svn lucid for \
  OMZP::git \
  OMZP::gitfast \
  OMZP::macos \
  as"null" PZTM::archive

#PZTM::docker \

zinit ice use"init.sh"; zinit load b4b4r07/enhancd
zinit ice lucid nocompile wait'0e' nocompletions
zinit load MenkeTechnologies/zsh-more-completions

#zinit ice use"op.plugin.zsh"; zinit load sirhc/op.plugin.zsh

zstyle ":omz:plugins:ssh-agent" identities id_ed25519
zstyle ":omz:plugins:ssh-agent" agent-forwarding on

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zstyle ":prezto:module:terminal" auto-title "yes"
zstyle ":prezto:module:terminal:window-title" format "%n@%m: %s"
zstyle ":prezto:module:terminal:tab-title" format "%m: %s"
zstyle ":prezto:module:terminal:multiplexer-title" format "%s"

# zstyle ":prezto:module:tmux:auto-start" local "yes"
# zstyle ":prezto:module:tmux:auto-start" remote "yes"

PATH="${HOME}/bin:${HOME}/go/bin:${PATH}"

if [[ `uname` == "Darwin" ]]; then
  # zstyle ":prezto:module:tmux:iterm" integrate "yes"
  zstyle ":omz:plugins:ssh-agent" ssh-add-args --apple-use-keychain

  PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
  MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"
  export LESSOPEN="| src-hilite-lesspipe.sh %s"
  export LESS=' -R '

  test -e "${HOME}/.dircolors" && eval $(dircolors -b "${HOME}/.dircolors")
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
else
  test -e "${HOME}/.dircolors" && eval $(dircolors "${HOME}/.dircolors")
fi

alias tf="terraform"
alias cat="bat"
alias less="bat"
alias tf="terraform"
alias tfp="terraform plan"
alias tfa="terraform apply"
alias tg="terragrunt"
alias tgp="terragrunt plan"
alias tga="terragrunt apply"
alias tgaa="terragrunt apply -auto-approve"
alias tgar="terragrunt apply -auto-approve -refresh-only"

# file rename magick
bindkey '^[m' copy-prev-shell-word

source ${HOME}/.zinit/plugins/junegunn---fzf/_fzf_completion
source ${HOME}/.zinit/plugins/junegunn---fzf/key-bindings.zsh

load-tfswitch() {
  if [[ "$PWD" =~ "terraform" ]]; then
    tfswitch
  fi
}
#add-zsh-hook chpwd load-tfswitch
#load-tfswitch

load-tgswitch() {
  if [[ "$PWD" =~ "terraform/live" ]]; then
    tgswitch
  fi
}
#add-zsh-hook chpwd load-tgswitch
#load-tgswitch

export ENHANCD_DISABLE_HOME=1
export BAT_THEME=Nord
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
export EDITOR="nvim"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize
