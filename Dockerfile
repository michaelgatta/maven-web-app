FROM tomcat:8.0.20-jre8

# Dummy text to test 
WORKDIR /usr/local/tomcat/webapps
COPY target/maven-web-app*.war /usr/local/tomcat/webapps/maven-web-app.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
