paths=(/usr/local/go/bin $HOME/bin $HOME/.local/bin $HOME/go/bin)

for p in ${paths[@]}
do
    if [ -d $p ]
    then
        if [[ ! $PATH =~ $p ]]
        then
            export PATH=$p:$PATH
        fi
    fi
done
