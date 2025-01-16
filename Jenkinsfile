pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "djangocorepipeline:${env.BUILD_ID}"
        DOCKER_REGISTRY = "localhost:5000"
    }
    stages {
        stage('Pre-Build: Análisis estático') {
            steps {
                script {
                    echo "Ejecutando análisis estático..."
                }
                // Validación con flake8
                sh 'pip install flake8 pylint'
                sh 'flake8 proyecto/'
                // Validación con pylint
                sh 'pylint proyecto/'
            }
        }
        stage('Build') {
            steps {
                script {
                    echo "Compilando y creando la imagen Docker..."
                }
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }
        stage('Test') {
            steps {
                script {
                    echo "Ejecutando pruebas..."
                }
                // Instalar dependencias necesarias para pruebas
                sh 'pip install pytest'
                // Pruebas unitarias
                sh 'pytest proyecto/tests/'
            }
        }
        stage('Deploy') {
            steps {
                script {
                    echo "Desplegando aplicación en Docker..."
                }
                sh 'docker run -d -p 8000:8000 $DOCKER_IMAGE'
            }
        }
    }
    post {
        always {
            script {
                echo "Limpieza del entorno..."
            }
            sh 'docker system prune -f'
        }
    }
}
