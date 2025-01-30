// Pipeline para la rama "test"
pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "localhost:5000/djangocorepipeline:${env.BUILD_ID}"
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

        stage('Deploy: Production Simulated') {
            steps {
                script {
                    echo "Desplegando aplicación en entorno de producción simulado..."
                }
                bat 'docker run -d -p 8000:8000 --name django-prod %DOCKER_IMAGE%'
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
