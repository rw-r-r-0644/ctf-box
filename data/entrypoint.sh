#!/bin/bash
set -e

# Function to start docker if possible
start_docker() {
    echo "[*] Checking for Docker support..."
    
    # Clean up stale pid
    if [ -f "/var/run/docker.pid" ]; then
        rm -f /var/run/docker.pid
    fi

    # Try starting dockerd
    dockerd > /var/log/dockerd.log 2>&1 &
    DOCKER_PID=$!
    
    echo "[*] Waiting for Docker daemon..."
    TIMEOUT=10
    while [ $TIMEOUT -gt 0 ]; do
        if docker info >/dev/null 2>&1; then
            echo "[*] Docker is running."
            # Grant access to user
            chmod 666 /var/run/docker.sock
            return 0
        fi
        sleep 1
        TIMEOUT=$((TIMEOUT-1))
    done
    
    echo "[!] Docker did not start within timeout. Proceeding without it (check /var/log/dockerd.log)."
}

# Only attempt to start docker if we are root
if [ "$(id -u)" -eq 0 ]; then
    start_docker

    # Drop privileges
    echo "[*] Dropping privileges to 'user'..."
    if [ "$#" -eq 0 ]; then
        exec runuser -u user -- /bin/bash
    else
        exec runuser -u user -- "$@"
    fi
else
    # Already non-root
    exec "$@"
fi
