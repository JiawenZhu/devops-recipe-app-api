#!/bin/bash

# Script to install GitHub CLI and add secrets to your repository

echo "GitHub Credentials Setup Script"
echo "=============================="
echo

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew installed successfully."
    echo
else
    echo "Homebrew is already installed."
    echo
fi

# Install GitHub CLI
echo "Installing GitHub CLI..."
brew install gh
echo

# Check if GitHub CLI was installed successfully
if ! command -v gh &> /dev/null; then
    echo "Failed to install GitHub CLI. Please install it manually and run this script again."
    exit 1
fi

# Check if already authenticated with GitHub
if ! gh auth status &> /dev/null; then
    echo "Please authenticate with GitHub:"
    gh auth login
    echo
fi

# Check authentication again
if ! gh auth status &> /dev/null; then
    echo "GitHub authentication failed. Please try again manually."
    exit 1
fi

# Get AWS credentials from AWS CLI configuration
AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)

# Set the repository name
REPO="JiawenZhu/devops-recipe-app-api"

echo "Adding secrets to GitHub repository: $REPO"
echo

# Function to add a secret
add_secret() {
    local secret_name=$1
    local secret_value=$2
    
    echo "Adding secret: $secret_name"
    echo "$secret_value" | gh secret set "$secret_name" -R "$REPO"
    
    if [ $? -eq 0 ]; then
        echo "✅ $secret_name added successfully"
    else
        echo "❌ Failed to add $secret_name"
    fi
    echo
}

# Add AWS credentials
add_secret "AWS_ACCESS_KEY_ID" "$AWS_ACCESS_KEY_ID"
add_secret "AWS_SECRET_ACCESS_KEY" "$AWS_SECRET_ACCESS_KEY"

# Add Docker Hub credentials
echo "Please enter your Docker Hub token:"
read -s DOCKERHUB_TOKEN
echo
add_secret "DOCKERHUB_USER" "jiawendocker"
add_secret "DOCKERHUB_TOKEN" "$DOCKERHUB_TOKEN"

# Add Django secret key
add_secret "DJANGO_SECRET_KEY" "IlJpZOnIJWfgUxwqlZdKGjyELvJJ3jxlK00vDWoWvv1Ntye3A4McHSF8QTHPgQurAk8"

# Add database password
add_secret "TF_VAR_DB_PASSWORD" "hecBLuyHd5p/smXkXEa22A=="

echo "Secret setup complete!"
echo "To verify, run: gh secret list -R $REPO"
