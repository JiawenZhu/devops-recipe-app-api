# Adding GitHub Secrets Manually

Based on running the helper scripts, we've gathered the following credentials that need to be added to your GitHub repository:

## Credentials Summary

1. **AWS Credentials**:
   - `AWS_ACCESS_KEY_ID`: YOUR_ACCESS_KEY_ID (from your AWS configuration)
   - `AWS_SECRET_ACCESS_KEY`: YOUR_SECRET_ACCESS_KEY (from your AWS configuration)

2. **Docker Hub Credentials**:
   - `DOCKERHUB_USER`: jiawendocker
   - `DOCKERHUB_TOKEN`: [Create a new access token from Docker Hub]

3. **Django Secret Key**:
   - `DJANGO_SECRET_KEY`: IlJpZOnIJWfgUxwqlZdKGjyELvJJ3jxlK00vDWoWvv1Ntye3A4McHSF8QTHPgQurAk8

4. **Database Password**:
   - `TF_VAR_DB_PASSWORD`: hecBLuyHd5p/smXkXEa22A==

## Step-by-Step Guide to Add Secrets to GitHub

1. Go to your GitHub repository: [https://github.com/JiawenZhu/devops-recipe-app-api](https://github.com/JiawenZhu/devops-recipe-app-api)

2. Click on **Settings** tab (you need to be logged in and have appropriate permissions)

3. In the left sidebar, click on **Secrets and variables** and then select **Actions**

4. Click on **New repository secret**

5. Add each of the following secrets one by one:

   ### AWS Access Key ID
   - Name: `AWS_ACCESS_KEY_ID`
   - Value: [Your AWS Access Key ID from the helper script]
   - Click **Add secret**

   ### AWS Secret Access Key
   - Name: `AWS_SECRET_ACCESS_KEY`
   - Value: [Your AWS Secret Access Key from the helper script]
   - Click **Add secret**

   ### Docker Hub Username
   - Name: `DOCKERHUB_USER`
   - Value: jiawendocker
   - Click **Add secret**

   ### Docker Hub Token
   - Name: `DOCKERHUB_TOKEN`
   - Value: [The access token generated from Docker Hub]
   - Click **Add secret**

   ### Django Secret Key
   - Name: `DJANGO_SECRET_KEY`
   - Value: IlJpZOnIJWfgUxwqlZdKGjyELvJJ3jxlK00vDWoWvv1Ntye3A4McHSF8QTHPgQurAk8
   - Click **Add secret**

   ### Database Password
   - Name: `TF_VAR_DB_PASSWORD`
   - Value: hecBLuyHd5p/smXkXEa22A==
   - Click **Add secret**

## Creating a Database Password

If you don't already have a secure database password, you can generate one using the following command:

```bash
openssl rand -base64 16
```

Run this command in your terminal to generate a secure random password.

## Verifying the Configuration

After adding all the secrets:

1. Go to the **Actions** tab in your GitHub repository
2. Find a workflow that you want to run
3. Click on **Run workflow** and select the branch
4. Monitor the workflow execution to ensure all credentials are working correctly

The error you were experiencing should now be resolved as the GitHub Actions workflows will have access to the required credentials.
