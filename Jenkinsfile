pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                    git url: 'https://github.com/INLAE/beer-demo.git', branch: 'main'

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