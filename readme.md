# Deploying Docker Node App to AWS

These instructions will outline the proceedure for deploying a dockerized node app to aws.

## Getting Started

These instructions will show how to build a docker image file, deploy the image to docker hub, and then run that image on aws.

## Prerequisites

You will need to install [Docker](https://www.docker.com/community-edition).

In order to push a build to Docker Hub, you will need to login throuhg the cli.

```shell
docker login
```

You will also need a running EC2 instance, the ip address for that server, and the *.pem file to login.

* You EC2 instance will also need a security group policy that allows **HTTP** on port 80 from anywhere. Checkout this [link](https://stackoverflow.com/questions/5004159/opening-port-80-ec2-amazon-web-services/10454688#10454688) for instructions.

## Configuring AWS

The following steps show how to configure the AWS EC2 instance to use Docker.

* You will only need to do this once per EC2 instance. 

[Setup Instructions](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html)

SSH into the server using the `pem` credentials and the ip address of the server.

* The user for EC2 will be `ec2-user`

```shell
ssh -i /path/to/*.pem ec2-user@<ec2 instance ip address>
```

Once in the server, run the following as root:

First, install docker

```shell
sudo yum update -y
sudo yum install -y docker
```

Run docker

```shell
sudo service docker start
```

Add ec2-user to docker group so you can run docker without sudo

```shell
sudo usermod -a -G docker ec2-user
```

Log out of EC2 and then Login again to pick up the new group permissions

```shell
exit
ssh -i /path/to/*.pem ec2-user@<ec2 instance ip address>
```

Test Docker

* **Note**, the next step will not work unless you logout and log back in

```shell
docker info
```

You can now exit from the EC2 session

```shell
exit
```

## Deploying

The provided deploy script will build the docker image, deploy it to Docker Hub, and deploy it to the EC2 instance.

First, clone the [repo](https://github.com/jhillgithub/utexas_docker) and `cd` into the repo.

```shell
git clone https://github.com/jhillgithub/utexas_docker.git
cd utexas_docker
```

Next, open permissions on the deploy script

```shell
chmod +x deploy.sh
```

Finally, run the deploy script.

* You will need to set environment variables for:

    1. CREDS - the path to the `pem` credentials file for Amazon
    2. APP_USER - this will be `ec2-user` for AWS 
    3. APP_IP_ADDRESS - This will be the *Public IPv4 address for the EC2 Server. You can find this from the AWS EC2 console page.

```shell
CREDS=<path to private key> APP_USER=<username> APP_IP_ADDRESS=<your ip address> ./deploy.sh

# For example:
CREDS="~/.aws/aws.pem" APP_USER=ec2_user APP_IP_ADDRESS="13.15.196.198" ./deploy.sh
```

## Usage

You should now be able to visit the running app in the browser using the IP Address for the App.

* Replace the IP address below with your EC2 IP Address

```shell
13.15.196.198
```

## Author

* **Jeremy Hill**

### Digital Ocean

https://www.digitalocean.com/community/tutorials/how-to-use-ssh-keys-with-digitalocean-droplets
