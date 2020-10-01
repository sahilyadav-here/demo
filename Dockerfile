FROM maven:3.5-jdk-8-alpine
WORKDIR /demo
COPY /demo /demo
RUN mvn install