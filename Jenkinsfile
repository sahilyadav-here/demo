pipeline { 
    agent any  
    stages {
         stage('Compile') { 
            steps { 
               sh 'mvn compile'
            }
         }
        stage("SonarQube analysis") {
            steps {
              withSonarQubeEnv('project-1') {
                  sh 'mvn clean package sonar:sonar'
              }
            }
          }
        stage('build') { 
            steps { 
               sh 'mvn install'
            }
        }
    }
}
