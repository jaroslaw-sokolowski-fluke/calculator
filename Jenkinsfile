pipeline {
    agent none
    stages {
        stage("Compile") {
            agent {
                dockerfile {
                    filename 'Dockerfile-calculator'
                    reuseNode true
                }
            }
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
    }
}