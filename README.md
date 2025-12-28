this is built for Artix OpenRC!


```bash
sudo rfkill unblock wifi
sudo ip link set wlan0 up
connmanctl
# in connman run these: 'agent on', 'scan wifi', 'services', 'connect wifi_NAME', 'quit'

ping -c 3 google.com # just to check :)

pacman -Sy git && git clone --depth 1 https://github.com/DevHollo/artix-install-script && bash artix-install-script/install.sh
```
