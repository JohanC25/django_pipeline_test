pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout del código desde el repositorio Git
                git url: 'https://github.com/JohanC25/django_pipeline_test.git', branch: 'master'
            }
        }

        stage('Instalar dependencias') {
            steps {
                // Usar 'bat' para ejecutar comandos en Windows
                bat '''
                echo Instalando dependencias...
                pip install --upgrade pip
                pip install -r requirements.txt
                '''
            }
        }

        stage('Migrar y Testear') {
            steps {
                // Ejecutar las migraciones y pruebas
                bat '''
                echo Aplicando migraciones...
                python manage.py migrate

                echo Ejecutando pruebas...
                python manage.py test
                '''
            }
        }

        stage('Análisis de Código') {
            steps {
                // Análisis de código con pylint, por ejemplo
                bat '''
                echo Ejecutando análisis de código...
                pylint myapp/
                '''
            }
        }

        stage('Simulación de Despliegue') {
            steps {
                // Simulación de un despliegue local
                bat '''
                echo Simulando despliegue...
                python manage.py runserver 0.0.0.0:8000
                '''
            }
        }
    }

    post {
        always {
            echo 'Limpieza después de la ejecución...'
            // Opcionalmente puedes agregar pasos de limpieza si lo necesitas
        }
        success {
            echo 'Pipeline completado exitosamente.'
        }
        failure {
            echo 'Pipeline falló.'
        }
    }
}
