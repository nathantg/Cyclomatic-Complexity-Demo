pipeline {
    agent any
    
    options {
        skipDefaultCheckout(true)
    }
    
    environment {
        /* SonarQube Server URL */
        SONARQUBE_URL = 'http://192.168.8.29:9000' 
    }
    
    stages {
        stage('Checkout SCM') {
            when { anyOf {branch "feature-*"; branch "dev-*"} }
            steps {
               cleanWs()
               checkout scm            
            }
        }
        stage('Preparation') {
            steps {
                sh '''
                  mkdir -p .sonar
                  curl -sSLo .sonar/build-wrapper-linux-x86.zip ${SONARQUBE_URL}/static/cpp/build-wrapper-linux-x86.zip 
                  unzip -o .sonar/build-wrapper-linux-x86.zip -d .sonar/
                '''
            }
        }
        stage('Build') {
            steps {
                sh '.sonar/build-wrapper-linux-x86/build-wrapper-linux-x86-64 --out-dir bw-output gcc main.c'
            }
        }
        stage('Static Code Analysis') {
            steps {
                script {
                    def scannerHome = tool 'SonarScanner'; // Name of the SonarQube Scanner you created in "Global Tool Configuration" section
                    withSonarQubeEnv() {
                        sh "${scannerHome}/sonar-scanner-4.7.0.2747-linux/bin/sonar-scanner"
                    }
                }
            }
        }
    }
}
