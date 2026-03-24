pipeline {
    agent any

    environment {
        // Replace with your Docker Hub username if you plan to push later
        DOCKER_IMAGE = "asbeelagi05/my-python-app"
    }

    stages {
        stage('Checkout') {
            steps {
                // This pulls the latest code from your GitHub repo
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building the Docker image..."
                    sh "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."
                    sh "docker tag ${DOCKER_IMAGE}:${BUILD_NUMBER} ${DOCKER_IMAGE}:latest"
                }
            }
        }

        stage('Run Container/Tests') {
            steps {
                script {
                    echo "Running the container to verify it starts..."
                    // This runs the container, checks if it's up, then stops it
                    sh "docker run -d --name test-container ${DOCKER_IMAGE}:latest"
                    sh "docker ps"
                    sh "docker stop test-container"
                    sh "docker rm test-container"
                }
            }
        }
    }

    post {
        always {
            echo "Cleaning up workspace..."
            cleanWs()
        }
        success {
            echo "Build and test completed successfully!"
        }
        failure {
            echo "Something went wrong. Check the console logs."
        }
    }
}
