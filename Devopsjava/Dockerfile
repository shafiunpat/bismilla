#  FROM openjdk:17
#  ARG JAR_FILE=demo/target/shafiun.jar
#  COPY ${JAR_FILE} shafiun1.jar
#  ENTRYPOINT ["java","-jar","/shafiun.jar"]
#  EXPOSE 8080

# FROM openjdk:11-jdk AS build
# ARG JAR_FILE=demo/target/shafiun.jar
# COPY ${JAR_FILE} shafiun1.jar
# FROM openjdk:11-jre AS run
# COPY --from=build ${JAR_FILE} shafiun2.jar.
# EXPOSE 8080
# ENTRYPOINT ["java","-jar","/shafiun2.jar"]

# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file to the container
COPY shafiun1.jar /app/shafiun1.jar

# Expose port 8080 (or whatever port your application uses)
EXPOSE 8080

# Run the JAR file
CMD ["java", "-jar", "/app/shafiun1.jar"]


