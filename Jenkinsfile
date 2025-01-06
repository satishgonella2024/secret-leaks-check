pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                echo "Checking out code from repository"
                git branch: 'main', url: 'git@github.com:satishgonella2024/secret-leaks-check.git'
            }
        }

        stage('Run GitLeaks') {
            steps {
                echo "Running GitLeaks to detect sensitive information"
                sh """
                gitleaks detect --source . --exit-code 1 --report-path gitleaks-report.json
                """
            }
        }
    }

    post {
        success {
            echo "No sensitive information detected. Build successful!"
        }
        failure {
            echo "Sensitive information detected! Check gitleaks-report.json for details."
            archiveArtifacts artifacts: 'gitleaks-report.json', allowEmptyArchive: false
        }
    }
}