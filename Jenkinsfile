pipeline{
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }
    environment {
        DOCKER_IMAGE = "nchereddy/${env.JOB_NAME}:${env.BUILD_NUMBER}"
        CREDENTIAL_ID = 'docker_hub'
        DOCKER_REGISTRY = 'https://index.docker.io/v1/'

    }
    stages {
        stage('Build docker Image'){
            steps{
                script{
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }
        stage("login and push the image to the docker hub"){
            steps{
                script{
                    
                    docker.withRegistry("${DOCKER_REGISTRY}", "${CREDENTIAL_ID}"){
                        docker.image("${DOCKER_IMAGE}").push()
                    }
                }
            }
        }
        
}
}