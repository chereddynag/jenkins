pipeline{
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }
    environment {
        DOCKER_IMAGE = 'nchereddy/${env.JOB_NAME}:${BUILD_NUMBER}'
        CREDENTIAL_ID = credentials('docker_hub')
        
    }
    stages {
        stage()
        stage('Build docker Image'){
            steps{
                script{
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }
        
}
}