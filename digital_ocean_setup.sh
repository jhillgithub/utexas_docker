# Determine IP Address of machine and set environment variable
export APP_IP_ADDRESS=104.236.29.30

# SSH into the server
ssh -i config/.ssh/id_rsa root@$APP_IP_ADDRESS

# As root, run the following:

# First, install docker
# https://get.docker.com/
wget -qO- https://get.docker.com/ | sh



# Setup new user so we don't have to run as root
useradd --user-group --create-home --shell /bin/bash dockeruser
usermod -aG docker dockeruser

# Copy ssh authorized keys over to new dockeruser directory
mkdir -p /home/dockeruser/.ssh
cp ~/.ssh/authorized_keys /home/dockeruser/.ssh/authorized_keys
chown dockeruser /home/dockeruser/.ssh/authorized_keys

# Exit as root and login as new dockeruser

ssh -i config/.ssh/id_rsa root@$APP_IP_ADDRESS