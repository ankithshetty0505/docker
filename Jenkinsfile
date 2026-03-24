pipeline {
    agent any

    environment {
        // Defining variables for easy updates later
        IMAGE_NAME = "flask-docker-app"
        CONTAINER_NAME = "flask-web-service"
        APP_PORT = "8095"
    }

    stages {
        stage('Checkout') {
            steps {
                // This pulls your code from the source control (GitHub/GitLab)
                checkout scm
            }
        }

        stage('Code Validation') {
            steps {
                echo "Checking if all required files exist..."
                sh "test -f app.py"
                sh "test -f Dockerfile"
                sh "test -f requirements.txt"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building the Docker image: ${IMAGE_NAME}"
                // Executes the 'Dockerfile' you created
                sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Cleanup Old Container') {
            steps {
                script {
                    // Stop and remove the old container if it's already running to free up the port
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"
                }
            }
        }

        stage('Deploy Container') {
            steps {
                echo "Starting the Flask app on port ${APP_PORT}..."
                // Runs the container in detached mode (-d)
                sh "docker run -d --name ${CONTAINER_NAME} -p ${APP_PORT}:${APP_PORT} ${IMAGE_NAME}:latest"
            }
        }

        stage('Health Check') {
            steps {
                echo "Waiting for app to start..."
                sleep 5
                // Simple curl command to verify the app returns a 200 OK status
                sh "curl -f http://localhost:${APP_PORT}/ || exit 1"
            }
        }
    }

    post {
        success {
            echo "Deployment successful! Access your app at http://your-server-ip:${APP_PORT}"
        }
        failure {
            echo "Deployment failed. Check the Jenkins console logs for errors."
        }
    }
}
