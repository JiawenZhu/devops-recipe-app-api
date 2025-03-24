#!/bin/bash

# AWS Credentials Helper Script
# This script helps retrieve existing AWS credentials or guides on creating new ones

echo "AWS Credentials Helper"
echo "======================"
echo

# Check if AWS CLI is installed
if command -v aws &> /dev/null; then
    echo "AWS CLI is installed. Checking for existing credentials..."
    
    # Check if AWS credentials are configured
    if aws configure list &> /dev/null; then
        echo "Found existing AWS configuration:"
        echo
        
        # Get the current profile
        profile=$(aws configure get aws_access_key_id)
        if [ -n "$profile" ]; then
            echo "Your current AWS Access Key ID is: $(aws configure get aws_access_key_id | sed 's/.\{24\}$/****/')"
            echo
            
            read -p "Would you like to use this AWS Access Key ID for GitHub Actions? (y/n): " use_existing
            
            if [[ $use_existing == "y" || $use_existing == "Y" ]]; then
                echo
                echo "Please use these credentials for your GitHub repository secrets:"
                echo "AWS_ACCESS_KEY_ID: $(aws configure get aws_access_key_id)"
                echo "AWS_SECRET_ACCESS_KEY: $(aws configure get aws_secret_access_key)"
                echo
                echo "Follow the instructions in github_credentials_setup.md to add these to your GitHub repository."
                exit 0
            fi
        fi
    fi
fi

# If we get here, either AWS CLI is not installed, no credentials were found, or user chose not to use existing credentials
echo
echo "To create new AWS credentials:"
echo "1. Log in to the AWS Management Console: https://console.aws.amazon.com/"
echo "2. Navigate to IAM > Users > Your User > Security credentials"
echo "3. Click 'Create access key'"
echo "4. Download or note the Access Key ID and Secret Access Key"
echo
echo "Once you have your credentials, follow the instructions in github_credentials_setup.md to add them to your GitHub repository."
