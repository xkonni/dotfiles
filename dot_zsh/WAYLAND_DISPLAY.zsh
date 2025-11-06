# vim: ft=zsh
if [[ $(uname) == "Darwin" ]]
then
    return 0
fi

LOG=/run/user/$(id -u)/wayland_display.log

function _log() {
    echo $* >> $LOG
}

WAYLAND_DISPLAY_FILE=~/.WAYLAND_DISPLAY
if [ ! -e $WAYLAND_DISPLAY_FILE ]
then
    touch $WAYLAND_DISPLAY_FILE
fi

function wayland_display_save() {
    if [ -e "$WAYLAND_DISPLAY_FILE" ]
    then
        if [ ! "$WAYLAND_DISPLAY" = "$(cat $WAYLAND_DISPLAY_FILE)" ]
        then
            _log "saving WAYLAND_DISPLAY: $WAYLAND_DISPLAY"
            echo $WAYLAND_DISPLAY >! $WAYLAND_DISPLAY_FILE
        else
            _log "file unchanged"
        fi
    else
        _log "saving WAYLAND_DISPLAY: $WAYLAND_DISPLAY"
        echo $WAYLAND_DISPLAY >! $WAYLAND_DISPLAY_FILE
    fi
    systemctl --user set-environment WAYLAND_DISPLAY=${WAYLAND_DISPLAY}
}


function wayland_display_load() {
    if [ -e $WAYLAND_DISPLAY_FILE ]
    then
        WAYLAND_DISPLAY=$(cat $WAYLAND_DISPLAY_FILE)
        if [ -n "$WAYLAND_DISPLAY" ]
        then
            export WAYLAND_DISPLAY
            systemctl --user set-environment WAYLAND_DISPLAY=${WAYLAND_DISPLAY}
            _log "loaded WAYLAND_DISPLAY: $WAYLAND_DISPLAY"
        else
            _log "no display set $WAYLAND_DISPLAY"
        fi
    else
        _log "ERROR: missing file \"$WAYLAND_DISPLAY_FILE\""
    fi
}

alias wds=wayland_display_save
alias wdl=wayland_display_load

if [ -n "${SSH_CLIENT}" ]
then
    if [ -n "${WAYLAND_DISPLAY}" ]
    then
        wayland_display_save
    else
        wayland_display_load
    fi
fi

