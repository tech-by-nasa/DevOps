from flask import Flask, request
import os
import socket

app = Flask(__name__)

@app.route("/")
def hello():
    # Get the hostname of the pod
    hostname = socket.gethostname()
    
    # Get environment variables
    version = os.environ.get("APP_VERSION", "1.0.0")

    return (
        f"<h1 style='color: #333; text-align: center; font-family: sans-serif;'>"
        f"Hello from a containerized Python app! Version 6.0</h1>"
        f"<p style='color: #666; text-align: center; font-family: sans-serif;'>"
        f"This application is running on pod <b>{hostname}</b>."
        f"</p>"
        f"<p style='color: #666; text-align: center; font-family: sans-serif;'>"
        f"Application Version: <b>{version}</b>"
        f"</p>"
    )

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
