node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("vaibhav27/hello-world")
    }


    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        
        
        docker.withRegistry("https://456624778202.dkr.ecr.us-east-1.amazonaws.com", "aws") {
            docker.image("456624778202.dkr.ecr.us-east-1.amazonaws.com/genodejs").push()  
        }
        

        kubernetesDeploy(kubeconfigId: 'kubeconfig',
                     configs: 'deploy.yaml',
                     enableConfigSubstitution: false)

    }
}
