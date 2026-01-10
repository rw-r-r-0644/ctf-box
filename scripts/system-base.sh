#!/bin/bash
set -e

# update & install base
echo "installing base"
echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
pacman -Syu --noconfirm
pacman -S --noconfirm --needed base-devel git sudo catatonit docker wget curl vim nano tmux openssh gdb python-pip cmake python-setuptools rust \
    python-build python-installer python-setuptools-rust python-wheel \
    jq strace ltrace socat openbsd-netcat nasm patchelf binwalk perl-image-exiftool upx unrar \
    llvm clang lld 7zip unzip bind iputils net-tools python-pwntools ipython

# user setup
echo "setting up user"
useradd -m -u 1000 -G wheel,docker -s /bin/bash user
echo "user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user
chmod 0440 /etc/sudoers.d/user
echo 'export PATH=$HOME/.local/bin:$PATH' >> /home/user/.bashrc

# pip config
echo "PIP_BREAK_SYSTEM_PACKAGES=1" >> /etc/environment
echo "export PIP_BREAK_SYSTEM_PACKAGES=1" >> /home/user/.bashrc
echo 'Defaults env_keep += "PIP_BREAK_SYSTEM_PACKAGES"' > /etc/sudoers.d/pip

# init hooks
mkdir -p /etc/entrypoint.d

# pip base
sudo -u user pip install pwntools ipython

# yay
echo "installing yay"
cd /tmp
sudo -u user git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
sudo -u user makepkg -si --noconfirm
cd /
rm -rf /tmp/yay-bin

# cleanup
echo "cleaning"
pacman -Scc --noconfirm
rm -rf /var/cache/pacman/pkg/*