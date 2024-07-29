pipeline {
    agent any

    environment {
        registry = "590183706325.dkr.ecr.ap-south-1.amazonaws.com/docker"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Bhargavi-lakamsani/docker-spring-boot.git']])
            }
        }
    
        stage('Build Image') {
            steps {
                script {
                    sh "docker build -t ${registry}:${BUILD_NUMBER} ."
                }
            }
        }
        
        stage('Push to ECR') {
            steps {
                script {
                    sh "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 590183706325.dkr.ecr.ap-south-1.amazonaws.com"
                    sh "docker push 590183706325.dkr.ecr.ap-south-1.amazonaws.com/docker:$BUILD_NUMBER"
                }
            }
        }
        
        stage('Helm package') {
            steps {
                sh "helm package springboot"
            }
        }
        
        stage('Helm Deploy') {
            steps {
                script {
                    sh "helm upgrade first --install mychart --namespace helm-deployment --set image.tag=$BUILD_NUMBER"
                }
            }
        }
    }
}
