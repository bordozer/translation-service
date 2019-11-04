FROM java:8
ADD build/libs/translation-service-docker-1.1.jar rest-api.jar
RUN bash -c 'touch /pegasus.jar'
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom","-Dspring.profiles.active=local","-jar","/rest-api.jar"]