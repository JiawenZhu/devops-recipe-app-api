# GitHub Credentials Fix

This guide will help you resolve the issues with GitHub credentials for AWS and Docker Hub authentication.

## Overview

Your GitHub Actions workflows require the following credentials to be properly configured:

1. **AWS credentials** (`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`) - Used for AWS services like ECR and ECS
2. **Docker Hub credentials** (`DOCKERHUB_USER` and `DOCKERHUB_TOKEN`) - Used for Docker image builds
3. **Additional secrets** (`DJANGO_SECRET_KEY` and `TF_VAR_DB_PASSWORD`) - Used for your application

## Quick Fix Instructions

1. **Read the detailed guide**:
   ```
   cat github_credentials_setup.md
   ```
   This will give you a comprehensive overview of all credentials needed.

2. **Set up AWS credentials**:
   ```
   ./scripts/aws_credentials_helper.sh
   ```
   This script will help you retrieve existing AWS credentials or guide you to create new ones.

3. **Set up Docker Hub credentials**:
   ```
   ./scripts/docker_credentials_helper.sh
   ```
   This script will help you create a Docker Hub access token for GitHub Actions.

4. **Generate a Django secret key**:
   ```
   ./scripts/generate_django_secret.sh
   ```
   This will generate a secure random string for your Django application.

5. **Add all credentials to GitHub**:
   - Go to your GitHub repository
   - Navigate to Settings > Secrets and variables > Actions
   - Add all the secrets as described in the detailed guide

## Verifying the Fix

After adding all required secrets, navigate to the "Actions" tab in your GitHub repository and run a workflow manually to verify that the credentials are working correctly.

## Troubleshooting

If you encounter any issues after setting up the credentials:

1. Check that all required secrets are added with the exact names specified
2. Ensure that the AWS credentials have sufficient permissions
3. Verify that your Docker Hub token has appropriate read/write access
