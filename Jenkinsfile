pipeline {
    agent any
    
    stages {
        stage('Instalar dependencias') {
            steps {
                script {
                    sh 'python3 -m venv venv'
                    sh '. venv/bin/activate'
                    sh 'pip install -r requirements.txt'
                }
            }
        }
        
        stage('Migrar y Testear') {
            steps {
                script {
                    sh 'python manage.py migrate'
                    sh 'python manage.py test'
                }
            }
        }
        
        stage('Análisis de Código') {
            steps {
                script {
                    sh 'pip install flake8'
                    sh 'flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics'
                }
            }
        }
        
        stage('Simulación de Despliegue') {
            steps {
                script {
                    echo 'Simulando el empaquetado para producción...'
                    sh 'tar -czf django_project.tar.gz .'
                    echo 'Despliegue simulado completo'
                }
            }
        }
    }
    
    post {
        always {
            echo 'Limpieza después de la ejecución...'
        }
        success {
            echo 'Pipeline ejecutado con éxito!'
        }
        failure {
            echo 'Pipeline falló.'
        }
    }
}
