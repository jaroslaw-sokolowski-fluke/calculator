pipeline {
    agent any
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
    }
}