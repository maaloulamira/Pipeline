pipeline { 
     agent any
      tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "Maven"
    }
    stages{
       stage('GetCode'){
            steps{
                git 'https://github.com/soueiwaddah/PiplineTest.git'
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
        stage('SonarQube analysis') {
     //   def scannerHome = tool 'SonarScanner 4.0';
        steps{
        withSonarQubeEnv('sonarserver') { 
        // If you have configured more than one global server connection, you can specify its name
//      sh "${scannerHome}/bin/sonar-scanner"
        sh "mvn sonar:sonar"
    }
        }
        }       
    }
}
