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

Step 4: Select Git from the SCM and enter the URL for your Git repository

Note it will be linked automatically if it is a public repo. For the private repo you need to add your credentials, either in a form of Username and password or we can do it from SSH key from Github.

ssh-keygen
save it and add it into your github repository and then add into Jenkins credentials with your private key selecting add credentials using SSH and Private Key.

Add a branch if you had any existing where your repository is present.

Step 5: Under the Script path we have to mention Jenkinsfile

Which we already added to our repository so that when we Build this pipeline it will take the jenkins file to build and deploy the kuberentes.

Step 6: Click on Apply and save it. Before Build for this Pipeline please go through the deployment steps below to check if evrything is set up fine and working appropriately to make this build error free.

Deploying to Kubernetes
Although we can do this using Kube deploy plugin present in the Jenkins as well but for now we have added all those steps on Jenkinsfile so that it will take all this process automatically.

Under staging we need to add following code in Jenkinsfile so that it can perform the deployment automatically.

 kubernetesDeploy(kubeconfigId: 'kubeconfig',
                     configs: 'deploy.yaml',
                     enableConfigSubstitution: false)
The deploy.yaml file for the above deployment would looks like:

apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: sample-k8s-deployment-3
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: sample-k8s-app
    spec:
      containers:
      - name: sample-k8s-app-container
        image: <docker-image name>
        imagePullPolicy: Always
        ports:
        - containerPort: 8080
Finishing the Build and Result
So when everything is configured according to the deployment step we can go ahead and click on Build for the Pipeline we had set up and when you go through the Console Output you will see first this pipeline will obtain Jenkinsfile form the Github repository we mentioned and then will run the pipeline with all Builds, fetching docker images etc. and finally deploying it onto kuberentes.

The Application will be deployed on port 8080 at end of deployment.

You can check the results using following kubectl commands:

kubectl get po
kubectl get deploy
You will notice the status of the deployment we performed will be seen as Running.
