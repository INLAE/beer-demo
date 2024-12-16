pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "beer-demo:latest"
        CONTAINER_NAME = "beer-demo-container"
        APP_PORT = "8081"
        CONTAINER_PORT = "8080"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code from GitHub..."
                git url: 'https://github.com/INLAE/beer-demo.git', branch: 'main'
            }
        }

        stage('Build Maven Project') {
            steps {
                echo "Building project with Maven..."
                sh "./mvnw clean package"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image locally..."
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Run Docker Container') {
            steps {
                echo "Stopping and removing old container if it exists..."
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"

                echo "Running new Docker container on port ${APP_PORT}..."
                sh "docker run -d -p ${APP_PORT}:${CONTAINER_PORT} --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
            }
        }

        stage('Verify Deployment') {
            steps {
                echo "Waiting for the application to start..."
                sh "sleep 10" // Пауза перед проверкой

                echo "Checking if the application is running..."
                sh "curl -I http://localhost:${APP_PORT}/beers || exit 1"
            }
        }
    }

    post {
        always {
            echo "Pipeline completed with status: ${currentBuild.result}"
        }
        success {
            echo "Deployment successful! Application is running on http://localhost:${APP_PORT}"
        }
        failure {
            echo "Deployment failed! Check the logs for details."
        }
    }
}