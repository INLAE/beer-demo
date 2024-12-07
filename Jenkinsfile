pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
         }
        }

        stage('Build') {
            steps {
              sh "./mvnw clean package"
            }
        }

        stage('Archive Artifacts') {
            steps {
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