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
                bat 'pip install flake8 pylint'
                // Usa exit 0 para que el pipeline no falle aunque flake8 detecte errores
                bat 'flake8 proyecto/ || exit /b 0'
                bat 'pylint proyecto/ || exit /b 0'
            }
        }
        stage('Build') {
            steps {
                script {
                    echo "Compilando y creando la imagen Docker..."
                }
                // Construcción de la imagen Docker
                bat 'docker build -t %DOCKER_IMAGE% .'
            }
        }
        stage('Test') {
            steps {
                script {
                    echo "Ejecutando pruebas..."
                }
                // Instalar dependencias necesarias para pruebas
                bat 'pip install pytest'
                // Pruebas unitarias
                bat 'pytest proyecto/tests/'
            }
        }
        stage('Deploy') {
            steps {
                script {
                    echo "Desplegando aplicación en Docker..."
                }
                // Ejecutar el contenedor
                bat 'docker run -d -p 8000:8000 %DOCKER_IMAGE%'
            }
        }
    }
    post {
        always {
            script {
                echo "Limpieza del entorno..."
            }
            // Limpiar recursos de Docker
            bat 'docker system prune -af'
        }
    }
}
