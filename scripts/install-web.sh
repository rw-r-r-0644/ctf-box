#!/bin/bash
set -e

echo "installing web"

# repo tools
pacman -S --noconfirm --needed nmap sqlmap nikto metasploit gobuster mitmproxy \
    python-beautifulsoup4 python-requests python-tqdm

# cleanup
echo "cleaning"
pacman -Scc --noconfirm
rm -rf /home/user/.cache