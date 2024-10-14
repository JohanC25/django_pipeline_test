pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/JohanC25/django_pipeline_test.git', branch: 'master'
            }
        }

        stage('Verificar Python y pip') {
            steps {
                withEnv(['PATH+CUSTOM=C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312;C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312\\Scripts']) {
                    bat '''
                    echo Verificando instalación de Python y pip...
                    python --version
                    pip --version
                    '''
                }
            }
        }

        stage('Instalar dependencias') {
            steps {
                withEnv(['PATH+CUSTOM=C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312;C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312\\Scripts']) {
                    bat '''
                    echo Instalando dependencias...
                    pip install --upgrade pip
                    pip install -r requirements.txt
                    '''
                }
            }
        }

        stage('Migrar y Testear') {
            steps {
                withEnv(['PATH+CUSTOM=C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312;C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312\\Scripts']) {
                    bat '''
                    echo Aplicando migraciones...
                    python manage.py migrate

                    echo Ejecutando pruebas...
                    python manage.py test
                    '''
                }
            }
        }

        stage('Análisis de Código') {
            steps {
                withEnv(['PATH+CUSTOM=C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312;C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312\\Scripts']) {
                    bat '''
                    echo Ejecutando análisis de código...
                    pylint myapp/
                    '''
                }
            }
        }

        stage('Simulación de Despliegue') {
            steps {
                withEnv(['PATH+CUSTOM=C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312;C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312\\Scripts']) {
                    bat '''
                    echo Simulando despliegue...
                    python manage.py runserver 0.0.0.0:8000
                    '''
                }
            }
        }
    }

    post {
        always {
            echo 'Limpieza después de la ejecución...'
        }
        success {
            echo 'Pipeline completado exitosamente.'
        }
        failure {
            echo 'Pipeline falló.'
        }
    }
}
