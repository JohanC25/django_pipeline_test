pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "localhost:5000/djangocorepipeline:${env.BUILD_ID}"
        DOCKER_REGISTRY = "localhost:5000"
        NGINX_IMAGE = "nginx:latest"
        SONAR_HOST_URL = "http://localhost:9000/"
        SONAR_TOKEN = credentials('sonarqube-token')
    }
    stages {
        stage('Pre-Build: Análisis estático') {
            steps {
                script {
                    echo "Ejecutando análisis estático..."
                }
                bat 'pip install flake8 pylint'
                bat 'flake8 proyecto/ || echo "flake8 terminó con advertencias"'
                bat 'pylint proyecto/ || echo "pylint terminó con advertencias"'
            }
        }
        stage('SonarQube SAST Analysis') {
            steps {
                script {
                    echo "Ejecutando análisis SAST con SonarQube..."
                }
                // Ejecutar análisis con Sonar Scanner
                withSonarQubeEnv('SonarQube_Django_Taller') { // Asegúrate de que este nombre coincida con tu configuración en Jenkins
                    bat '''
                    sonar-scanner ^
                    -Dsonar.projectKey=djangocorepipeline ^
                    -Dsonar.sources=proyecto ^
                    -Dsonar.host.url=%SONAR_HOST_URL% ^
                    -Dsonar.login=%SONAR_TOKEN%
                    '''
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    echo "Compilando y creando la imagen Docker..."
                }
                bat 'docker build -t %DOCKER_IMAGE% . || exit 1'
            }
        }
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
        stage('Test') {
            steps {
                script {
                    echo "Ejecutando pruebas..."
                }
                bat 'pip install pytest'
                bat 'pytest proyecto/tests/ || exit 1'
            }
        }
        stage('Clean Docker Environment') {
            steps {
                script {
                    echo "Limpiando contenedores en conflicto..."
                }
                catchError(buildResult: 'SUCCESS', stageResult: 'UNSTABLE') {
                    bat '''
                    FOR /F "tokens=*" %%i IN ('docker ps -q --filter "publish=8000"') DO docker rm -f %%i || exit /b 0
                    '''
                }
            }
        }
        stage('Deploy: Testing Environment') {
            steps {
                script {
                    echo "Desplegando en entorno de pruebas..."
                }
                bat 'docker run -d -p 8001:8000 --name django-test --env TESTING=True %DOCKER_IMAGE%'
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
    post {
        always {
            script {
                echo "Limpieza del entorno..."
            }
            bat 'docker system prune -af'
        }
    }
}
