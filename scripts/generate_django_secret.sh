#!/bin/bash

# Django Secret Key Generator
# This script generates a secure random string for use as a Django secret key

echo "Django Secret Key Generator"
echo "=========================="
echo

# Generate a secure random string
# Using Python to ensure compatibility and proper randomness
if command -v python3 &> /dev/null; then
    DJANGO_SECRET=$(python3 -c 'import secrets; print(secrets.token_urlsafe(50))')
elif command -v python &> /dev/null; then
    DJANGO_SECRET=$(python -c 'import secrets; print(secrets.token_urlsafe(50))')
else
    # Fallback to using /dev/urandom if Python is not available
    DJANGO_SECRET=$(cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z0-9!@#$%^&*(-_=+)' | head -c 50)
fi

echo "Generated Django Secret Key:"
echo "$DJANGO_SECRET"
echo
echo "Add this as a GitHub secret with the name DJANGO_SECRET_KEY"
echo "Follow the instructions in github_credentials_setup.md to add this to your GitHub repository."
