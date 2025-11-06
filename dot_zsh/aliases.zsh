# zsh general
# alias zr="source ~/.zshrc"
alias zr="znap restart"

# These aliases enable us to paste example code into the terminal without the
# shell complaining about the pasted prompt symbol.
alias %= \$=

# zmv lets you batch rename (or copy or link) files by using pattern matching.
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#index-zmv
autoload -Uz zmv
alias zmv='zmv -Mv'
alias zcp='zmv -Cv'
alias zln='zmv -Lv'

# usability
if type -p lsd &> /dev/null
then
    alias ls='lsd --group-directories-first'
else
    alias ls='ls --color=auto --group-directories-first'
fi
alias ll='ls -l'
alias lt='ls -ltr'
alias less='less -F -j4'

# cat -> bat/batcat
bat=( /usr/bin/bat(N) /usr/bin/batcat(N) /opt/homebrew/bin/bat(N) )
if type -p ${bat:0:1} &> /dev/null
then
    local cat=${bat:0:1}
    alias cat=$cat
    alias less="$cat --pager='less -RF -j4'"
    # bat tail log
    alias btl="$cat --paging=never -l log"
    export PAGER=$cat
    export MANPAGER="sh -c \"col -bx | $cat -p -l man\""
    export MANROFFOPT="-P -c"
    # READNULLCMD=$PAGER
    alias bathelp="$cat --plain --language=help"
    help() {
        "$@" --help 2>&1 | $cat --plain --language=help
    }
else
    echo no bat
fi


# find -> findfd
fd=( /usr/bin/fd(N) /usr/bin/fdfind(N) )
if type -p ${fd:0:1} &> /dev/null
then
    local find=${fd:0:1}
    alias find=$find
fi

# fz
if type -p fzf &> /dev/null && type -p ${bat:0:1} &> /dev/null && \
    type -p ${fd:0:1} &> /dev/null
then
    local find=${fd:0:1}
    local cat=${bat:0:1}
    alias fz="${find} --type f . | fzf --preview \"${cat} --color=always --style=numbers {}\" | xargs -d \"\n\" -I{} ${cat} {}"
    alias fzv="${find} --type f . | fzf --preview \"${cat} --color=always --style=numbers {}\" | xargs -d \"\n\" -I{} vim {}"
    alias fzo="${find} --type f . | fzf --preview \"${cat} --color=always --style=numbers {}\" | xargs -d \"\n\" -I{} xdg-open {}"
fi

# global aliases
alias -g G='| grep '
alias -g GI='| grep -i '
alias -g L='| less'
alias -g LT='*(om[1])'

# dmesg
alias jdmesg="journalctl -t kernel -xf"
# ip
alias ip='ip --color=auto'
# fasd
alias v='fasd -fe vim'

# SSH
alias S='ssh'
alias SA='ssh-add'
alias SL='ssh-add -l'
alias SE='eval $(keychain --eval)'

# CLIPBOARD
if [[ ${OS} == "Darwin" ]]
then
    alias -g CP='| pbcopy'
    alias PS='pbpaste'
else
    alias -g CP='| wl-copy'
    alias PS='wl-paste'
fi
function CPF() {
    cat $1 CP
}
function PSF() {
    PS | tee $1
}
function PSA() {
    PS | tee -a $1
}


globalias() {
  if [[ $LBUFFER =~ '[A-Z0-9]+$' ]]; then
    zle _expand_alias
    zle expand-word
  fi
  # zle self-insert # inserts keys used to activate
  print -n " "
}
zle -N globalias
# bindkey " " globalias                 # space key to expand globalalias
# bindkey "^ " magic-space              # control-space to bypass completion
bindkey -M emacs "^ " globalias                 # space key to expand globalalias
bindkey -M viins "^ " globalias                 # space key to expand globalalias
bindkey -M emacs " " magic-space              # control-space to bypass completion
bindkey -M viins " " magic-space              # control-space to bypass completion
bindkey -M isearch " " magic-space    # normal space during searches
