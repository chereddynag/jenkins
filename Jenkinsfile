pipeline{
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }
    environment {
        IMAGE_NAME = "${env.JOB_NAME}"
        DOCKER_REPO_IMAGE = "nchereddy/${env.JOB_NAME}:${env.BUILD_NUMBER}"
        CREDENTIAL_ID = 'docker_hub'
        REMOTE_DOCKER_HOST = '192.168.30.5'
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
                        docker.image("${DOCKER_REPO_IMAGE}").push()
                    }
                }
            }
        }
        stage("Cleaning the local images"){
            steps{
                script{
                    sh "docker rmi ${DOCKER_REPO_IMAGE}"
                }
            }
        }
        stage("Deploy the docker container to the Remote"){
            steps{
                script{
                    sshagent([SSH_CREDS]) {
                        sh """
                        ssh -o StrictHostKeyChecking=no ubuntu@${REMOTE_DOCKER_HOST} << EOF
                            # Pull the image from the Docker registry or copy from Jenkins
                            docker pull ${DOCKER_REPO_IMAGE}
                            
                            # Stop the existing container (if running)
                            docker stop ${IMAGE_NAME} || true
                            docker rm ${IMAGE_NAME} || true
                            
                            # Run the new container
                            docker run -d --name ${IMAGE_NAME} -p 8080:8080 ${DOCKER_REPO_IMAGE}
                        EOF
                        """
                    }
                }
            }
        }
        
}
}