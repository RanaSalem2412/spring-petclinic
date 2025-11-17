# =========================
# Stage 1: Build the project
# =========================
FROM maven:3.9.0-eclipse-temurin-17 AS build

# تحديد الـ working directory
WORKDIR /app

# نسخ ملفات المشروع الأساسية
COPY pom.xml .
COPY src ./src

# بناء المشروع بدون اختبار لتوفير الوقت والمساحة
RUN mvn clean package -DskipTests

# =========================
# Stage 2: Create final image
# =========================
FROM eclipse-temurin:17-jdk-alpine

# working directory
WORKDIR /app

# نسخ الـ JAR النهائي فقط من الـ build stage
COPY --from=build /app/target/spring-petclinic-*.jar ./app.jar

# إزالة أي cache متبقي لتقليل حجم الـ image
RUN rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

# تحديد الأمر الافتراضي لتشغيل التطبيق
CMD ["java", "-jar", "app.jar"]
