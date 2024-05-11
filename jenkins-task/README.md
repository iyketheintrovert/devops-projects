# Jenkins Exercise

> Create a Freestyle Jenkins Project
> Create a Jenkins Pipeline

## Create Virtual Machine (AWS)

- Log into your aws account with your credentials
  As a security measure, it is good practice to configure 2FA on your account to prevent unauthorized access.

- Search for EC2 and click on launch instance
- Fill the necessary details and click on create
- After creation, connect to your instance either locally or through the web console

![EC2 Console](images/launch-instance.png)
![EC2 Console](images/launch-instance-1.png)
![EC2 Console](images/launch-instance-2.png)

## Install Jenkins

- Install and Connect to Jenkins
  It is good practice to create a user account on your virtual machine so you preserve the integrity of the root user.

  ```sudo adduser <username>```
  - Provide your password and other optional info
  ```usermod -aG sudo <username>``` - This command adds the new user to the sudo group
  ```su <username>``` - switches account to the new user

  ![Add User](images/adduser.png)

- Install jdk
```sudo apt install default-jdk-headless```

``` shell
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
```

- Ensure Jenkins is running using:
```sudo systemctl status jenkins```

![Jenkins Running](images/jenkins-running.png)

- Update your security group on AWS to allow access to port 8080

![Security Group](images/security-group.png)

- Visit the IP address on port 8080 and log in to the Jenkins Dashboard
![Jenkins](images/customize-jenkins.png)

- Install git, docker and other recommended plugins
![Jenkins](images/plugins.png)

- For security, I added a password to ensure that access to my pipeline is only accessible to authorized persons.
![Jenkins](images/create-user.png)
![Jenkins](images/jenkins-start.png)

## SCM Integration

- To integrate Jenkins to my Git, I had to create a project first, clicked on the configure option and configured Build Triggers to connect with GITScm polling.
- I then went to Github, under my repository settings to configure webhook to my Jenkins IP address.

![Webhook](images/webhook.png)

```http://your-ip-address/github-webhook/```

- Set the content type to application/json. The default event is push.

![Webhook](images/webhook-1.png)

## Create Freestyle Project

![Home](images/jenkins-home.png)

- Click on new item, choose a name and select freestyle

![Create Job](images/create-job.png)

- Configure jenkins and set build trigger to push from git

![Home](images/freestyle-settings.png)
![Home](images/freestyle-settings-1.png)
![Home](images/freestyle-settings-2.png)

- Since I already set the webhook, once I push to the repo, it'll trigger a build
- push to git repo to trigger build

![Jenkins Freestyle Project](images/jenkins-freestyle.png)
![Jenkins Freestyle Project](images/freestyle.png)

## Install Docker on Server

``` bash
  sudo apt-get update -y
  sudo apt-get install ca-certificates curl gnupg
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update -y
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
    sudo systemctl status docker
```

![Docker](images/docker-running.png)

- Add Jenkins to Docker sudo group
```usermod -aG sudo docker jenkins```

- Restart Jenkins
```sudo systemctl restart jenkins```

## Configure Docker on Jenkins

- Create a token on Dockerhub to protect your login credentials
![Docker-token](images/dockerhub-1.png)

- Create credentials on Jenkins
![Docker-credentials](images/add-credentials-docker.png)
![Docker-credentials](images/add-credentials-docker-1.png)
![Docker-credentials](images/add-credentials-docker-2.png)
![Docker-credentials](images/add-credentials-docker-3.png)
![Docker-credentials](images/add-credentials-docker-4.png)

## Create Pipeline Project

- Click on new item, choose a name and select pipeline

![Pipeline-project](images/pipeline-project.png)

- Configure jenkins and set build trigger to push from git

![Pipeline-settings](images/pipeline-settings.png)
![Pipeline-settings](images/pipeline-settings-1.png)

- Create pipeline script

![Pipeline-settings](images/pipeline-settings-2.png)

- git push to your git repo to trigger build
- Create Dockerfile
- Create index file
- push changes to the repo to trigger build

## Docker Image Creation

- To create a Docker image using Jenkins, you must include your docker file in your repository. The dockerfile contains commands used in creating a docker image.
- Once your dockerfile is ready, you can run:

```docker image build -t <name of your dockerfile> .```

- Since the pipeline is going to run this automatically, you don't have to run the script manually.

```docker images ls``` - This woud list all built images on your server.

## Docker Container Run

- To run a container, you use the image alredy built or an existing one from Dockerhub.
- Run ```docker run -itd --name nginx -p 8081:80 dockerfile```
- itd means you want to run your container in interactive and detached mode. This allows you access to your terminal afterwards.
- -p referes to the port you want to serve your image from.
- --name is optional but it refers to the name of the container being run and,
- The last option is the name of the image.

## Docker Push

- To push an image to DockerHub, you need to have authenticated.
- You also need the registry url (private or public)
- Run ```docker push <your-account>/<imagename>``` - by default, the tag would be latest.

![Homepage](images/success-pipeline.png)

![Dockerhub](images/dockerhub.png)

![Homepage](images/home.png)
