#!/bin/bash
set -e

echo "installing osint"

# repo tools
pacman -S --noconfirm --needed volatility3

# pip tools
sudo -u user pip install sherlock-project socialscan theHarvester holehe

# cleanup
echo "cleaning"
pacman -Scc --noconfirm
rm -rf /home/user/.cache