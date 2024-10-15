pipeline {
    agent any

    stages {
        stage('Instalar dependencias') {
            steps {
                script {
                    // Instalación de las dependencias desde requirements.txt en Windows
                    bat 'pip install -r requirements.txt'
                }
            }
        }

        stage('Verificar Sintaxis (Linting)') {
            steps {
                script {
                    // Ejecutar flake8 para verificar la sintaxis del código en Windows
                    bat 'pip install flake8'  // Aseguramos que flake8 está instalado
                    bat 'flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics'
                }
            }
        }

        stage('Migrar Base de Datos') {
            steps {
                script {
                    // Ejecutar las migraciones de la base de datos en Windows
                    bat 'python manage.py migrate'
                }
            }
        }

        stage('Despliegue') {
            steps {
                script {
                    // Correr el servidor Django en modo producción en Windows
                    bat 'python manage.py runserver 0.0.0.0:8000 --noreload'
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
