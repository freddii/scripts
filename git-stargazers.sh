#!/bin/bash

#usage: git-stargazers.sh lakinduakash/linux-wifi-hotspot >> stargazers.txt
#wget -q https://api.github.com/repos/$1/stargazers?page=1 -O - | jq '.[] | .url'

USER=${1:-sebble}

STARS=$(curl -sI https://api.github.com/repos/$1/stargazers?per_page=1|egrep '^link'|egrep -o 'page=[0-9]+'|tail -1|cut -c6-)
PAGES=$(($STARS/100+1))

echo You have $STARS stargazers on this repository.
echo

for PAGE in `seq $PAGES`; do
    curl -sH "Accept: application/vnd.github.v3.star+json" "https://api.github.com/repos/$1/stargazers?per_page=100&page=1"| jq '.[] | .user .login'
done

#echo
# curl -sI https://api.github.com/users/$USER/starred?per_page=100|egrep '^Link: '|tr , \\n|grep 'rel="next"'|egrep -o '<https[^>]+'|tr -d \<

