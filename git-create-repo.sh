#!/bin/bash
#Usage:
#git-create-repo.sh GithubUsername NewReponame
github_username=""
github_token=""

repo_name=$1

if [ -z "$github_username" ]
then
      echo "variable \$github_username is empty, please set variable in this script first."
      exit 1
#else
#      echo "\$github_username is NOT empty"
fi

if [ -z "$github_token" ]
then
      echo "variable \$github_token is empty, please set variable in this script first."
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
curl -i -H "Authorization: token $git_token" \
    -d '{ \
        "name": $repo_name, \
        "auto_init": true, \
        "private": true, \
        "gitignore_template": "nanoc" \
      }' \
    https://api.github.com/user/repos
#
git remote add origin "https://github.com/$github_username/$repo_name.git"
git push origin master




