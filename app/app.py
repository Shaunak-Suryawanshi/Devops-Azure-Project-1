from flask import Flask, jsonify
import os
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)
REQUEST_COUNTER = Counter("app_http_requests_total", "Total HTTP requests", ["endpoint"])


@app.get("/")
def home():
    REQUEST_COUNTER.labels(endpoint="/").inc()
    return jsonify({
        "message": "Azure Infrastructure Automation & Monitoring Platform",
        "status": "running"
    })


@app.get("/health")
def health():
    REQUEST_COUNTER.labels(endpoint="/health").inc()
    return jsonify({"health": "ok"}), 200


@app.get("/metrics")
def metrics():
    REQUEST_COUNTER.labels(endpoint="/metrics").inc()
    return generate_latest(), 200, {"Content-Type": CONTENT_TYPE_LATEST}


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
