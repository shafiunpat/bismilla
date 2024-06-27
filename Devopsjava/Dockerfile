 FROM openjdk:17
 ARG JAR_FILE=demo/target/shafiun.jar
 COPY ${JAR_FILE} shafiun1.jar
 ENTRYPOINT ["java","-jar","/shafiun.jar"]
 EXPOSE 8080

# FROM openjdk:11-jdk AS build
# ARG JAR_FILE=demo/target/shafiun.jar
# COPY ${JAR_FILE} shafiun1.jar
# FROM openjdk:11-jre AS run
# COPY --from=build ${JAR_FILE} shafiun2.jar.
# EXPOSE 8080
# ENTRYPOINT ["java","-jar","/shafiun2.jar"]