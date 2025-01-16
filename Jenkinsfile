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
                bat 'flake8 proyecto/ || exit /b 0'
                bat 'pylint proyecto/ || exit /b 0'
            }
        }
        stage('Build') {
            steps {
                script {
                    echo "Compilando y creando la imagen Docker..."
                }
                bat 'docker build -t %DOCKER_IMAGE% .'
            }
        }
        stage('Test') {
            steps {
                script {
                    echo "Ejecutando pruebas..."
                }
                bat 'pip install pytest'
                bat 'pytest proyecto/tests/'
            }
        }
        stage('Clean Docker Environment') {
            steps {
                script {
                    echo "Limpiando contenedores en conflicto..."
                }
                bat '''
                FOR /F "tokens=*" %%i IN ('docker ps -q --filter "publish=8000"') DO docker rm -f %%i
                '''
            }
        }
        stage('Deploy') {
            steps {
                script {
                    echo "Desplegando aplicación en Docker..."
                }
                bat 'docker run -d -p 8000:8000 %DOCKER_IMAGE%'
            }
        }
    }
    post {
        always {
            script {
                echo "Limpieza del entorno..."
            }
            bat 'docker system prune -af'
        }
    }
}
