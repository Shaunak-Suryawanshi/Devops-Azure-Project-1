from flask import Flask, jsonify
import os

app = Flask(__name__)


@app.get("/")
def home():
    return jsonify({
        "message": "Azure Infrastructure Automation & Monitoring Platform",
        "status": "running"
    })


@app.get("/health")
def health():
    return jsonify({"health": "ok"}), 200


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
