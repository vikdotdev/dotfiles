# Installation
Current setup relies on Fedora 36 custom install which does not include wifi firmware, which means initial ethernet connection is required:
```bash
sudo dnf install iwl7260-firmware # for my thinkpad T460
sudo reboot
nmcli connection up id <SSID> -a
```
Then, when internet is available:
```bash
curl -o- https://raw.githubusercontent.com/vikdotdev/dotfiles/master/bin/dot-setup | sh
```

# Issues & Ideas
- synchronize colors based on config.yml for alacritty, vim, tmux, delta, zathura
