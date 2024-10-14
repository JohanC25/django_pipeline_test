pipeline {
    agent any
    
    stages {
        stage('Instalar dependencias') {
            steps {
                script {
                    // Crear un entorno virtual en Windows
                    sh 'python -m venv venv'
                    
                    // Activar el entorno virtual en Windows
                    sh 'venv\\Scripts\\activate'
                    
                    // Instalar las dependencias
                    sh 'pip install -r requirements.txt'
                }
            }
        }
        
        stage('Migrar y Testear') {
            steps {
                script {
                    // Aplicar migraciones
                    sh 'venv\\Scripts\\python manage.py migrate'
                    
                    // Ejecutar pruebas
                    sh 'venv\\Scripts\\python manage.py test'
                }
            }
        }
        
        stage('Análisis de Código') {
            steps {
                script {
                    // Usar flake8 para análisis de estilo y errores
                    sh 'venv\\Scripts\\pip install flake8'
                    sh 'venv\\Scripts\\flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics'
                }
            }
        }
        
        stage('Simulación de Despliegue') {
            steps {
                script {
                    // Simulación del empaquetado de la aplicación para producción
                    echo 'Simulando el empaquetado para producción...'
                    
                    // Crear el paquete .tar.gz como si estuvieras preparando el proyecto para el despliegue
                    sh 'tar -czf django_project.tar.gz .'
                    
                    // Aquí se podría realizar un despliegue real si se tiene configurada infraestructura
                    echo 'Despliegue simulado completo'
                }
            }
        }
    }
    
    post {
        always {
            // Limpiar los archivos temporales si es necesario
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
