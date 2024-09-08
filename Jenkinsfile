pipeline{
    agent any
    environment {
        DOCKER_IMAGE = 'nchereddy/${env.JOB_NAME}:${BUILD_NUMBER}'
        CREDENTIAL_ID = credentials('docker-hub')
        
    }
    stages {
        stage("checkout the code"){
            steps {
                git url:'https://github.com/chereddynag/jenkins.git'
            }
        }
        stage('Build docker Image'){
            steps{
                script{
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }
        
}
}