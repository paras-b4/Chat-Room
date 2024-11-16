#FROM ubuntu:latest
#LABEL authors="PARAS YADAV"
#
#ENTRYPOINT ["top", "-b"]

FROM openjdk:22 as build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:22
COPY --from=build /target/ChatRoom-0.0.1-SNAPSHOT.jar demo.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","ChatRoom-0.0.1-SNAPSHOT.jar"]
