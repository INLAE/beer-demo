pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "shrekhub/beer-demo:latest"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code..."
                git url: 'https://github.com/INLAE/beer-demo.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                echo "Building the project with Maven..."
                sh "./mvnw clean package"
            }
        }

        stage('Archive Artifacts') {
            steps {
                echo "Archiving build artifacts..."
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo "Pushing Docker image to Docker Hub..."
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                echo "Stopping and removing old container (if exists)..."
                sh "docker stop beer-demo-container || true"
                sh "docker rm beer-demo-container || true"

                echo "Running new Docker container..."
                sh "docker run -d -p 8080:8080 --name beer-demo-container ${DOCKER_IMAGE}"
            }
        }
    }

    post {
        always {
            echo "Pipeline completed with status: ${currentBuild.result}"
        }
    }
}