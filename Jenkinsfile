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
                script {
                    def result = sh(
                        script: """
                        gitleaks detect --source . --no-git --config .gitleaks.toml --exit-code 1 --report-path gitleaks-report.json --verbose
                        """,
                        returnStatus: true // Capture the exit code
                    )
                    if (result != 0) {
                        echo "Sensitive information detected! Marking build as UNSTABLE."
                        currentBuild.result = 'UNSTABLE'
                    }
                }
            }
        }

        stage('Run Checkov') {
            steps {
                echo "Running Checkov to scan IaC for misconfigurations"
                script {
                    sh """
                     /home/satish/.local/bin/checkov -f main.tf --output json > checkov-report.json
                    """
                }
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
        unstable {
            echo "Build marked as UNSTABLE due to GitLeaks findings!"
        }
        failure {
            echo "Issues detected! Check the reports for details."
        }
    }
}