FROM jenkins/jenkins:lts-jdk17

# Устанавливаем Docker CLI для сборки образов внутри Jenkins
USER root
RUN apt-get update && apt-get install -y docker.io

# Добавляем пользователя jenkins в существующую группу docker
RUN usermod -aG docker jenkins || true

# Возвращаем пользователя Jenkins
USER jenkins

# Дополнительные шаги для запуска приложения
WORKDIR /app

# В финальном билде копируем JAR-файл приложения (путь зависит от Maven сборки)
COPY target/beer-demo-0.0.1-SNAPSHOT.jar /app/beer-demo.jar

# Устанавливаем команду запуска JAR-файла
ENTRYPOINT ["java", "-jar", "/app/beer-demo.jar"]
