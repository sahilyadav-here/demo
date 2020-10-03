pipeline {
    environment {
        registry = "sahilyadavhere/sapientdemo"
        registryCredential = 'dockerhub_id'
        dockerImage = ''
    }
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Clean Build'
                sh 'mvn clean compile'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing'
                sh 'mvn test'
            }
        }
        stage('Package') {
            steps {
                echo 'Packaging'
                sh 'mvn package -DskipTests'
            }
        }
        stage('JaCoCo') {
            steps {
                echo 'Code Coverage'
                jacoco()
            }
        }
         stage("SonarQube analysis") {
            steps {
              withSonarQubeEnv('project-1') {
                  sh 'mvn sonar:sonar'
              }
            }
          }
        stage('Deploy to Prod') {
            when {
                branch 'master'
            }
            steps {
                script {
                    dockerImage = docker.build registry + "prod." + ":$BUILD_NUMBER"
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy to Dev') {
            when {
                branch 'development'
            }
            steps {
                script {
                    dockerImage = docker.build registry + "dev." + ":$BUILD_NUMBER"
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Cleaning up') {
            when {
                anyOf{
                    branch 'master';
                    branch 'development'
                }
            }
            steps {
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        } 
    }
    
    post {
        always {
            echo 'JENKINS PIPELINE'
        }
        success {
            echo 'JENKINS PIPELINE SUCCESSFUL'
            archiveArtifacts artifacts: 'target/*.*', onlyIfSuccessful: true
        }
        failure {
            echo 'JENKINS PIPELINE FAILED'
        }
        unstable {
            echo 'JENKINS PIPELINE WAS MARKED AS UNSTABLE'
        }
        changed {
            echo 'JENKINS PIPELINE STATUS HAS CHANGED SINCE LAST EXECUTION'
        }
    }
}
