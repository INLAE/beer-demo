pipeline {
    agent any

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
    }

    post {
        always {
            echo "Build completed with status: ${currentBuild.result}"
        }
    }
}