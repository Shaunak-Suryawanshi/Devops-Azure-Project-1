# Step 7: Trivy Security Scanning (DevSecOps)

## Goal
Scan Docker images in CI pipeline and fail build if CRITICAL vulnerabilities are found.

## Why companies use this
- Catch security issues before deployment
- Enforce minimum security baseline automatically
- Prevent vulnerable images from reaching Kubernetes/production

## Pipeline change done
A new stage is added before deployment:
- `Trivy Security Scan`

Behavior:
1. Checks if Trivy is installed on Jenkins agent
2. Scans image: `${IMAGE_NAME}:${IMAGE_TAG}`
3. Uses:
   - `--severity CRITICAL`
   - `--exit-code 1`
4. If critical vulnerability exists, pipeline fails and deployment stage is blocked

## Install Trivy on Windows (Jenkins machine)
Option A (recommended): winget
```powershell
winget install --id AquaSecurity.Trivy -e
```

Option B: Chocolatey
```powershell
choco install trivy -y
```

After install, restart Jenkins service so PATH refreshes.

## Verify Trivy installation
```powershell
trivy --version
```

## Local scan test (manual)
```powershell
trivy image --severity CRITICAL --exit-code 1 --no-progress azure-monitoring-app:v1
```

## Expected output in Jenkins
- If no critical vulnerabilities: scan stage passes, pipeline continues
- If critical vulnerabilities found: scan stage fails, pipeline stops before `Run Container`

## Troubleshooting
1. `Trivy is not installed on Jenkins agent`
- Install Trivy on same machine/agent running Jenkins
- Restart Jenkins service

2. `trivy` command works in terminal but not in Jenkins
- PATH not available to Jenkins service account
- Add Trivy path in system environment variables
- Restart Jenkins

3. Scan fails due to network/database update issues
- Ensure internet access from Jenkins host
- Retry after a few minutes

## Common beginner mistakes
- Running scan after deployment instead of before deployment
- Not using `--exit-code 1` (pipeline won't fail)
- Forgetting Jenkins service restart after tool installation
