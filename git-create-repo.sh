#!/bin/bash
#Usage:
#git-create-repo.sh GithubUsername NewReponame
user=""  #github username
github_token="" #github token
repo_name=$1

if [ -z "$user" ]
then
      echo "variable \$user is empty, please set variable for github-username in this script first."
      exit 1
fi

if [ -z "$github_token" ]
then
      echo "variable \$github_token is empty, please set variable in this script first. 
How to create a personal access token:
with scopes:  write:packages
https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line"
      exit 1
#else
#      echo "\$github_token is NOT empty"
fi

git init
if [ ! -f "$PWD/README.md" ]; then
echo "# $repo_name" > README.md
fi
git add .
git commit -m "First commit"
#
#param="{\"name\":\"$repo_name\"}"
#curl -u $user https://api.github.com/user/repos -d $param
#$pw
#
#curl -H 'Authorization: token '$github_token https://api.github.com/user/repos -d $param
curl -H 'Authorization: token '$github_token https://api.github.com/user/repos -d '{"name": "'$repo_name'", "private": true}'
#
git remote add origin "https://github.com/$user/$repo_name.git"
git push origin master




