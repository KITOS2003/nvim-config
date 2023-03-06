x=$(pwd)

y=$(find "$x" -maxdepth 1 -name makefile)

if [[ $y == "" ]]; then

    while [ "$x" != "/" ] ; do
        x=`dirname "$x"`
        y=$(find "$x" -maxdepth 1 -name makefile)
        if [[ $y != "" ]]; then
            break
        fi
    done

fi

x=$(pwd)
cd ${y%/*}

make $1

cd ${x}


