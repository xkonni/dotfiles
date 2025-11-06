autoload -Uz insert-last-word
# zle -N insert-last-word
# zle -N insert-last-word-forward
# Define forward cycling widget
# insert-last-word-forward() {
#   zle insert-last-word -- -1 1
# }

# Bind keys
bindkey '^[.' insert-last-word          # Alt + .
# bindkey '^[/' insert-last-word-forward  # Alt + ,
bindkey '^Q' push-line
