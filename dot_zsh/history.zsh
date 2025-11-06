export HISTSIZE=10000000 # 10 mio
export HISTFILESIZE=10000000 # 10 mio
export HISTCONTROL=ignoredups:erasedups  # no duplicates
export HISTIGNORE="&:ls:[bf]g:exit" # ignore some commands
setopt extended_history # save multi-line commands as one command
setopt hist_reduce_blanks # remove superfluous blanks
setopt share_history # share history between sessions
setopt append_history # append to the history file, don't overwrite it
setopt inc_append_history # add commands to the history file immediately
setopt hist_verify # show command with history expansion to user before running it