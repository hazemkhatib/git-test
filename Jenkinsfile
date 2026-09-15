pipeline {
    agent any

    environment {
        DOCKER_USER = 'hazem08'
        IMAGE_NAME  = 'my-app'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                // בניית ה-Image באמצעות פקודת Shell רגילה
                sh "docker build -t ${DOCKER_USER}/${IMAGE_NAME}:${BUILD_NUMBER} ."
                sh "docker tag ${DOCKER_USER}/${IMAGE_NAME}:${BUILD_NUMBER} ${DOCKER_USER}/${IMAGE_NAME}:latest"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                // התחברות ל-Docker Hub והעלאת ה-Image
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_HUB_USER', passwordVariable: 'DOCKER_HUB_PASS')]) {
                    sh "echo \$DOCKER_HUB_PASS | docker login -u \$DOCKER_HUB_USER --password-stdin"
                    sh "docker push ${DOCKER_USER}/${IMAGE_NAME}:${BUILD_NUMBER}"
                    sh "docker push ${DOCKER_USER}/${IMAGE_NAME}:latest"
                }
            }
        }
    }

    post {
        always {
            // ניקוי התחברות
            sh "docker logout"
        }
    }
}
