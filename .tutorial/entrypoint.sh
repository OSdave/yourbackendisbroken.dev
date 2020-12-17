#!/usr/bin/env bash

# We are running in docker
export DOCKER_ENV=1

# Clone the repository if not present (mounted as volume for instance)
if [ ! -d .git ]; then
  git clone --branch $YBIB_BRANCH $YBIB_REPO ./
else
  git remote update
  git fetch --tags --force
fi
if [ $? -gt 0 ]; then
  echo "Cloning the git repository failed, please check your connection to internet."
  exit
fi

# Start supervisor (nginx + api)
supervisord
clear

./bin/start && bash
