pipeline {
    agent any 

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Verificar Python y pip') {
            steps {
                bat "python --version"
                bat "pip --version"
            }
        }
        stage('Instalar dependencias') {
            steps {
                bat "pip install -r requirements.txt"
            }
        }
        stage('Verificar Archivos Estáticos') {
            steps {
                script {
                    def staticDir = 'base/static'
                    if (!fileExists(staticDir)) {
                        error "La carpeta de archivos estáticos '${staticDir}' no existe."
                    }
                    echo "La carpeta de archivos estáticos '${staticDir}' existe."
                }
            }
        }
        stage('Ejecutar Pruebas') {
            steps {
                script {
                    echo "Ejecutando pruebas..."
                    bat "python manage.py test" // Reemplazado por la ejecución real de pruebas
                }
            }
        }
        stage('Análisis de Código') {
            steps {
                echo "Ejecutando análisis de código con Pylint..."
                bat "pylint base/"
            }
        }
        stage('Simulación de Despliegue') {
            steps {
                echo "Simulando despliegue en entorno de staging..."
                bat "echo 'Despliegue simulado exitosamente.'"
            }
        }
    }
    post {
        always {
            echo 'Limpieza después de la ejecución...'
        }
    }
}
