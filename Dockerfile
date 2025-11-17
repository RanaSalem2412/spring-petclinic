FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY . .
RUN apk update && apk add --no-cache maven git curl unzip bash && \
    mvn clean package -Dmaven.test.skip=true
CMD ["sh", "-c", "java -jar target/spring-petclinic-*.jar"]
