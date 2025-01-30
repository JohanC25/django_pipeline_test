pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "localhost:5000/djangocorepipeline:latest"
        DOCKER_REGISTRY = "localhost:5000"
    }
    stages {
        stage('Build') {
            steps {
                script {
                    echo "Compilando y creando la imagen Docker..."
                }
                bat 'docker build -t %DOCKER_IMAGE% . || exit 1'
                bat 'docker push %DOCKER_IMAGE% || exit 1'
            }
        }
    }
    post {
        success {
            build job: 'Pipeline-Security'
        }
    }
}
