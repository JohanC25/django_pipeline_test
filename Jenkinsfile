// Pipeline para la rama "security"
pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "localhost:5000/djangocorepipeline:${env.BUILD_ID}"
        NGINX_IMAGE = "nginx:latest"
    }
    stages {
        stage('Security Scan: Django') {
            steps {
                script {
                    echo "Ejecutando análisis de seguridad con Trivy para Django..."
                }
                bat '''
                docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image %DOCKER_IMAGE% --severity CRITICAL || exit 1
                '''
            }
        }
        stage('Security Scan: Nginx') {
            steps {
                script {
                    echo "Ejecutando análisis de seguridad con Trivy para Nginx..."
                }
                bat '''
                docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image %NGINX_IMAGE% --severity CRITICAL || exit 1
                '''
            }
        }
    }
    post {
        success {
            build job: 'Pipeline-Test'
        }
    }
}
