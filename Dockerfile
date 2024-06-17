# Use an official OpenJDK image with Java 17
FROM openjdk:17-slim

# Set environment variables
ENV GRADLE_VERSION=7.6
ENV GRADLE_HOME=/opt/gradle

# Install necessary tools: curl and unzip
RUN apt-get update && apt-get install -y curl unzip && apt-get clean

# Download and install Gradle
RUN curl -sLO https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip -d /opt/gradle gradle-${GRADLE_VERSION}-bin.zip && \
    ln -s ${GRADLE_HOME}/gradle-${GRADLE_VERSION} ${GRADLE_HOME}/gradle && \
    rm gradle-${GRADLE_VERSION}-bin.zip

# Set Gradle path
ENV PATH="${GRADLE_HOME}/gradle/bin:${PATH}"

# Confirm installation
RUN gradle --version

# Set the working directory inside the container
WORKDIR /app

# Copy the local project files to the container's working directory
COPY . .

# Run Gradle build to download dependencies (this layer will be cached unless dependencies change)
RUN gradle build --no-daemon -x test

# Expose the port the application runs on
EXPOSE 8080

# Command to run the application
CMD ["gradle", "bootRun"]