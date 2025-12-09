pipeline {
    agent any

    tools {
        // Use the Maven and JDK installations configured in Jenkins
        maven 'Maven3'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone your Git repository
                git branch: 'main', url: 'https://github.com/lpvd/gs-spring-boot.git'
            }
        }

        stage('Build') {
            steps {
                // If pom.xml is in a subfolder, specify path with -f
                sh 'mvn -f complete/pom.xml clean install'
            }
        }

        stage('Archive Artifact') {
            steps {
                // Archive the JAR produced by Maven
                archiveArtifacts artifacts: 'complete/target/*.jar', fingerprint: true
            }
        }
    }

    post {
        success {
            echo 'Build succeeded and artifact archived!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
