FROM java:8-jdk-alpine
MAINTAINER TARUN
COPY ./target/my-test-app-0.0.1-SNAPSHOT.jar /usr/app/
WORKDIR /usr/app
RUN sh -c 'touch my-test-app-0.0.1-SNAPSHOT.jar'
ENTRYPOINT ["java", "-jar", "my-test-app-0.0.1-SNAPSHOT.jar"]
