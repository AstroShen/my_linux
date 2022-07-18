# Setup fzf
# ---------
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border --preview "bat --style=numbers --color=always --line-range :500 {}" '
export FZF_DEFAULT_COMMAND='rg --files -S -z --hidden --follow -E ".git" -E ".trash"'
export FZF_DEFAULT_OPTS+='--bind=ctrl-t:top,change:top --bind ctrl-e:down,ctrl-u:up'
export FZF_COMPLETION_TRIGGER='\'
export FZF_TMUX=1
export FZF_TMUX_HEIGHT='80%'

if [[ ! "$PATH" == *$HOME/.vim/plugged/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/.vim/plugged/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.vim/plugged/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.vim/plugged/fzf/shell/key-bindings.bash"
