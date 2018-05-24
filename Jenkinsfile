node {
    
def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("nginx:1.8")
  
        
        kubernetesDeploy(kubeconfigId: 'kubeconfig',
                     configs: 'deploy.yaml',
                     enableConfigSubstitution: false)
    }

}
