FROM openjdk:8u171-jdk
MAINTAINER Borys Lukianov <bordozer@gmail.com>

ADD build/libs/translation-service-1.1.jar rest-api.jar
COPY src/main/resources/logback.xml /logback.xml

RUN bash -c 'touch /pegasus.jar'
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom","-Dspring.profiles.active=local","-jar","/rest-api.jar"]
