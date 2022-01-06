source ~/.zinit/zinit.zsh

zinit light-mode for zdharma-continuum/zinit-annex-bin-gem-node
zinit light zdharma-continuum/zinit-annex-patch-dl

case "$OSTYPE" in
  linux*) bpick='*((#s)|/)*(linux|musl)*((#e)|/)*' ;;
  darwin*) bpick='*(macos|darwin)*' ;;
  *) echo 'WARN: unsupported system -- some cli programs might not work' ;;
esac

zinit ice depth"1" lucid; zinit light romkatv/powerlevel10k

zinit for \
    from'gh-r' \
    sbin'**/delta -> delta' \
  dandavison/delta

zinit for \
    from'gh-r' \
    sbin'**/exa -> exa' \
    atclone'cp -vf completions/exa.zsh _exa' \
  ogham/exa

zinit for \
    as'command' \
    from'gh-r' \
    sbin'**/fd -> fd' \
  @sharkdp/fd

zinit for \
  vladdoster/gitfast-zsh-plugin \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  id-as'junegunn/fzf' nocompile pick'/dev/null' sbin'fzf' src'key-bindings.zsh' \
  from'gh-r' atclone'mkdir -p $ZPFX/{bin,man/man1}' atpull'%atclone' \
  dl'
      https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh -> _fzf_completion;
      https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh -> key-bindings.zsh;
      https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf-tmux.1 -> $ZPFX/man/man1/fzf-tmux.1;
      https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1 -> $ZPFX/man/man1/fzf.1' \
  @junegunn/fzf \
  OMZP::fzf

zinit for \
    as'command' \
    from'gh-r' \
    sbin'glow' \
  charmbracelet/glow

zinit for \
    as'command' \
    from'gh-r' \
    sbin'grex' \
  pemistahl/grex

zinit for \
    as'null' \
    atclone'%atpull' \
    atpull'
      ./bin/brew update --preinstall \
      && ln -sf $PWD/completions/zsh/_brew $ZINIT[COMPLETIONS_DIR] \
      && rm -f brew.zsh \
      && ./bin/brew shellenv --dummy-arg > brew.zsh \
      && zcompile brew.zsh' \
    depth'3' \
    nocompletions \
    sbin'bin/brew' \
    src'brew.zsh' \
  Homebrew/brew

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
  blockf atpull"zinit creinstall -q ." zsh-users/zsh-completions

zinit wait lucid for \
  OMZP::ssh-agent \
  PZTM::environment \
  PZTM::terminal \
  PZTM::spectrum \
  PZTM::history \
  PZTM::command-not-found \
  PZTM::tmux \
  PZTM::python \
  PZTM::ruby \
  zdharma-continuum/history-search-multi-word

# OMZP::pipenv \
# OMZP::pyenv

zinit wait svn lucid for \
  OMZP::git \
  OMZP::gitfast \
  OMZP::macos \
  OMZP::terraform \
  as"null" PZTM::archive

#PZTM::docker \

#zinit ice svn pick"completion.zsh" src"git.zsh"; zinit snippet OMZ::lib

zinit ice lucid nocompile wait'0e' nocompletions
zinit load MenkeTechnologies/zsh-more-completions

#zinit ice as"completion" lucid; zinit snippet OMZP::docker/_docker
zinit ice use"init.sh"; zinit load b4b4r07/enhancd

zstyle ":omz:plugins:ssh-agent" identities id_ed25519 id_rsa
zstyle ":omz:plugins:ssh-agent" ssh-add-args --apple-use-keychain
zstyle ":omz:plugins:ssh-agent" agent-forwarding on
zstyle ":history-search-multi-word" highlight-color "fg=yellow,bold"
#zstyle ':completion:*:*:git:*' script ~/.zinit/snippets/OMZP::gitfast/git-completion.bash
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
  alias ls="exa --git"
  alias cat="bat"
  alias less="bat"
  PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
  MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"
  export LESSOPEN="| src-hilite-lesspipe.sh %s"
  export LESS=' -R '
  test -e "${HOME}/.dircolors" && eval $(dircolors -b "${HOME}/.dircolors")
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
else
  test -e ~/.dircolors && eval $(dircolors ~/.dircolors)
  alias ls="ls --color=auto"
fi

# alias gitclean="git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D $branch; done"
alias tf="terraform"

# Use emacs key bindings
bindkey -e

# [PageUp] - Up a line of history
if [[ -n "${terminfo[kpp]}" ]]; then
  bindkey -M emacs "${terminfo[kpp]}" up-line-or-history
  bindkey -M viins "${terminfo[kpp]}" up-line-or-history
  bindkey -M vicmd "${terminfo[kpp]}" up-line-or-history
fi
# [PageDown] - Down a line of history
if [[ -n "${terminfo[knp]}" ]]; then
  bindkey -M emacs "${terminfo[knp]}" down-line-or-history
  bindkey -M viins "${terminfo[knp]}" down-line-or-history
  bindkey -M vicmd "${terminfo[knp]}" down-line-or-history
fi

# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${terminfo[kcuu1]}" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search

  bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${terminfo[kcud1]}" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search

  bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
  bindkey -M emacs "${terminfo[khome]}" beginning-of-line
  bindkey -M viins "${terminfo[khome]}" beginning-of-line
  bindkey -M vicmd "${terminfo[khome]}" beginning-of-line
fi
# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
  bindkey -M emacs "${terminfo[kend]}"  end-of-line
  bindkey -M viins "${terminfo[kend]}"  end-of-line
  bindkey -M vicmd "${terminfo[kend]}"  end-of-line
fi

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Backspace] - delete backward
bindkey -M emacs '^?' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char
# [Delete] - delete forward
if [[ -n "${terminfo[kdch1]}" ]]; then
  bindkey -M emacs "${terminfo[kdch1]}" delete-char
  bindkey -M viins "${terminfo[kdch1]}" delete-char
  bindkey -M vicmd "${terminfo[kdch1]}" delete-char
else
  bindkey -M emacs "^[[3~" delete-char
  bindkey -M viins "^[[3~" delete-char
  bindkey -M vicmd "^[[3~" delete-char

  bindkey -M emacs "^[3;5~" delete-char
  bindkey -M viins "^[3;5~" delete-char
  bindkey -M vicmd "^[3;5~" delete-char
fi

# [Ctrl-Delete] - delete whole forward-word
bindkey -M emacs '^[[3;5~' kill-word
bindkey -M viins '^[[3;5~' kill-word
bindkey -M vicmd '^[[3;5~' kill-word

# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word

bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
bindkey -s '\el' 'ls\n'                               # [Esc-l] - run command: ls
bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
bindkey ' ' magic-space                               # [Space] - don't do history expansion

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# file rename magick
bindkey "^[m" copy-prev-shell-word

load-tfswitch() {
  local tfswitchrc_path=".terraform-version"

  if [ -f "$tfswitchrc_path" ]; then
    tfswitch
  fi
}
add-zsh-hook chpwd load-tfswitch
load-tfswitch

load-tgswitch() {
  local tgswitchrc_path=".terragrunt-version"

  if [ -f "$tgswitchrc_path" ]; then
    tgswitch
  fi
}
add-zsh-hook chpwd load-tgswitch
load-tgswitch

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize
