#!/bin/bash
#Usage:
#git-create-repo.sh GithubUsername NewReponame
user=$1
repo_name=$2

git init
if [ ! -f "$PWD/README.md" ]; then
echo "# $repo_name" > README.md
fi
git add .
git commit -m "First commit"

param="{\"name\":\"$repo_name\"}"
curl -u $user https://api.github.com/user/repos -d $param
$pw
git remote add origin "https://github.com/$user/$repo_name.git"
git push origin master