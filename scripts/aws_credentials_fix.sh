#!/bin/bash

# AWS Credentials Fix Script
# This script helps identify and fix issues with AWS credentials for GitHub Actions

echo "AWS Credentials Troubleshooting Script"
echo "====================================="
echo

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI is not installed. Please install it first."
    exit 1
fi

# Verify AWS credentials are working locally
echo "Step 1: Verifying your AWS credentials locally..."
if aws sts get-caller-identity &> /dev/null; then
    echo "✅ Local AWS credentials are working correctly."
    caller_identity=$(aws sts get-caller-identity)
    echo "Account: $(echo $caller_identity | jq -r '.Account')"
    echo "User ID: $(echo $caller_identity | jq -r '.UserId')"
    echo "ARN: $(echo $caller_identity | jq -r '.Arn')"
    echo
else
    echo "❌ Your local AWS credentials are not working. Please run 'aws configure' to set them up correctly."
    exit 1
fi

# Check for temporary credentials
echo "Step 2: Checking if you're using temporary credentials..."
token=$(aws configure get aws_session_token 2>/dev/null)
if [ -n "$token" ]; then
    echo "⚠️  You are using temporary credentials with a session token."
    echo "GitHub Actions requires permanent credentials (access key and secret key only)."
    echo
    echo "Options to fix this:"
    echo "1. Create a new IAM user with permanent credentials"
    echo "2. Create long-term IAM user access keys"
    echo
    echo "Would you like to create permanent credentials now? (y/n)"
    read create_permanent
    
    if [[ $create_permanent == "y" || $create_permanent == "Y" ]]; then
        echo "Creating IAM user credentials..."
        echo "Please follow AWS best practices and create a user with minimal permissions needed for your workflow."
        # This would normally open AWS console or provide steps
    fi
    exit 1
fi

# Get current AWS credentials
access_key=$(aws configure get aws_access_key_id)
secret_key=$(aws configure get aws_secret_access_key)

# Check key format
echo "Step 3: Checking AWS credential format..."
if [[ ! $access_key =~ ^[A-Z0-9]{20}$ ]]; then
    echo "⚠️  Your AWS access key ID does not match the expected format."
    echo "Access keys should be 20 characters, uppercase letters and numbers."
    echo
else
    echo "✅ AWS access key format looks correct."
fi

if [[ ${#secret_key} -lt 40 ]]; then
    echo "⚠️  Your AWS secret key appears to be too short."
    echo "Secret keys should be at least 40 characters."
    echo
else
    echo "✅ AWS secret key length looks correct."
fi

echo
echo "Step 4: Updating GitHub secrets with 'clean' credentials..."

# Function to add a secret
add_secret() {
    local secret_name=$1
    local secret_value=$2
    
    echo "Adding secret: $secret_name"
    echo "$secret_value" | gh secret set "$secret_name" -R "JiawenZhu/devops-recipe-app-api"
    
    if [ $? -eq 0 ]; then
        echo "✅ $secret_name added successfully"
    else
        echo "❌ Failed to add $secret_name"
    fi
    echo
}

# Update AWS credentials in GitHub
add_secret "AWS_ACCESS_KEY_ID" "$access_key"
add_secret "AWS_SECRET_ACCESS_KEY" "$secret_key"

echo "Step 5: Testing AWS credentials in GitHub Actions..."
echo "Would you like to test the credentials by running the workflow again? (y/n)"
read run_workflow

if [[ $run_workflow == "y" || $run_workflow == "Y" ]]; then
    echo "Triggering workflow..."
    gh workflow run "Deploy Recipe App API" -R JiawenZhu/devops-recipe-app-api
    
    echo "Waiting for workflow to start..."
    sleep 10
    
    echo "Checking workflow status..."
    gh run list --workflow=deploy.yml -R JiawenZhu/devops-recipe-app-api --limit 1
fi

echo
echo "Additional Troubleshooting Tips:"
echo "1. Make sure your AWS credentials have the necessary permissions"
echo "2. Verify that your AWS credentials are active and not expired"
echo "3. If you're still having issues, try creating new AWS access keys"
echo "4. Check if your account requires an MFA token for API access"
