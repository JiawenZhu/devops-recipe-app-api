# GitHub Credentials Solution Guide

We've identified that the GitHub workflow is still failing with an AWS credentials error:

> ❌ The security token included in the request is invalid.

## What We've Done So Far

1. ✅ Created comprehensive documentation about GitHub credentials in `github_credentials_setup.md` and `github_secrets_manual.md`
2. ✅ Developed helper scripts for setting up credentials:
   - `scripts/aws_credentials_helper.sh`
   - `scripts/docker_credentials_helper.sh`
   - `scripts/generate_django_secret.sh`
   - `scripts/github_add_secrets.sh`
3. ✅ Added all required credentials to GitHub repository secrets:
   - AWS_ACCESS_KEY_ID
   - AWS_SECRET_ACCESS_KEY
   - DOCKERHUB_USER
   - DOCKERHUB_TOKEN
   - DJANGO_SECRET_KEY
   - TF_VAR_DB_PASSWORD

## Current Issue

The GitHub workflow is failing with an AWS credentials error. This is often caused by:

1. **Temporary AWS credentials being used** - GitHub Actions doesn't work with session tokens
2. **Invalid or expired AWS credentials**
3. **AWS credentials lacking necessary permissions**
4. **Two-factor authentication (MFA) requirements**

## Solution: Next Steps

1. **Run the AWS credentials troubleshooting script**:
   ```bash
   ./scripts/aws_credentials_fix.sh
   ```
   This script will:
   - Verify your AWS credentials are working locally
   - Check if you're using temporary credentials
   - Validate the format of your AWS keys
   - Update GitHub secrets with clean credentials
   - Test credentials in GitHub Actions

2. **Create new AWS credentials** (if needed):
   - Go to AWS IAM Console: https://console.aws.amazon.com/iam/
   - Select your user or create a new one
   - Go to "Security credentials" tab
   - Under "Access keys", click "Create access key"
   - Copy both the Access Key ID and Secret Access Key
   - Use these new credentials in GitHub secrets

3. **Update GitHub secrets manually**:
   - Go to your repository: https://github.com/JiawenZhu/devops-recipe-app-api/settings/secrets/actions
   - Update AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY with the new credentials
   - Ensure no whitespace or extra characters are included

## Ensuring Proper AWS Permissions

Your AWS credentials should have permissions for:
- ECR (pushing/pulling images)
- ECS (creating/updating services)
- IAM (creating roles for services)
- Other services used in your Terraform configurations

If you're using an IAM user, consider creating a policy that grants only the specific permissions needed for the GitHub workflow.

## Testing the Solution

After updating the credentials:
1. Run the GitHub workflow again
2. Monitor for any credential-related errors
3. If the workflow succeeds in the AWS credential step but fails in another step, that indicates the AWS credential issue is fixed

## Need More Help?

Contact AWS support if you continue to experience issues with AWS credentials in GitHub Actions.
