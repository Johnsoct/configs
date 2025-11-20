# Setup fzf
# ---------
if [[ ! "$PATH" == */home/framework/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/framework/.fzf/bin"
fi

eval "$(fzf --bash)"
