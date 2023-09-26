# Use a base image that includes a servlet container (Tomcat in this case)
FROM tomcat:9.0-jre11-slim

# Remove the default ROOT web application (optional)
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your WAR file into Tomcat's webapps directory
COPY maven-web-app.war /usr/local/tomcat/webapps/ROOT.war

# Expose the HTTP port (default is 8080)
EXPOSE 8080

# Start Tomcat when the container runs
CMD ["catalina.sh", "run"]

