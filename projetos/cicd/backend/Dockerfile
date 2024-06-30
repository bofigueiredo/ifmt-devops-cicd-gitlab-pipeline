FROM openjdk:17-jdk-alpine

COPY ./target/*.jar /app.jar

ENV TZ="America/Cuiaba"

RUN apk add tzdata 

RUN addgroup -S app && adduser -S app -G app

USER app:app

ENTRYPOINT [ "sh", "-c", "java -jar /app.jar" ]