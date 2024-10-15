pipeline {
    agent any

    stages {
        stage('Instalar dependencias') {
            steps {
                script {
                    // Instalación de las dependencias desde requirements.txt
                    sh 'pip install -r requirements.txt'
                }
            }
        }

        stage('Verificar Sintaxis (Linting)') {
            steps {
                script {
                    // Ejecutar flake8 para verificar la sintaxis del código
                    sh 'pip install flake8'  // Aseguramos que flake8 está instalado
                    sh 'flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics'
                }
            }
        }

        stage('Migrar Base de Datos') {
            steps {
                script {
                    // Ejecutar las migraciones de la base de datos
                    sh 'python manage.py migrate'
                }
            }
        }

        stage('Despliegue') {
            steps {
                script {
                    // Correr el servidor Django en modo producción o construcción de la aplicación
                    sh 'python manage.py runserver 0.0.0.0:8000 --noreload'
                }
            }
        }
    }

    post {
        always {
            // Limpiar el workspace después de ejecutar el pipeline
            cleanWs()
        }
        success {
            echo 'Pipeline ejecutado correctamente.'
        }
        failure {
            echo 'El pipeline ha fallado. Revisa los errores.'
        }
    }
}
