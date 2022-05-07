pipeline { 
     agent any
      tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "Maven"
    }
    stages{
       stage('GetCode'){
            steps{
                git 'https://github.com/eyaboubaker/Pipline.git'
            }
         }        
       stage ('Compile Stage') {

            steps {
                withMaven(maven : 'Maven') {
                    sh 'mvn clean compile'
                }
            }
        }
         stage ('Testing Stage') {

            steps {
                withMaven(maven : 'Maven') {
                    sh 'mvn test'
                }
            }
        }
        stage('Build'){
            steps{
                sh 'mvn clean package'
            }
         }
        stage('Execute Sonarqube Report')
     {
            steps
         {
              withSonarQubeEnv('Sonarqube-Server') 
             {
                sh "mvn sonar:sonar"
             }  
         }
         stage('Quality Gate Check')
     {
         steps
         {
             timeout(time: 1, unit: 'HOURS') 
             {
                waitForQualityGate abortPipeline: true, credentialsId: 'jenkins-sonar'
            }
         }
     }
stage('Nexus Upload')
     {
         steps
         {
             script
             {
                 def readPom = readMavenPom file: 'pom.xml'
                 def nexusrepo = readPom.version.endsWith("SNAPSHOT") ? "wallmart-snapshot" : "wallmart-release"
                 nexusArtifactUploader artifacts: 
                 [
                     [
                         artifactId: "${readPom.artifactId}",
                         classifier: '', 
                         file: "target/${readPom.artifactId}-${readPom.version}.war", 
                         type: 'war'
                     ]
                ], 
                         credentialsId: 'jenkins-nexus', 
                         groupId: "${readPom.groupId}", 
                         nexusUrl: '192.168.0.9:8081', 
