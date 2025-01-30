// Pipeline para la rama "master"
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
                withSonarQubeEnv('SonarQube_Django_Taller') {
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
    }
    post {
        success {
            build job: 'Pipeline-Build'
        }
    }
}
