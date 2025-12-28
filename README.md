# Overview
An Artix Linux (OpenRC) installation script that can be used to install and configure Artix Linux (OpenRC) with _**my**_ preferred setup.

Some major/noteworthy differences from common configurations:

- opendoas is used in place of sudo
- EXT4 fast_commit mode is enabled by default
- makepkg is configured for better than stock performance and uses more space-efficient compression
- dash is used as the system and login shell
- zsh (with a custom zshrc) is used as the defualt KDE (Konsole/Yakuake) shell
- Plasma Wayland is configured for speed and security by default (disabled Klipper, Baloo, session restore, etc.)

# Usage
Load the Artix Base ISO (no live) and connect to internet then run the script:

**Connect to internet**
run `sudo rc-service connmand start` then `connmanctl`. you should have a prompt that looks like this: `connmanctl>`
then run these following commands:
```

```
pacman -Sy git && git clone --depth 1 https://github.com/DevHollo/artix-install-script && bash artix-install-script/install.sh
```

After running the script, it will ask some questions about your desired configuration. Answer them and then the installation will complete automatically.

# Supported Devices
Generic:
- Most x86_64 desktops and laptops

Special:
- ASUS Zephyrus G14 (2020)
