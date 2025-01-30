// Pipeline para la rama "build"
pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "localhost:5000/djangocorepipeline:${env.BUILD_ID}"
    }
    stages {
        stage('Build') {
            steps {
                script {
                    echo "Compilando y creando la imagen Docker..."
                }
                bat 'docker build -t %DOCKER_IMAGE% . || exit 1'
            }
        }
    }
    post {
        success {
            build job: 'Pipeline-Security'
        }
    }
}
