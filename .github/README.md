# GitHub Actions Deployment for Recipe App API

This directory contains GitHub Actions workflows for deploying the Recipe App API to AWS infrastructure.

## Workflow Overview

The `deploy.yml` workflow automates the deployment process with the following steps:

1. **Setup Infrastructure**: Initializes and applies the Terraform configuration in the `infra/setup` directory to create ECR repositories and other required resources.
2. **Build and Push Docker Images**: Builds the app and proxy Docker images and pushes them to ECR.
3. **Deploy Infrastructure**: Applies the Terraform configuration in the `infra/deploy` directory to deploy the application to ECS Fargate.
4. **Run Migrations and Collect Static Files**: Executes Django migrations and collects static files on the deployed application.

## Required Secrets

The following secrets need to be configured in your GitHub repository:

- `AWS_ACCESS_KEY_ID`: AWS access key with permissions to create and manage resources
- `AWS_SECRET_ACCESS_KEY`: Corresponding AWS secret key
- `DJANGO_SECRET_KEY`: Secret key for Django application

## How to Use

### Automatic Deployment

The workflow automatically runs when:
- Code is pushed to the `main` branch
- A pull request is created against the `main` branch

### Manual Deployment

You can also trigger the workflow manually:

1. Go to the "Actions" tab in your GitHub repository
2. Select the "Deploy Recipe App API" workflow
3. Click "Run workflow"
4. Select the environment to deploy to (dev, staging, or prod)
5. Click "Run workflow"

## Environment Management

The workflow supports multiple environments:
- `dev` (default)
- `staging`
- `prod`

Each environment is deployed to a separate Terraform workspace, allowing for isolated infrastructure per environment.

## Troubleshooting

If the deployment fails, check:

1. GitHub Actions logs for detailed error messages
2. AWS CloudWatch logs for application errors
3. Terraform state in the S3 bucket for infrastructure state

## Notes

- The first deployment may take longer as it creates all the required AWS resources
- Subsequent deployments will be faster as they only update the necessary resources
- Make sure your AWS credentials have the necessary permissions to create and manage all required resources
