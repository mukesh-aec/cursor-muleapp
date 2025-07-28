#!/bin/bash

# Salesforce Account Manager - Deployment Script

echo "=== Salesforce Account Manager Deployment ==="

# Check if Maven is installed
if ! command -v mvn &> /dev/null; then
    echo "Error: Maven is not installed. Please install Maven first."
    exit 1
fi

# Check if config.properties exists
if [ ! -f "src/main/resources/config.properties" ]; then
    echo "Error: config.properties file not found. Please create it first."
    exit 1
fi

echo "Building the application..."
mvn clean package

if [ $? -eq 0 ]; then
    echo "Build successful!"
    echo "Application JAR file created in target/salesforce-account-manager-1.0.0-SNAPSHOT-mule-application.jar"
    echo ""
    echo "To deploy to Mule Runtime:"
    echo "1. Copy the JAR file to your Mule Runtime apps directory"
    echo "2. Or use: mvn mule:deploy (if Mule Runtime is configured)"
    echo ""
    echo "To run locally:"
    echo "java -jar target/salesforce-account-manager-1.0.0-SNAPSHOT-mule-application.jar"
else
    echo "Build failed! Please check the error messages above."
    exit 1
fi