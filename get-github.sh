#!/bin/bash

#from https://gitlab.com/metalx1000/MyBin/blob/master/linux/shell/get_github.sh

if [ $# -lt 1 ]
then
  echo "Useage: $0 <user>"
  echo "Example: $0 metalx1000"
else
tmp="github_backup"
mkdir "$tmp"
cd "$tmp"

user=$1
#user=freddii
wget "https://github.com/$user?tab=repositories" -q -O-|\
    grep "href" -o |\
    grep "$user" -o |\
    grep "Forks" -o |\
    cut -d\" -f4|\
    cut -d\/ -f3|while read line;
    do
        git clone "https://github.com/$user/${line}.git"
    done

    zip -r ../github_backup_$(date +%s).zip *
    cd ../
    rm -fr "$tmp"
fi
