#!/bin/bash
set -e

# 1. Custom Init Hooks (Root level)
# Allows extending the container for other projects
if [ -d /etc/entrypoint.d ]; then
    for f in /etc/entrypoint.d/*; do
        # check if file exists (wildcard expansion might fail empty)
        [ -e "$f" ] || continue
        
        if [ -x "$f" ]; then
            echo "[init] running $f"
            "$f"
        elif [[ "$f" == *.sh ]]; then
            echo "[init] sourcing $f"
            . "$f"
        fi
    done
fi

# 2. Docker & Privilege Drop
if [ "$(id -u)" -eq 0 ]; then
    
    # Check if Docker is accessible (e.g. mounted socket)
    # If not, try starting internal Sysbox dockerd without waiting
    if ! docker info >/dev/null 2>&1; then
        echo "[init] starting internal dockerd..."
        rm -f /var/run/docker.pid
        dockerd > /var/log/dockerd.log 2>&1 &
        # No waiting. If it works, it works.
    fi

    # Drop to user
    if [ "$#" -eq 0 ]; then
        exec runuser -u user -- /bin/bash
    else
        exec runuser -u user -- "$@"
    fi
else
    # Already user
    exec "$@"
fi