pipeline {
    agent {
        docker {
            image 'calculator-app'
            reuseNode true
        }
    }
    triggers {
        pollSCM('* * * * *')
    }
    stages {
        stage("Compile") {
            steps {
                sh "./gradlew compileJava"
            }
        }
        stage("Unit test") {
            steps {
                sh "./gradlew test"
            }
        }
        stage("Code coverage") {
            steps {
                sh "./gradlew jacocoTestReport"
                sh "./gradlew jacocoTestCoverageVerification"
            }
        }
        stage("Static code analysis") {
            steps {
                catchError(buildResult: 'UNSTABLE', stageResult: 'UNSTABLE') {
                    sh "./gradlew checkstyleMain"
                }
            }
        }
    }
    post {
        always {
            // Code coverage report
            publishHTML(target: [
                reportDir: 'build/reports/jacoco/test/html',
                reportFiles: 'index.html',
                reportName: "JaCoCo Report"
            ])
            // Checkstyle report
            publishHTML(target: [
                reportDir: 'build/reports/checkstyle/',
                reportFiles: 'main.html',
                reportName: "Checkstyle Report"
            ])
        }
        failure {
            echo "Build failed. Check the published reports for details."
        }
    }
}