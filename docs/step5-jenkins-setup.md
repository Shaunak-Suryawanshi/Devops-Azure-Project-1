# Step 5 Jenkins Job Setup (Windows + Docker Desktop)

## Recommended job type
- Pipeline job (not Freestyle)

## Pipeline definition
- Definition: Pipeline script from SCM
- SCM: Git
- Repository URL: your GitHub repository URL
- Branch specifier: */main (or your feature branch while testing)
- Script Path: Jenkinsfile

## Jenkins prerequisites on Windows
- Java installed and visible in PATH
- Jenkins service running
- Docker Desktop running
- Jenkins user allowed to run Docker commands

## First pipeline goal
1. Pull code from GitHub
2. Build Docker image
3. Run container
4. Verify /health endpoint
