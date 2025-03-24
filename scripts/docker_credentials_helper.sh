#!/bin/bash

# Docker Hub Credentials Helper Script
# This script helps generate Docker Hub access tokens for GitHub Actions

echo "Docker Hub Credentials Helper"
echo "==========================="
echo

# Check if Docker is installed
if command -v docker &> /dev/null; then
    echo "Docker is installed. Let's check if you're logged in..."
    
    # Check if logged in to Docker Hub
    if docker info 2>/dev/null | grep -q "Username"; then
        username=$(docker info 2>/dev/null | grep "Username" | cut -d: -f2 | tr -d ' ')
        echo "You're currently logged in to Docker Hub as: $username"
        echo
        echo "For GitHub Actions, you'll need to create an access token rather than using your password."
        echo
    else
        echo "You're not currently logged in to Docker Hub."
        echo
        read -p "Do you have a Docker Hub account? (y/n): " has_account
        
        if [[ $has_account == "y" || $has_account == "Y" ]]; then
            echo
            read -p "Please enter your Docker Hub username: " username
            echo
            echo "For GitHub Actions, you'll need to create an access token rather than using your password."
            echo
        else
            echo
            echo "You'll need to create a Docker Hub account first:"
            echo "1. Go to https://hub.docker.com/signup"
            echo "2. Follow the registration process"
            echo
            echo "After creating your account, return to this script."
            echo
            read -p "Press Enter to continue once you have created an account..."
            echo
            read -p "Please enter your new Docker Hub username: " username
            echo
        fi
    fi
fi

echo "To create a Docker Hub access token:"
echo "1. Log in to Docker Hub: https://hub.docker.com/"
echo "2. Click on your username > 'Account Settings' > 'Security'"
echo "3. Click 'New Access Token'"
echo "4. Name it 'GitHub Actions' and set appropriate permissions (Read & Write access is typically needed)"
echo "5. Copy the generated token (you won't be able to see it again)"
echo
echo "Once you have your access token, add these credentials to your GitHub repository secrets:"
echo "DOCKERHUB_USER: $username"
echo "DOCKERHUB_TOKEN: [your-access-token]"
echo
echo "Follow the instructions in github_credentials_setup.md to add these to your GitHub repository."
