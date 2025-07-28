# Salesforce Account Manager - MuleSoft Application

This MuleSoft application provides a REST API to create and update accounts in Salesforce. The application includes validation, error handling, and duplicate checking functionality.

## Features

- **HTTP Listener**: Receives account data via REST API
- **Salesforce Integration**: Creates and updates accounts in Salesforce
- **Duplicate Detection**: Checks if account already exists before creating
- **Validation**: Validates required fields
- **Error Handling**: Comprehensive error handling with proper business error responses
- **Update Logic**: Updates existing accounts instead of creating duplicates

## Prerequisites

- Mule Runtime 4.4.0 or higher
- Anypoint Studio 7.x or higher
- Salesforce account with API access
- Maven 3.6 or higher

## Setup Instructions

### 1. Configure Salesforce Connection

Edit `src/main/resources/config.properties` and update the Salesforce credentials:

```properties
salesforce.username=your_salesforce_username
salesforce.password=your_salesforce_password
salesforce.securityToken=your_salesforce_security_token
```

### 2. Salesforce Custom Fields

Ensure your Salesforce Account object has the following custom fields:
- `Email__c` (Text field)
- `Contact_No__c` (Text field)

### 3. Build and Deploy

```bash
# Build the application
mvn clean package

# Deploy to Mule Runtime
mvn mule:deploy
```

## API Documentation

### Endpoint
- **URL**: `http://localhost:8081/api/accounts`
- **Method**: POST
- **Content-Type**: application/json

### Request Body
```json
{
    "name": "Account Name",
    "email": "account@example.com",
    "contactNo": "+1234567890"
}
```

### Response Examples

#### Success - Account Created
```json
{
    "success": true,
    "message": "Account created successfully",
    "accountId": "001XXXXXXXXXXXXXXX",
    "operation": "CREATE"
}
```

#### Success - Account Updated
```json
{
    "success": true,
    "message": "Account updated successfully",
    "accountId": "001XXXXXXXXXXXXXXX",
    "operation": "UPDATE"
}
```

#### Validation Error
```json
{
    "success": false,
    "error": "VALIDATION_ERROR",
    "message": "Account name is required"
}
```

#### Business Error
```json
{
    "success": false,
    "error": "BUSINESS_ERROR",
    "message": "An error occurred while processing the request",
    "details": "Error description"
}
```

## Application Flow

1. **HTTP Listener**: Receives POST request with account data
2. **Validation**: Checks if required fields are present
3. **Query Salesforce**: Searches for existing account by name
4. **Decision Logic**:
   - If account exists: Update the account
   - If account doesn't exist: Create new account
5. **Response**: Returns success/error response to client

## Error Handling

The application includes comprehensive error handling:

- **Validation Errors**: When required fields are missing
- **Salesforce Connection Errors**: When unable to connect to Salesforce
- **Business Logic Errors**: When operations fail in Salesforce
- **System Errors**: For unexpected errors

## Testing

### Using cURL

```bash
# Create a new account
curl -X POST http://localhost:8081/api/accounts \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test Account",
    "email": "test@example.com",
    "contactNo": "+1234567890"
  }'

# Update existing account
curl -X POST http://localhost:8081/api/accounts \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test Account",
    "email": "updated@example.com",
    "contactNo": "+0987654321"
  }'
```

### Using Postman

1. Set method to POST
2. Set URL to `http://localhost:8081/api/accounts`
3. Set Content-Type header to `application/json`
4. Add request body with account data

## Configuration

### HTTP Configuration
- **Port**: 8081 (configurable in config.properties)
- **Host**: 0.0.0.0 (accepts connections from any IP)

### Salesforce Configuration
- Uses basic authentication
- Supports custom fields: Email__c, Contact_No__c
- Queries accounts by Name field

## Troubleshooting

### Common Issues

1. **Salesforce Connection Failed**
   - Verify credentials in config.properties
   - Check network connectivity
   - Ensure Salesforce API access is enabled

2. **Custom Fields Not Found**
   - Create Email__c and Contact_No__c fields in Salesforce Account object
   - Ensure field permissions are set correctly

3. **Port Already in Use**
   - Change port in config.properties
   - Check if another application is using port 8081

### Logs

Check Mule application logs for detailed error information:
- Runtime logs: `logs/mule.log`
- Application logs: `logs/salesforce-account-manager.log`

## Security Considerations

- Store Salesforce credentials securely
- Use environment variables for sensitive data in production
- Implement proper authentication for the HTTP endpoint
- Consider using HTTPS in production

## Version History

- **v1.0.0**: Initial release with basic CRUD operations