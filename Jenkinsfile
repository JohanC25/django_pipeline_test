pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "localhost:5000/djangocorepipeline:latest"
    }
    stages {
        stage('Test') {
            steps {
                script {
                    echo "Ejecutando pruebas..."
                }
                bat 'pip install pytest'
                bat 'pytest proyecto/tests/ || exit 1'
            }
        }

        stage('Deploy: Testing Simulated') {
            steps {
                script {
                    echo "Desplegando aplicación en entorno de pruebas simulado..."
                }
                bat '''
                docker ps -a -q --filter "name=django-test" | findstr . && docker rm -f django-test || echo "No hay contenedores previos con el nombre django-test"
                docker run -d -p 8081:8000 --name django-test %DOCKER_IMAGE%
                '''
            }
        }

        stage('Deploy: Production Simulated') {
            steps {
                script {
                    echo "Desplegando aplicación en entorno de producción simulado..."
                }
                bat '''
                docker ps -a -q --filter "name=django-prod" | findstr . && docker rm -f django-prod || echo "No hay contenedores previos con el nombre django-prod"
                docker run -d -p 8000:8000 --name django-prod %DOCKER_IMAGE%
                '''
            }
        }

        stage('Post-Deployment Security Monitoring') {
            steps {
                script {
                    echo "Configurando monitoreo de seguridad post-despliegue con Falco..."
                }
                bat 'docker run -d --name falco --privileged -v /var/run/docker.sock:/host/var/run/docker.sock falcosecurity/falco:latest'
            }
        }
    }
}
