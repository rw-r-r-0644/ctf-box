#!/bin/bash
set -e

echo "installing pwn"

# repo tools
pacman -S --noconfirm --needed radare2 ropper qemu-user qemu-user-static \
    pwninit pwndbg checksec one_gadget python-keystone ropgadget python-scapy

# pip tools
sudo -u user pip install angr

# aur tools
sudo -u user yay -S --noconfirm --needed rr seccomp-tools

# cleanup
echo "cleaning"
pacman -Scc --noconfirm
rm -rf /home/user/.cache
