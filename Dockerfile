# Use an official OpenJDK runtime as a parent image
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file and any necessary resources into the container
COPY target/maven-web-app.* /app/maven-web-app.*


# Specify the command to run your application
CMD ["java", "-jar", "my-java-app.jar"]

