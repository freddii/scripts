#!/bin/bash

#Usage:
#./temp-upload.sh /path/to/file/you/want/to.upload 2d
#The 2d part means the link will expire after two days. You can also do "w" for weeks and "m" for months.

if [[ ! $1 ]]; then
        echo "No file provided"
        exit
fi
if [ ! -f "$1" ]; then
        echo "File does not exist"
        echo "$1"
        echo ""
        exit;
fi

if [[ ! $2 ]]; then
        echo "Expiration not privded"
        exit
fi

RESPONSE=`curl -F "file=@$1" https://file.io/?expires="$2"`
LINK=`echo "$RESPONSE" | jq '.link'`
LEN=${#LINK}
SUBSTR_LEN=($LEN-2)
LINK=${LINK:1:${SUBSTR_LEN}}

echo "Download link: $LINK"

exit