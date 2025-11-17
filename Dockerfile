FROM openjdk:17-jdk-slim
WORKDIR /app
COPY . .
RUN apt-get update && apt-get install -y maven git curl unzip && \
    mvn clean package -Dmaven.test.skip=true
CMD ["java", "-jar", "target/spring-petclinic-*.jar"]
