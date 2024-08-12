pipeline {
    agent any

    environment {
        registry = "590183706325.dkr.ecr.ap-south-1.amazonaws.com/docker-repo"
        imageName = "spring-helm"
        awsCredentialsId = "aws-ecr-credentials"
        region = "ap-south-1"  // Set the AWS region
        namespace = "dev"      // Define the namespace
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/akannan1087/docker-spring-boot']])
            }
        }
         stage ("Build JAR") {
            steps {
                sh "mvn clean install"
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${imageName}:${BUILD_NUMBER} ."
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: awsCredentialsId]]) {
                        sh "aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${registry}"
                        sh "docker tag ${imageName}:${BUILD_NUMBER} ${registry}:${BUILD_NUMBER}"
                        sh "docker push ${registry}:${BUILD_NUMBER}"
                    }
                }
            }
        }
        
        stage('Deploy with Helm') {
            steps {
                script {
                    sh "helm upgrade --install ${imageName} ./mychart --namespace ${namespace} --set image.repository=${registry} --set image.tag=${BUILD_NUMBER}"
                }
            }
        }
    }

    post {
        failure {
            echo 'Pipeline failed. Please check the logs for more details.'
        }
        success {
            echo 'Pipeline succeeded.'
        }
    }
}
