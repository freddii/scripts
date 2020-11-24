#!/bin/sh
# example usage:
#./backupAllRepositories.sh geek1011
FOLDER=$(date +%B-%d-%Y_%I-%M-%p)
rm -rf "$FOLDER"
mkdir "$FOLDER"
cd "$FOLDER"

USER=$1;
PAGE=1; 
curl "https://api.github.com/users/$USER/repos?page=$PAGE&per_page=100" | grep -e 'git_url*' | cut -d \" -f 4 | xargs -L1 git clone
