# Installation
## Debian
To start, first ensure your user in in `/etc/sudoers`:
```bash
su
nano /etc/sudoers
```

```
%sudo   ALL=(ALL:ALL) ALL # append after this line
yourusername    ALL=(ALL) NOPASSWD:ALL # your line
```

Then run the installation:
```bash
bash <(curl -L https://raw.githubusercontent.com/vikdotdev/dotfiles/master/bin/install-debian)
```
# Machine specific config
## `.profile.local`
Create a `~/.profile.local` file to store machine specific environment variables. 

Emacs package uses `DESKTOP` & `LAPTOP` variables to define default font sizes.
