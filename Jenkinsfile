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
                echo "Running GitLeaks with custom rules"
                sh """
                gitleaks detect --source . --no-git --config .gitleaks.toml --exit-code 1 --report-path gitleaks-report.json --verbose
                """
            }
        }

        stage('Run Checkov') {
            steps {
                echo "Running Checkov to scan IaC for misconfigurations"
                sh """
                checkov -f main.tf --output json > checkov-report.json
                """
            }
        }
    }

    post {
        always {
            echo "Archiving GitLeaks and Checkov reports"
            archiveArtifacts artifacts: 'gitleaks-report.json', allowEmptyArchive: true
            archiveArtifacts artifacts: 'checkov-report.json', allowEmptyArchive: true
        }
        success {
            echo "No issues detected. Build successful!"
        }
        failure {
            echo "Issues detected! Check the reports for details."
        }
    }
}