FROM openjdk:17

COPY app/target/app-1.0-SNAPSHOT.jar /appdir/javaapp.jar
WORKDIR /appdir

CMD ["java", "-jar", "javaapp.jar"]
