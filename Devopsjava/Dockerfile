FROM openjdk:8
ARG JAR_FILE=target/demo-0.0.1-SNAPSHOT.jar
copy ${JAR_FILE} demoJava.jar
ENTRYPOINT ["java","-jar","/demoJava.jar"]
EXPOSE 8080