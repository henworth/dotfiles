# Setup fzf
# ---------
if [[ `uname` == "Darwin" ]]; then
    homebrew_path="/opt/homebrew"
elif [[ `uname` == "Linux" ]]; then
    homebrew_path="/home/linuxbrew/.linuxbrew"
fi

if [[ ! "$PATH" == *${homebrew_path}/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}${homebrew_path}/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${homebrew_path}/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${homebrew_path}/opt/fzf/shell/key-bindings.zsh"
