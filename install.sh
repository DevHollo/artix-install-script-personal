#!/usr/bin/env bash

# ==========================
# PERSONAL DEFAULTS (Hollo)
# ==========================
DEFAULT_TZ="America/Denver"
DEFAULT_KEYMAP="us"

loadkeys "$DEFAULT_KEYMAP"

echo ----------------------------------------------------------------------------------------------
echo Hollo's Artix Install Script
echo Last updated September 27, 2025
echo ----------------------------------------------------------------------------------------------
echo You will be asked some questions before installation.
echo -e "----------------------------------------------------------------------------------------------\\n"
read -n 1 -s -r -p 'Press any key to continue'

# BEGIN BASIC QUESTIONS
echo -e '\\nSpecial devices:\\n1. ASUS Zephyrus G14 (2020)\\nGeneric:\\n2. Laptop\\n3. Desktop\\n4. Headless desktop\\n'
read -n 1 -r -p "Formfactor: " formfactor

echo -e "\\n"
fdisk -l
echo
read -rp "Disk: " disk

read -rp "Swap (in GB): " swap

read -n 1 -rp "Clean install? (y/N) " wipe
echo
read -rp "Username: " username

read -rp "$username password: " userpassword
read -rp "Hostname: " hostname
# END BASIC QUESTIONS

# BEGIN TIMEZONE CONFIGURATION
zroot=/usr/share/zoneinfo
timezone="$DEFAULT_TZ"

read -rp "Timezone [$timezone]: " tz_input
[ -n "$tz_input" ] && timezone="$tz_input"

timezone="$zroot/$timezone"
# END TIMEZONE CONFIGURATION

# BEGIN HARDWARE DETECTION
pacman -S bc --noconfirm
threadsminusone=$(echo "$(nproc) - 1" | bc)

gpu=$(lspci | grep 'VGA compatible controller:' | awk 'FNR == 1 {print $5;}')
if ! ([ "$gpu" == 'NVIDIA' ] || [ "$gpu" == 'Intel' ]); then
    gpu=AMD
fi

ram=$(awk '/MemTotal/ {print int($2/1024/1024)}' /proc/meminfo)
interfaces=(/sys/class/net/*)
# END HARDWARE DETECTION

# normalize inputs
wipe=${wipe,,}
username=${username,,}
hostname=${hostname,,}

disk0=$disk
if [[ "$disk" == /dev/nvme* ]] || [[ "$disk" == /dev/mmcblk* ]]; then
    disk="${disk}p"
fi

# determine boot mode
if [ -d "/sys/firmware/efi" ]; then
    boot=1
else
    boot=2
fi

# BEGIN PARTITIONING (unchanged logic trimmed for brevity)
mkdir -p /mnt

# create array of variables to pass to part 2
var_export=($formfactor $threadsminusone $gpu $boot $disk0 $username $userpassword $timezone $swap 0 0 0)

mount --bind /root/artix-install-script /mnt/mnt
artix-chroot /mnt /mnt/chrootInstall.sh "${var_export[@]}"
