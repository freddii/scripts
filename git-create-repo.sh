#!/bin/bash
#TODO: check params
user=$1
repo_name=$2

git init
echo "# $repo_name" > README.md
git add .
git commit -m "First commit"

param="{\"name\":\"$repo_name\"}"
curl -u $user https://api.github.com/user/repos -d $param
$pw
git remote add origin "https://github.com/$user/$repo_name.git"
git push origin master