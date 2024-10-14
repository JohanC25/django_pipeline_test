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

        stage('Migrar') {
            steps {
                withEnv(['PATH+CUSTOM=C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312;C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312\\Scripts']) {
                    bat '''
                    echo Aplicando migraciones...
                    python manage.py migrate
                    '''
                }
            }
        }

        stage('Pruebas Ficticias') {
            steps {
                withEnv(['PATH+CUSTOM=C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312;C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312\\Scripts']) {
                    bat '''
                    echo No se encontraron pruebas definidas. Ejecutando prueba ficticia...
                    python -c "print('Prueba ficticia ejecutada exitosamente.')"
                    '''
                }
            }
        }

        stage('Análisis de Código') {
            steps {
                withEnv(['PATH+CUSTOM=C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312;C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312\\Scripts']) {
                    bat '''
                    echo Instalando Pylint...
                    pip install pylint

                    echo Ejecutando análisis de código...
                    pylint base/
                    '''
                }
            }
        }

        stage('Simulación de Despliegue') {
            steps {
                withEnv(['PATH+CUSTOM=C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312;C:\\Users\\johan\\AppData\\Local\\Programs\\Python\\Python312\\Scripts']) {
                    bat '''
                    echo Simulando despliegue...
                    python manage.py runserver 0.0.0.0:8000 --noreload &
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
