# GitHub Credentials Checklist

Since you already have GitHub, AWS, and Docker Desktop open, follow these steps to add the credentials manually:

## 1. AWS Credentials

- Go to your GitHub repository: https://github.com/JiawenZhu/devops-recipe-app-api
- Navigate to Settings > Secrets and variables > Actions
- Click "New repository secret"
- Add the following secrets:

✅ `AWS_ACCESS_KEY_ID`
- Value: YOUR_ACCESS_KEY_ID (from your AWS configuration)

✅ `AWS_SECRET_ACCESS_KEY`  
- Value: YOUR_SECRET_ACCESS_KEY (from your AWS configuration)

## 2. Docker Hub Credentials

✅ `DOCKERHUB_USER`
- Value: jiawendocker

✅ `DOCKERHUB_TOKEN`
- If you haven't created a token yet:
  1. Go to Docker Hub: https://hub.docker.com/
  2. Click on your username > Account Settings > Security
  3. Create a new access token named "GitHub Actions"
  4. Copy the token value (you won't be able to see it again)

## 3. Django Secret Key

✅ `DJANGO_SECRET_KEY`
- Value: IlJpZOnIJWfgUxwqlZdKGjyELvJJ3jxlK00vDWoWvv1Ntye3A4McHSF8QTHPgQurAk8

## 4. Database Password

✅ `TF_VAR_DB_PASSWORD`
- Value: hecBLuyHd5p/smXkXEa22A==

## Verification

After adding all the secrets:
1. Go to the "Actions" tab in your GitHub repository
2. Find the workflow that previously failed
3. Click "Run workflow" and select your branch
4. Monitor the workflow execution to ensure it completes successfully

## Need Help?

- If you encounter any issues, check the workflow logs for specific error messages
- Make sure all secret names are entered exactly as shown (they are case-sensitive)
- Verify that you have permission to add secrets to the repository
