# AWS Credentials Setup Guide

Our troubleshooting has identified that **your AWS credentials are not properly configured**. This is why the GitHub Actions workflow is failing with the error:

> ❌ The security token included in the request is invalid.

## Step 1: Set Up Valid AWS Credentials

You'll need to create proper AWS access keys. Here's how to do it:

1. **Log in to the AWS Management Console**: 
   - Go to https://console.aws.amazon.com

2. **Navigate to IAM**:
   - Search for "IAM" in the services search bar
   - Click on "IAM" (Identity and Access Management)

3. **Create or use an existing IAM user**:
   - For a new user: Click "Users" → "Create user"
   - Fill in a username (e.g., "github-actions")
   - Select "Programmatic access"
   - Click "Next: Permissions"
   
4. **Attach policies** with necessary permissions for your GitHub workflow:
   - You need permissions for services used in your workflow (ECR, ECS, etc.)
   - You can attach existing policies like:
     - `AmazonECR-FullAccess`
     - `AmazonECS-FullAccess`
     - Required permissions for Terraform operations
   - Click "Next" and complete the user creation
   
5. **Save your access keys**:
   - After creating the user, you'll see the Access Key ID and Secret Access Key
   - Download the CSV file or copy these credentials somewhere safe
   - **IMPORTANT**: This is the only time you'll see the Secret Access Key!

## Step 2: Configure AWS CLI

Once you have valid AWS credentials, configure the AWS CLI:

```bash
aws configure
```

Enter your:
- AWS Access Key ID
- AWS Secret Access Key
- Default region (e.g., us-east-1)
- Default output format (json)

## Step 3: Update GitHub Secrets

After configuring AWS CLI, update the GitHub secrets with your new credentials:

```bash
# Check if your AWS credentials are working locally
aws sts get-caller-identity

# If the above command works, update GitHub secrets
gh secret set AWS_ACCESS_KEY_ID -b "$(aws configure get aws_access_key_id)" -R JiawenZhu/devops-recipe-app-api
gh secret set AWS_SECRET_ACCESS_KEY -b "$(aws configure get aws_secret_access_key)" -R JiawenZhu/devops-recipe-app-api
```

## Step 4: Verify AWS Credentials Format

Make sure your AWS credentials follow the correct format:
- Access Key ID: 20 characters, uppercase letters and numbers
- Secret Access Key: 40+ characters

## Step 5: Run the GitHub Workflow Again

After updating the credentials:
```bash
gh workflow run "Deploy Recipe App API" -R JiawenZhu/devops-recipe-app-api
```

## Common AWS Credential Issues

1. **Using temporary credentials**: GitHub Actions can't use credentials with session tokens
2. **Expired credentials**: IAM access keys might be deactivated or expired
3. **Insufficient permissions**: The IAM user might not have all required permissions
4. **MFA requirements**: If your AWS account requires MFA, you need a separate IAM user for GitHub Actions

## Need More Help?

The complete troubleshooting guide is available in:
- `aws_github_credentials_final_solution.md`
- `scripts/aws_credentials_fix.sh` (requires working AWS credentials)
