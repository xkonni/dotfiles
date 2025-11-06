# vim: ft=zsh
SSH_AUTH_SOCK_FILE=~/.ssh/SSH_AUTH_SOCK
LOGDIRS=(/run/user/$(id -u) /var/tmp/)
LOGFILE=ssh_auth_sock.log

function _log() {
    for logdir in "${LOGDIRS[@]}"
    do
        if [[ -d "$logdir" ]]
        then
            echo $* >> $logdir/$LOGFILE
            return
        fi
    done
}

function ssh_save() {
    if [[ ${OS} == "Darwin" ]]
    then
        launchctl setenv SSH_AUTH_SOCK $SSH_AUTH_SOCK
        return 0
    fi
    if [ -e "$SSH_AUTH_SOCK_FILE" ]
    then
        if [ ! "$SSH_AUTH_SOCK" = "$(cat $SSH_AUTH_SOCK_FILE)" ]
        then
            if [ ! -e "$(cat $SSH_AUTH_SOCK_FILE)" ]
            then
                _log "saving SSH_AUTH_SOCK: $SSH_AUTH_SOCK"
                echo $SSH_AUTH_SOCK >! $SSH_AUTH_SOCK_FILE
            else
                _log "sock file still valid"
            fi
        else
            _log "sock file unchanged"
        fi
    else
        _log "saving SSH_AUTH_SOCK: $SSH_AUTH_SOCK"
        echo $SSH_AUTH_SOCK >! $SSH_AUTH_SOCK_FILE
    fi
    [[ ${OS} != "Darwin" ]] && systemctl --user set-environment SSH_AUTH_SOCK=${SSH_AUTH_SOCK}
}


function ssh_load() {
    if [ -e $SSH_AUTH_SOCK_FILE ]
    then
        SSH_AUTH_SOCK=$(cat $SSH_AUTH_SOCK_FILE)
        if [ -e "$SSH_AUTH_SOCK" ]
        then
            export SSH_AUTH_SOCK
            [[ ${OS} != "Darwin" ]] && systemctl --user set-environment SSH_AUTH_SOCK=${SSH_AUTH_SOCK}
            if [ -n "$SSH_CLIENT" ]
            then
                _log "loaded SSH_AUTH_SOCK: $SSH_AUTH_SOCK"
            fi
        else
            _log "ERROR: invalid socket: $SSH_AUTH_SOCK"
        fi
    else
        agent_ssh_socket=$(gpgconf -L | grep agent-ssh-socket)
        if [ -n "$agent_ssh_socket" ]
        then
            SSH_AUTH_SOCK=$(echo $agent_ssh_socket | cut -d ":" -f 2)
            export SSH_AUTH_SOCK
            _log "using gpgconf SSH_AUTH_SOCK: $SSH_AUTH_SOCK"
            return 0
        fi
        _log "ERROR: missing file \"$SSH_AUTH_SOCK_FILE\""
    fi
}


function ssh_find() {
    local SSH_AUTH_SOCK_BASE="/tmp/ssh-"
    local SSH_AUTH_SOCK_TMP=$(ls ${SSH_AUTH_SOCK_BASE}*/agent*(om[1]))
    if [ -n "$SSH_AUTH_SOCK_TMP" ]
    then
        export SSH_AUTH_SOCK=$SSH_AUTH_SOCK_TMP
        ssh_save
    fi
}

alias sl='ssh-add -l'
alias sas="ssh_save"
alias sal="ssh_load"

if [[ ${OS} == "Darwin" ]]
then
    # SSH_AUTH_SOCK=$(launchctl getenv SSH_AUTH_SOCK)
    eval $(keychain --eval 2> /dev/null)
    return 0
fi

if [ -n "$SSH_AUTH_SOCK" -a -e $SSH_AUTH_SOCK ]
then
    ssh_save
else
    ssh_load
fi
