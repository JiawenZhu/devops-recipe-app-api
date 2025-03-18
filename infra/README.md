# Recipe App API Infrastructure

This directory contains the Terraform configurations for deploying the Recipe App API to AWS.

## Architecture Overview

The Recipe App API is deployed on AWS using the following services:

- **Amazon ECR**: Stores Docker images for the application and proxy
- **Amazon ECS (Fargate)**: Runs the containerized application
- **Amazon RDS (PostgreSQL)**: Hosts the application database
- **Amazon EFS**: Provides persistent storage for media files
- **Amazon Route53**: Manages DNS records
- **Elastic Load Balancer**: Routes traffic to the application
- **Amazon VPC**: Provides networking infrastructure
- **Amazon CloudWatch**: Monitors application logs

## Directory Structure

- `setup/`: Contains Terraform configurations for initial infrastructure setup (ECR repositories, IAM roles)
- `deploy/`: Contains Terraform configurations for deploying the application (ECS, RDS, EFS, etc.)
- `setup_ec2/`: Contains Terraform configurations for EC2 setup (if needed)
- `setup_rds/`: Contains Terraform configurations for RDS setup (if needed)

## Deployment Process

The deployment process is automated using GitHub Actions and consists of the following steps:

1. **Infrastructure Setup**:
   - Creates ECR repositories for storing Docker images
   - Sets up IAM roles and policies

2. **Build and Push Docker Images**:
   - Builds the application and proxy Docker images
   - Pushes the images to ECR

3. **Infrastructure Deployment**:
   - Creates/updates VPC, subnets, and security groups
   - Provisions RDS database
   - Sets up EFS for persistent storage
   - Deploys ECS service with Fargate
   - Configures load balancer and DNS

4. **Application Setup**:
   - Runs database migrations
   - Collects static files

## Environment Management

The infrastructure supports multiple environments (dev, staging, prod) using Terraform workspaces. Each environment has its own isolated infrastructure.

## Manual Deployment

If you need to deploy manually without GitHub Actions, follow these steps:

### Setup Infrastructure

```bash
cd infra/setup
terraform init
terraform apply
```

### Deploy Application

```bash
cd infra/deploy
terraform init
terraform workspace select dev  # or create a new workspace
terraform apply -var="ecr_app_image=<app_image_url>" -var="ecr_proxy_image=<proxy_image_url>" -var="django_secret_key=<secret_key>"
```

## Destroying Infrastructure

To destroy the infrastructure manually, follow these steps:

### Destroy Deployment Infrastructure First

```bash
cd infra/deploy
terraform init
terraform workspace select dev  # or the workspace you want to destroy
terraform destroy
```

### Then Destroy Setup Infrastructure

```bash
cd infra/setup
terraform init
terraform destroy
```

> **Important**: Always destroy the deployment infrastructure before destroying the setup infrastructure to avoid dependency issues.

## Infrastructure Diagram

```
                                  ┌─────────────────┐
                                  │                 │
                                  │  Route53 DNS    │
                                  │                 │
                                  └────────┬────────┘
                                           │
                                           ▼
┌─────────────────────────────────────────────────────────────────────┐
│                                                                     │
│  VPC                                                                │
│                                                                     │
│  ┌─────────────────┐         ┌─────────────────┐                    │
│  │                 │         │                 │                    │
│  │  Public Subnet  │◄────────┤  Load Balancer  │                    │
│  │                 │         │                 │                    │
│  └────────┬────────┘         └────────┬────────┘                    │
│           │                           │                             │
│           ▼                           │                             │
│  ┌─────────────────┐                  │                             │
│  │                 │                  │                             │
│  │  NAT Gateway    │                  │                             │
│  │                 │                  │                             │
│  └────────┬────────┘                  │                             │
│           │                           │                             │
│           ▼                           ▼                             │
│  ┌─────────────────┐         ┌─────────────────┐                    │
│  │                 │         │                 │                    │
│  │ Private Subnet  │◄────────┤  ECS Fargate    │                    │
│  │                 │         │                 │                    │
│  └────────┬────────┘         └────────┬────────┘                    │
│           │                           │                             │
│           ▼                           │                             │
│  ┌─────────────────┐                  │                             │
│  │                 │                  │                             │
│  │  RDS Database   │◄─────────────────┘                             │
│  │                 │                                                │
│  └─────────────────┘                                                │
│                                                                     │
│  ┌─────────────────┐                                                │
│  │                 │                                                │
│  │  EFS Storage    │◄─────────────────┐                             │
│  │                 │                  │                             │
│  └─────────────────┘                  │                             │
│                                       │                             │
└───────────────────────────────────────┼─────────────────────────────┘
                                        │
                              ┌─────────┴────────┐
                              │                  │
                              │  ECR Repository  │
                              │                  │
                              └──────────────────┘
```

## Security Considerations

- All resources are deployed within a VPC for network isolation
- Private subnets are used for database and application containers
- Security groups restrict access to only necessary ports
- IAM roles follow the principle of least privilege
- Sensitive data is stored in GitHub Secrets and passed as variables

## Scaling

The application can be scaled by:

1. Adjusting the `desired_count` parameter in the ECS service
2. Modifying the CPU and memory allocations in the task definition
3. Setting up auto-scaling policies based on CPU/memory utilization

## Monitoring and Logging

- Application logs are sent to CloudWatch Logs
- ECS service metrics are available in CloudWatch Metrics
- RDS database metrics are available in CloudWatch Metrics

## Cost Optimization

- Fargate is used to avoid paying for idle EC2 instances
- Resources are sized appropriately for the expected load
- Multi-AZ deployments are used for production environments only
