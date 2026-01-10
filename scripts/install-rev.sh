#!/bin/bash
set -e

echo "installing rev"

# repo tools
pacman -S --noconfirm --needed radare2 rizin jdk-openjdk ghidra r2ghidra jadx python-r2pipe

# pip tools
sudo -u user pip install angr lief frida-tools z3-solver

# aur tools
sudo -u user yay -S --noconfirm --needed android-apktool

# cleanup
echo "cleaning"
pacman -Scc --noconfirm
rm -rf /home/user/.cache
