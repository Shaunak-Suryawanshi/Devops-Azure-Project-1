# Step 9: Monitoring with Prometheus + Grafana

## Why monitoring matters in companies
Monitoring answers 3 critical questions:
1. Is the app up?
2. Is traffic increasing/decreasing?
3. Are we degrading before users complain?

Without monitoring, teams guess. With monitoring, teams act with data.

## What is added in this project
- App exposes `/metrics` using `prometheus-client`
- Prometheus scrapes app metrics
- Grafana visualizes metrics

## Files
- `monitoring/prometheus/prometheus-configmap.yaml`
- `monitoring/prometheus/prometheus-deployment.yaml`
- `monitoring/prometheus/prometheus-service.yaml`
- `monitoring/grafana/grafana-datasource-configmap.yaml`
- `monitoring/grafana/grafana-deployment.yaml`
- `monitoring/grafana/grafana-service.yaml`
- `app/app.py` (`/metrics` endpoint)

## Apply monitoring stack
```powershell
kubectl apply -f monitoring/prometheus/prometheus-configmap.yaml
kubectl apply -f monitoring/prometheus/prometheus-deployment.yaml
kubectl apply -f monitoring/prometheus/prometheus-service.yaml
kubectl apply -f monitoring/grafana/grafana-datasource-configmap.yaml
kubectl apply -f monitoring/grafana/grafana-deployment.yaml
kubectl apply -f monitoring/grafana/grafana-service.yaml
```

## Verify
```powershell
kubectl get pods
kubectl get svc
```
Expected services:
- `prometheus-service` (NodePort 30090)
- `grafana-service` (NodePort 30300)

## Open UIs
```powershell
minikube service prometheus-service --url
minikube service grafana-service --url
```
Grafana login:
- username: `admin`
- password: `admin123`

## First useful metric query (Prometheus/Grafana)
```promql
app_http_requests_total
```
Also useful rate query:
```promql
rate(app_http_requests_total[1m])
```

## Interview-ready explanation
"I added observability to my CI/CD-deployed app by exposing Prometheus metrics in Flask, scraping them with Prometheus, and visualizing request traffic in Grafana. This lets me validate application health trends and request behavior after deployments, not just binary up/down checks."

## Common beginner mistakes
1. Scraping `/health` instead of `/metrics`.
2. Forgetting to expose metrics in app code.
3. Not checking service/pod selectors.
4. Skipping verification with `kubectl get pods`.
