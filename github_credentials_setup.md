# Setting up GitHub Credentials

This guide will walk you through setting up the necessary credentials for GitHub Actions workflows.

## AWS Credentials

1. **Generate AWS Access Keys** (if you don't already have them):
   - Log in to the [AWS Management Console](https://console.aws.amazon.com/)
   - Navigate to IAM > Users > Your User > Security credentials
   - Click "Create access key"
   - Download or note the Access Key ID and Secret Access Key

2. **Add AWS Credentials to GitHub Secrets**:
   - Go to your GitHub repository
   - Click on "Settings" > "Secrets and variables" > "Actions"
   - Click "New repository secret"
   - Add the following secrets:
     - Name: `AWS_ACCESS_KEY_ID`
     - Value: Your AWS Access Key ID
   - Click "Add secret"
   - Repeat for the Secret Access Key:
     - Name: `AWS_SECRET_ACCESS_KEY`
     - Value: Your AWS Secret Access Key

## Docker Hub Credentials

1. **Create a Docker Hub Access Token** (if you don't already have one):
   - Log in to [Docker Hub](https://hub.docker.com/)
   - Click on your username > "Account Settings" > "Security"
   - Click "New Access Token"
   - Give it a name like "GitHub Actions"
   - Copy the generated token

2. **Add Docker Hub Credentials to GitHub Secrets**:
   - Go to your GitHub repository
   - Click on "Settings" > "Secrets and variables" > "Actions"
   - Click "New repository secret"
   - Add the following secrets:
     - Name: `DOCKERHUB_USER`
     - Value: Your Docker Hub username
   - Click "Add secret"
   - Add another secret:
     - Name: `DOCKERHUB_TOKEN`
     - Value: Your Docker Hub access token

## Additional Required Secrets

Your workflows also reference the following secrets that need to be added:

1. **Django Secret Key**:
   - Generate a secure random string for your Django application
   - Add it as a secret named `DJANGO_SECRET_KEY`

2. **Database Password**:
   - Create a secure password for your database
   - Add it as a secret named `TF_VAR_DB_PASSWORD`

## Verifying Credentials

After adding all required secrets, navigate to the "Actions" tab in your GitHub repository and run a workflow manually to verify that the credentials are working correctly.
