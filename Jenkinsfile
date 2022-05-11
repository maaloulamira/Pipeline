pipeline { 
     agent any
      tools {
        maven "Maven 3.8.5"
        groovy "groovy-3.0.8"
        jdk "Java 8"
    }
    stages{
       stage('GetCode'){
            steps {
                git "https://github.com/eyaboubaker/Pipeline.git "
               
            }
         }        
       stage ('Compile Stage') {

            steps {
                withMaven(maven : 'Maven 3.8.5') {
                    sh 'mvn clean compile'
                }
            }
        }
         stage ('Testing Stage') {

            steps {
                withMaven(maven : 'Maven 3.8.5') {
                    sh 'mvn test'
                }
            }
        }
        stage('Build'){
            steps{
                sh 'mvn clean package'
            }
         }
         stage ('Sonarqube analysis'){
              steps {
                   withSonarQubeEnv('sonar') {
                        sh "mvn sonar:sonar"
                   }
              }
         stage('Quality Gate Check')
     {
         steps
         {
            
                waitForQualityGate abortPipeline: true, credentialsId: 'jenkins-sonar'
            
         }
     }
stage('Nexus Upload')
     {
         steps
         {
            
                 nexusArtifactUploader artifacts: 
                 [
                     [
                         artifactId: "Pipeline",
                         classifier: '', 
                         file: "target/Pipeline-8.20.0.war", 
                         type: 'war'
                     ]
                ], 
                         credentialsId: 'jenkins-nexus', 
                         groupId: 'in.javahome', 
                         nexusUrl: '192.168.0.9:8081', 
                         nexusVersion: 'nexus3',
                         protocol: 'http' ,
                         repository: 'NexusRepository' ,
                         version: '8.2.0'
              
                      }
         }
     }
    }
}
}


