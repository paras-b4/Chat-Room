#FROM ubuntu:latest
#LABEL authors="PARAS YADAV"
#
#ENTRYPOINT ["top", "-b"]

#FROM openjdk:22 as build
#COPY . .
#RUN mvn clean package -DskipTests
#
#FROM openjdk:22
#COPY --from=build /target/ChatRoom-0.0.1-SNAPSHOT.jar demo.jar
#EXPOSE 8080
#ENTRYPOINT ["java","-jar","ChatRoom-0.0.1-SNAPSHOT.jar"]
# Use a Maven image for the build stage
FROM maven:3.8.8-openjdk-22 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Use a lightweight Java runtime for the final stage
FROM openjdk:22-jdk-slim
WORKDIR /app
COPY --from=build /app/target/ChatRoom-0.0.1-SNAPSHOT.jar demo.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "demo.jar"]

