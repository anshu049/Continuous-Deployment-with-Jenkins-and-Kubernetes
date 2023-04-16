pipeline {
    agent any
    
    environment {
        SERVICE_NAME = "linux-tweet-app"
        ORGANIZATION_NAME = "anshuhtwt"
        DOCKERHUB_USERNAME = "anshuhtwt"
        REPOSITORY_TAG = "${DOCKERHUB_USERNAME}/${ORGANIZATION_NAME}-${SERVICE_NAME}:${BUILD_ID}"
    }
   
    stages {
            
            
        stage ('Build and Push Image') {
            steps {
                 withDockerRegistry([credentialsId: 'docker-hub', url: ""]) {
                   sh 'docker build -t ${REPOSITORY_TAG} .'
                   sh 'docker push ${REPOSITORY_TAG}'          
            }
          }
       }
        stage("Install kubectl on worker nodes"){
            steps {
                sh """
                    curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
                    chmod +x ./kubectl
                    ./kubectl version --client
                """
            }
        }
        
        stage ('Deploy to Cluster') {
            steps {
                sh "aws eks update-kubeconfig --region eu-west-2 --name ekscluster"
                sh " envsubst < ${WORKSPACE}/deployment.yaml | ./kubectl apply -f - "
            }
        }
    }
}
