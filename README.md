# Getting Started / Overview

We are going to perform POC setting up a environment for mcrew in which we are going to test out Deployment on Kubernetes using Jenkins to drive that with the help of Jenkinsfile which is going to be in the private github repository. Assuming both Jenkins and Kubernetes has been deployed on DC/OS platform.

# Pre-requisites

1) Jenkins Deployed over DC/OS (We can find it under catalog for DC/OS and just run the service to get deployed there)
2) Kuberentes being Deployed on the same DC/OS (Same procedure as above)
3) **DCOS CLI** set up in your system
4) **kubectl** set up needs to be done to check the cluster and nodes info.

```
dcos package install kubernetes --cli
dcos kubernetes kubeconfig
kubectl get all
```

# Configuration Files

Download the Dockefile, Jenkinsfile, main.js, deploy.yaml and package.json for the sample example we are taking to deploy an basic app onto kuberentes.

You can clone the repository for all the documents as well:
```
git clone https://github.build.ge.com/trans-comm-ros-dev/mcrew-test
```

# Build Steps

Check the services on kubernetes if they are in the ready state by using following commands:

```
kubectl get nodes -o wide

kubectl get po
```

Building the docker image on your system and pushing it onto the dockerhub / registry with the following steps:

```
docker build . -t <repository name on dockerhub>
```

>check for images

```
docker images
```

>Running into your localhost

```
docker run -it -p 8000:8000 localhost:5000/<image name>
```

# Jenkins Pipeline setup 

Access your jenkins dashboard from your DC/OS cluster set up.

Step 1: Create a new pipeline.

Step 2: Give a unique name for the pipeline.

Step 3: Go to ***Pipeline*** tab and Select ***Pipeline Script from SCM***
