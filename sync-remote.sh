#!/bin/bash

getPathFile () {
    filterPath=""
    if [ -n $1 ]
    then
        filterPath=$(echo $1 | sed "s/^.\///")
    fi
    return $filterPath
}

# $1 = File
# $2 = Path to the file
isValidFile () {
    if [ -n $1 ] # If is not empty
    then
        if [[ $1 =~ ^\..*|\.swp$ ]]
        then
            return 1
        else
            if [ -e $2 ]
            then
                return 0
            else
                return 1
            fi
        fi
    else
        return 1
    fi
}

if [ -n "$1" ]; then
    dest=$1
else
    dest="pronofoot-dev:/var/www/"
fi

while :
do
    out=$(inotifywait -e modify -r ./ 2>/dev/null)
    path=$(getPathFile $(echo $out | awk '{print $1}'))
    file=$(echo $out | awk '{print $3}')
    localPath="$path$file"
    remotePath="$dest$path$file"
    isValidFile $file $localPath
    validFile=$?

    if [ $validFile -eq 0 ]
    then
        echo "$localPath -> $remotePath"
        #echo "rsync -az --exclude-from=.gitignore -e 'ssh' $localPath $remotePath"
        rsync -az --exclude-from=.gitignore -e 'ssh' $localPath pronofoot-dev:$remotePath
    fi
done
