# VARIABLES
CODE_ENV_PREFIX=~/.code_env
VARIABLES=( GIT_ASKPASS PATH VSCODE_GIT_ASKPASS_NODE VSCODE_GIT_ASKPASS_EXTRA_ARGS VSCODE_GIT_ASKPASS_MAIN VSCODE_GIT_IPC_HANDLE VSCODE_IPC_HOOK_CLI )


function _env_get() {
    env | grep -E "^$1" | sed "s/$1=//"
}

function _code_env_save() {
    # arguments
    SESSION=${1:-default}

    CODE_ENV_FILE=${CODE_ENV_PREFIX}_${SESSION}
    rm -f ${CODE_ENV_FILE}
    echo "> saving environment SESSION=${SESSION} to ${CODE_ENV_FILE}"


    for key in ${VARIABLES[@]}
    do
        val=$(_env_get $key)
        if [ -n "$val" ]
        then
            echo "save $key = $val"
            echo "${key}=${val}" >>! ${CODE_ENV_FILE}
        else
            echo "key ${key} empty"
        fi
    done
}

function _code_env_load() {
    # param 1: tmux session
    SESSION=${1:-$(tmux display-message -p '#S')}
    CODE_ENV_FILE=${CODE_ENV_PREFIX}_${SESSION}
    if [ -e ${CODE_ENV_FILE} ]
    then
        echo "> loading environment SESSION=${SESSION} from ${CODE_ENV_FILE}"
        cat ${CODE_ENV_FILE} | while IFS= read -r line
        do
            key=${line%=*}
            val=${line#*=}
            echo "key: $key val: $val"
            export ${key}="${val}"
            if [ -z "$2" -o -n "$TMUX" ]
            then
                tmux setenv -t ${SESSION} ${key} ${val}
            fi
        done
    else
        echo "missing ${CODE_ENV_FILE}"
    fi
}

function code-env() {
    case $1 in
    save)
        _code_env_save $2
        ;;
    load)
        _code_env_load $2
        ;;
    attach)
        _code_env_save $2
        _code_env_load $2 1
        tmux att -t $2
        ;;
    *)
        echo "execute $0 [load|save] [session]"
        exit 0
        ;;
esac
}

alias ca="code-env attach"
alias cl="code-env load"
alias cs="code-env save"
