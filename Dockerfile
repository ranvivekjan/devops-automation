FROM openjdk:8
EXPOSE 8080
ADD target/devops-integration.jar dev-inte.jar
ENTRYPOINT ["java","-jar","/dev-inte.jar"]
