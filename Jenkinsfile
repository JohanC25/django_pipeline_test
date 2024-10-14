pipeline {
    agent any

    environment {
        // Variables de entorno
        VENV_DIR = "${env.WORKSPACE}/venv" // Directorio del entorno virtual
        DB_NAME = "db.sqlite3" // Nombre de la base de datos SQLite
    }

    stages {
        stage('Preparación') {
            steps {
                script {
                    // Crear un entorno virtual
                    sh "python3 -m venv ${VENV_DIR}"

                    // Activar el entorno virtual y instalar dependencias
                    sh """
                    source ${VENV_DIR}/bin/activate
                    pip install -r requirements.txt
                    """
                }
            }
        }

        stage('Migraciones') {
            steps {
                script {
                    // Activar el entorno virtual y realizar migraciones
                    sh """
                    source ${VENV_DIR}/bin/activate
                    python manage.py makemigrations
                    python manage.py migrate
                    """
                }
            }
        }

        stage('Recopilación de Archivos Estáticos') {
            steps {
                script {
                    // Recopilar archivos estáticos
                    sh """
                    source ${VENV_DIR}/bin/activate
                    python manage.py collectstatic --noinput
                    """
                }
            }
        }

        stage('Ejecutar Pruebas') {
            steps {
                script {
                    // Activar el entorno virtual y ejecutar pruebas
                    sh """
                    source ${VENV_DIR}/bin/activate
                    python manage.py test
                    """
                }
            }
        }
    }

    post {
        success {
            echo '¡El pipeline se ejecutó con éxito!'
        }
        failure {
            echo 'El pipeline falló.'
        }
        always {
            // Limpiar el entorno virtual si es necesario
            sh "rm -rf ${VENV_DIR}"
        }
    }
}
