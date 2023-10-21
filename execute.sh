#!/bin/bash

git config --global alias.clone-gh-org '!f() { ORG_NAME="$1"; DEST_DIR="$(echo "$2" | sed 's/[^a-zA-Z0-9]//g')"; REPO_LIST=$(curl -s "https://api.github.com/orgs/$ORG_NAME/repos?per_page=100" | grep -o "\"clone_url\": \"[^\"]*" | sed "s/\"clone_url\": \"//"); mkdir $DEST_DIR && cd $DEST_DIR; for REPO in $REPO_LIST; do git clone "$REPO"; done; echo "Current directory: $(pwd)";}; f'
# git config --global alias.clone-gh-org '!f() { ORG_NAME="$1"; DEST_DIR="$(echo "$2" | sed 's/[^a-zA-Z0-9]//g')"; REPO_LIST=$(curl -s "https://api.github.com/orgs/$ORG_NAME/repos?per_page=100" | grep -o "\"clone_url\": \"[^\"]*" | sed "s/\"clone_url\": \"//"); for REPO in $REPO_LIST; do git clone "$REPO" "$DEST_DIR/$(basename "$REPO" .git)"; done; echo "Current directory: $(pwd)"; }; f'

# # Set the organization name and destination directory
# ORG_NAME=$1
# DEST_DIR=$2

# # Get a list of all the repositories in the organization
# REPO_LIST=$(curl -s "https://api.github.com/orgs/$ORG_NAME/repos?per_page=1000"| grep -o '"clone_url": "[^"]*' | sed 's/"clone_url": "//')

# # Clone each repository into the destination directory
# for REPO in $REPO_LIST; do
#     echo $REPO
#     git clone $REPO $DEST_DIR/$(basename $REPO .git)
# done

