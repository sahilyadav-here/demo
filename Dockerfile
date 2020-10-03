FROM openjdk:8-jre-alpine
WORKDIR /demo
COPY /test-demo/target/code-coverage-maven-jacoco.jar /app 
CMD ["java -jar code-coverage-maven-jacoco.jar"] 
