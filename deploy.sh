#!/bin/bash

docker build -t jhillgithub/node-example .
docker push jhillgithub/node-example

# Log into cloud host using ssh key
# @NOTE: https://www.shellhacks.com/ssh-execute-remote-command-script-linux/
ssh -i $CREDS dockeruser@$APP_IP_ADDRESS << EOF
# https://stackoverflow.com/questions/34228864/stop-and-delete-docker-container-if-its-running
docker stop app || true && docker rm app || true

# Remove the image
docker rmi jhillgithub/node-example || true

# Grab the latest image
docker pull jhillgithub/node-example

docker run -d --name app --restart always -p 3000:3000 jhillgithub/node-example

EOF