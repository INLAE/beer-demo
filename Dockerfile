# Базовый образ с OpenJDK 17
FROM openjdk:17-jdk-slim

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app

# Копируем собранный JAR-файл в контейнер
COPY target/beer-demo-0.0.1-SNAPSHOT.jar app.jar

# Команда для запуска приложения
ENTRYPOINT ["java", "-jar", "app.jar"]