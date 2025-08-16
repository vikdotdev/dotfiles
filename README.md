# Installation
## Debian

To start, first ensure your user in in `/etc/sudoers`:
```bash
su
# then in sudo shell
nano /etc/sudoers
```
Add your user to sudoers:
```
%sudo           ALL=(ALL:ALL) ALL # append after this line
yourusername    ALL=(ALL) ALL     # your line
```

Dependencies that are required to run the script:
```bash
sudo apt install curl git
```

Then run the installation:
```bash
bash <(curl -L https://raw.githubusercontent.com/vikdotdev/dotfiles/master/bin/install-debian)
```

### Compatibility
Tested on Debian 13 Trixie.

### Post-installation manual steps
#### Install `kmonad-toggle`
In extension manager manually install `kmonad-toggle` extension. In "Custom command" field put:
```ruby
kmonad /home/<username>/.config/kmonad/config.kbd
```

#### Install `gnome-shell-go-to-last-workspace`
That's it, it's already configured by build scripts.

# Machine specific config
## `.profile.local`
Create a `~/.profile.local` file to store machine specific environment variables. 

Emacs package uses `DESKTOP` & `LAPTOP` variables to define default font sizes.
