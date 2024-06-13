pipeline {
    agent {
        dockerfile {
            filename 'jenkins_files/Dockerfile-tamino-translations'
            args '--network tamino-ci_default --memory=2g'
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
    }
}