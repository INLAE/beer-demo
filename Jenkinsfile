pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "beer-demo:latest"   // Локальное имя образа
        CONTAINER_NAME = "beer-demo-container"
        JAR_FILE = "target/beer-demo-0.0.1-SNAPSHOT.jar"  // Путь к JAR-файлу
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code..."
                git url: 'https://github.com/INLAE/beer-demo.git', branch: 'main'
            }
        }

        stage('Build with Maven') {
            steps {
                echo "Building project with Maven..."
                sh "./mvnw clean package"  // Сборка проекта
                echo "Verifying JAR file..."
                sh "ls -l ${JAR_FILE}"     // Проверка существования JAR-файла
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

                echo "Running new Docker container..."
                sh "docker run -d -p 8080:8080 --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully! Access the application at http://localhost:8080"
        }
        failure {
            echo "Pipeline failed! Please check the logs for errors."
        }
        always {
            echo "Pipeline completed with status: ${currentBuild.result}"
        }
    }
}