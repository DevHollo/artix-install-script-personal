#!/usr/bin/env bash

# Importing Variables
args=("$@")
formfactor=${args[0]}
threadsminusone=${args[1]}
gpu=${args[2]}
boot=${args[3]}
disk=${args[4]}
username=${args[5]}
userpassword=${args[6]}
timezone=${args[7]}
swap=${args[8]}

cd /mnt

# locale + timezone
echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
locale-gen

ln -sf "$timezone" /etc/localtime
hwclock --systohc

# base networking
pacman -S networkmanager-openrc --noconfirm
rc-update add NetworkManager

# user + shell
useradd -m -G wheel "$username"
echo "$userpassword\\n$userpassword" | passwd "$username"

pacman -Sy fish neovim nano sudo fastfetch --noconfirm
chsh -s /usr/bin/fish "$username"

mkdir -p /home/$username/.config/fish
cat << 'EOF' > /home/$username/.config/fish/config.fish
set -gx EDITOR nano
set -gx VISUAL nano
set -gx TZ America/Denver
alias ll='ls -lah'
alias update='doas pacman -Syu'
EOF

chown -R $username:users /home/$username/.config

echo "Installation completed. Power off and reboot."
"""
