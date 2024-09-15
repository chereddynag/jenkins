pipeline{
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }
    environment {
        IMAGE_NAME = "${env.JOB_NAME}"
        GCR_REGION = "us-west1-docker.pkg.dev"
        GCR_IMAGE_URI = "${GCR_REGION}/${GCR_PROJECT_ID}/chereddy/${env.JOB_NAME}:${env.BUILD_NUMBER}"
        GOOGLE_APPLICATION_CREDENTIALS = credentials('devops')
        GCR_PROJECT_ID= 'fluted-volt-428205-p7'
        // REMOTE_DOCKER_HOST = '192.168.30.5'
        // DOCKER_REGISTRY = 'https://index.docker.io/v1/'

    }
    stages {
        stage('Authenticate with GCP'){
            steps{
            script{
            sh 'echo ${GOOGLE_APPLICATION_CREDENTIALS} | base64 --decode > /tmp/gcloud-key.json'
            sh 'gcloud config set project fluted-volt-428205-p7'
            sh 'gcloud auth activate-service-account --key-file=/tmp/gcloud-key.json'
        }
        }
        }
        stage('Build docker Image'){
            steps{
                script{
                    sh 'docekr build -t ${GCR_IMAGE_URI}'
            }
        }
        stage("login and push the image to the docker hub"){
            steps{
                script{
                    
                    sh 'gcloud auth configure-docker ${GCR_REGION} '
                    sh 'gcloud push ${GCR_IMAGE_URI}'
                    }
                }
            }
        }
        stage("Cleaning the local images"){
            steps{
                script{
                    sh 'docker rmi ${GCR_IMAGE_URI}'
                }
            }
        }
        // stage("Deploy the docker container to the Remote"){
        //     steps{
        //         script{
        //             sshagent([SSH_CREDS]) {
        //                 sh """
        //                 ssh -o StrictHostKeyChecking=no ubuntu@${REMOTE_DOCKER_HOST} << EOF
        //                     # Pull the image from the Docker registry or copy from Jenkins
        //                     docker pull ${DOCKER_REPO_IMAGE}
                            
        //                     # Stop the existing container (if running)
        //                     docker stop ${IMAGE_NAME} || true
        //                     docker rm ${IMAGE_NAME} || true
                            
        //                     # Run the new container
        //                     docker run -d --name ${IMAGE_NAME} -p 8080:8080 ${DOCKER_REPO_IMAGE}
        //                 EOF
        //                 """
        //             }
        //         }
        //     }
        // }
        
}
}