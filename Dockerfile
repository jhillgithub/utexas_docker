# start from base
FROM node:alpine
# MAINTAINER jhillgithub <jeremy.hill.email@gmail.com>

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