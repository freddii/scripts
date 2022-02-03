#!/bin/bash

#usage: git-stargazers.sh freddii >> stargazers.txt
wget -q https://api.github.com/repos/$1/stargazers -O - | jq '.[] | .url'
