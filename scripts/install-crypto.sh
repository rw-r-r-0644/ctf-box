#!/bin/bash
set -e

echo "installing crypto"

# repo tools
pacman -S --noconfirm --needed sagemath python-numpy z3 hashcat john

# pip tools
sudo -u user pip install pycryptodome

# cleanup
echo "cleaning"
pacman -Scc --noconfirm
