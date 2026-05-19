# Step 6: GitHub Webhook + Automatic Jenkins Trigger

## Goal
When you push to GitHub, Jenkins should start the pipeline automatically.

## Why companies use this
- No manual "Build Now" clicks
- Faster feedback to developers
- Standard CI/CD behavior for every commit

## How trigger works
1. Developer pushes code to GitHub
2. GitHub sends HTTP POST event (webhook) to Jenkins
3. Jenkins receives event
4. Jenkins runs pipeline from Jenkinsfile

## Jenkinsfile change done
- Added:
  - triggers { githubPush() }

This tells Jenkins job it can be triggered by GitHub push events.

## Jenkins UI configuration (required)
In your Pipeline job:
1. Open job -> Configure
2. Build Triggers section
3. Enable: GitHub hook trigger for GITScm polling
4. Save

## GitHub webhook configuration
In repository:
1. Settings -> Webhooks -> Add webhook
2. Payload URL:
   - If Jenkins is local only: webhook from GitHub will NOT reach localhost directly
   - Use one option:
     - ngrok tunnel to Jenkins, or
     - public VM/IP where Jenkins is reachable
3. Content type: application/json
4. Which events: Just the push event
5. Active: checked
6. Add webhook

## Local machine reality check
If Jenkins runs at http://localhost:8080, GitHub cloud cannot call it directly.
You need public reachability (temporary tunnel or hosted Jenkins).

## Quick test after setup
1. Make a small commit
2. Push to GitHub
3. Check Jenkins build history
4. Build should start automatically

## Troubleshooting
1. Webhook shows red response in GitHub
- Jenkins URL unreachable from internet

2. Jenkins not triggering
- Build trigger option not enabled in job
- Wrong webhook payload URL

3. 403 or crumb/security issues
- Configure GitHub plugin and webhook endpoint correctly

4. Pipeline starts but fails in Docker stage
- Jenkins service account cannot access Docker daemon

## Common beginner mistakes
- Using localhost URL in webhook payload
- Forgetting to enable GitHub hook trigger in Jenkins job
- Assuming webhook works without public Jenkins endpoint
