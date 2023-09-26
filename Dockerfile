# Use a base image with Java and Maven installed
FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project files (pom.xml) to the container
COPY pom.xml .

# Copy the source code and resources to the container
COPY src ./src

# Build the application with Maven (skip tests if desired)
RUN mvn clean install -DskipTests

# Use a Tomcat base image for the runtime environment
FROM tomcat:9.0-jre11-slim

# Copy the built WAR file from the previous stage to Tomcat's webapps directory
COPY --from=build /app/target/my-web-app.war /usr/local/tomcat/webapps/

# Expose the default Tomcat port (8080)
EXPOSE 8080

# Start Tomcat when the container runs
CMD ["catalina.sh", "run"]

