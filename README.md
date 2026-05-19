# Azure Infrastructure Automation & Monitoring Platform

Beginner-friendly, real-world DevOps project to learn CI/CD, containers, Kubernetes, monitoring, security scanning, Infrastructure as Code, and automation on Azure.

## Project Goal
This project helps prepare for:
- Junior DevOps Engineer
- Cloud Engineer
- System Engineer
- Infrastructure Engineer

## Architecture Flow
GitHub Push -> Webhook -> Jenkins Pipeline -> Docker Build -> Trivy Scan -> Kubernetes Deploy -> Prometheus Monitoring -> Grafana Dashboards -> Terraform Azure Infra -> Ansible VM Configuration

## Tech Stack
- Cloud: Azure
- DevOps: Git, GitHub, Jenkins, Webhooks, Docker
- Kubernetes: Minikube, kubectl
- Monitoring: Prometheus, Grafana
- Security: Trivy
- IaC: Terraform
- Automation: Ansible
- App: Lightweight Python (Flask)

## Current Progress
- [x] Step 1: Environment Verification + Project Structure
- [x] Step 2: Lightweight Python Application
- [x] Step 3: Docker Fundamentals
- [x] Step 4: Git + GitHub Workflow
- [x] Step 5: Jenkins Basic CI Pipeline
- [x] Step 6: GitHub Webhook Auto Trigger
- [ ] Step 7: Trivy Security Scanning
- [ ] Step 8: Kubernetes with Minikube
- [ ] Step 9: Monitoring Stack
- [ ] Step 10: Terraform Basics
- [ ] Step 11: Ansible Automation
- [ ] Step 12: Azure Deployment
- [ ] Step 13: Final Architecture Review

## Repository Structure
```text
azure-infra-automation-monitoring/
|- app/
|- docker/
|- jenkins/
|- k8s/
|- monitoring/
|  |- prometheus/
|  |- grafana/
|- terraform/
|- ansible/
|- scripts/
|- docs/
|- Jenkinsfile
|- .gitignore
```

## Quick Start (Local)
1. Run Flask app:
```powershell
cd app
python -m pip install -r requirements.txt
python app.py
```

2. Build Docker image:
```powershell
cd app
docker build -t azure-monitoring-app:v1 .
```

3. Run container:
```powershell
docker run -d --name azure-app-container -p 5000:5000 azure-monitoring-app:v1
```

4. Verify health endpoint:
```powershell
Invoke-WebRequest -UseBasicParsing http://localhost:5000/health
```

## Jenkins Pipeline
Pipeline file: `Jenkinsfile`
Main stages:
- Checkout Source
- Build Docker Image
- Run Container
- Verify Health

## Notes
- Keep ngrok running while testing GitHub webhooks to local Jenkins.
- If ngrok URL changes, update GitHub webhook payload URL.

## Author
Shaunak Suryawanshi
