FROM openjdk:17
ARG JAR_FILE=demo/target/shafiun.jar
copy ${JAR_FILE} shafiun1.jar
ENTRYPOINT ["java","-jar","/shafiun.jar"]
EXPOSE 8080
