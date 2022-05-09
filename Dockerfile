FROM tomcat:8.0.20-jre8
COPY target/Pipeline*.war /usr/local/tomcat/wabapps/Pipeline.war
