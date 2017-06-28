# Setup Instructions
# http://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html

# SSH into the server
ssh -i /path/to/*.pem ec2-user@$APP_IP_ADDRESS

# As root, run the following:

# First, install docker
sudo yum update -y
sudo yum install -y docker

# Run docker
sudo service docker start

# Add ec2-user to docker group so you can run docker without sudo
sudo usermod -a -G docker ec2-user

# Test Docker
docker info
