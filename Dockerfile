# start from base
FROM ubuntu:16.04
# MAINTAINER jhillgithub <jeremy.hill.email@gmail.com>

# install system-wide dependencies
RUN apt-get -yqq update
RUN apt-get -yqq install nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Expose Port 3000 for express (defined in server.js)
EXPOSE 3000

# Make /app the working directory
WORKDIR /app

# Add the source code (package.json and server.js) from the local app folder
# to /app in the container
ADD app /app

# Install node dependencies (express in this case)
RUN npm install

# Finally, run the node/express server
CMD ["node", "server.js"]