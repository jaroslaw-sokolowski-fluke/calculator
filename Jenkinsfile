pipeline {
    agent {
        docker {
            image 'calculator-app'
            reuseNode true
        }
    }
    stages {
        stage("Compile") {
            steps {
                echo "JAVA VERSION:"
                sh "java -version"
                echo "ATTEMPT COMPILE:"
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
                publishHTML (target: [
                    reportDir: 'build/reports/jacoco/test/html',
                    reportFiles: 'index.html',
                    reportName: "JaCoCo Report"
                ])
                sh "./gradlew jacocoTestCoverageVerification"
            }
        }
    }
}