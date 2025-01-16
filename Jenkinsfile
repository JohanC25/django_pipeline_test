pipeline {
    agent any

    stages {
        stage('Declarative: Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Pre-Build: Análisis estático') {
            steps {
                echo 'Ejecutando análisis estático...'

                // Ajuste para compatibilidad con Windows
                script {
                    if (isUnix()) {
                        sh 'nohup ./static_analysis_tool.sh &'
                    } else {
                        bat 'start /b static_analysis_tool.bat'
                    }
                }
            }
            post {
                failure {
                    echo 'Error en la etapa de análisis estático.'
                }
            }
        }

        stage('Build') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                echo 'Construyendo el proyecto...'
                // Aquí puedes añadir tus pasos de construcción
                script {
                    if (isUnix()) {
                        sh './build.sh'
                    } else {
                        bat 'build.bat'
                    }
                }
            }
        }

        stage('Test') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                echo 'Ejecutando pruebas...'
                // Aquí puedes añadir tus pasos de prueba
                script {
                    if (isUnix()) {
                        sh './run_tests.sh'
                    } else {
                        bat 'run_tests.bat'
                    }
                }
            }
        }

        stage('Deploy') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                echo 'Desplegando la aplicación...'
                // Aquí puedes añadir tus pasos de despliegue
                script {
                    if (isUnix()) {
                        sh './deploy.sh'
                    } else {
                        bat 'deploy.bat'
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Limpieza del entorno...'
            script {
                if (isUnix()) {
                    sh 'rm -rf workspace_temp_files'
                } else {
                    bat 'del /Q workspace_temp_files'
                }
            }
        }
        success {
            echo 'Pipeline ejecutado con éxito.'
        }
        failure {
            echo 'Pipeline falló. Revisa los logs para más detalles.'
        }
    }
}
