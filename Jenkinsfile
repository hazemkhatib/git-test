pipeline {
    agent any

    environment {
        DOCKER_USER = 'hazemkhatib'
        IMAGE_NAME  = 'my-app'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                // שימוש ב-sh עם מחרוזות Groovy תקינות
                sh "docker build -t ${env.DOCKER_USER}/${env.IMAGE_NAME}:${env.BUILD_NUMBER} ."
                sh "docker tag ${env.DOCKER_USER}/${env.IMAGE_NAME}:${env.BUILD_NUMBER} ${env.DOCKER_USER}/${env.IMAGE_NAME}:latest"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_HUB_USER', passwordVariable: 'DOCKER_HUB_PASS')]) {
                    sh 'echo "$DOCKER_HUB_PASS" | docker login -u "$DOCKER_HUB_USER" --password-stdin'
                    sh "docker push ${env.DOCKER_USER}/${env.IMAGE_NAME}:${env.BUILD_NUMBER}"
                    sh "docker push ${env.DOCKER_USER}/${env.IMAGE_NAME}:latest"
                }
            }
        }
    }

    post {
        always {
            sh 'docker logout || true'
        }
    }
}
