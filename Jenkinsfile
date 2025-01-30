// Pipeline para la rama "test"
pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "localhost:5000/djangocorepipeline:${env.BUILD_ID}"
    }
    stages {
        stage('Test') {
            steps {
                script {
                    echo "Ejecutando pruebas..."
                }
                bat 'pip install pytest'
                bat 'pytest proyecto/tests/ || exit 1'
            }
        }
    }
}
