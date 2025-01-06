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
    }

    post {
        always {
            echo "Archiving GitLeaks report"
            archiveArtifacts artifacts: 'gitleaks-report.json', allowEmptyArchive: false
        }
        success {
            echo "No sensitive information detected. Build successful!"
        }
        failure {
            echo "Sensitive information detected! Check gitleaks-report.json for details."
        }
    }
}