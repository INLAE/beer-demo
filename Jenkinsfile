pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code..."
                git url: 'https://github.com/INLAE/beer-demo.git', branch: 'main'
            }
        }

        stage('Build & Deploy') {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t myapp:latest .'

                echo "Running container..."
                // На случай, если контейнер с таким именем уже запущен, остановим его
                sh 'docker stop myapp || true'
                sh 'docker rm myapp || true'

                // Запускаем новый контейнер
                sh 'docker run -d --name myapp -p 8080:8080 myapp:latest'
            }
        }
    }

    post {
        always {
            echo "Pipeline completed with status: ${currentBuild.result}"
        }
    }
}