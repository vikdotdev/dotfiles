# About
This configuration depends on most recent Fedora Workstation release and uses [Nix](https://nixos.org/) with [Home Manager](https://github.com/nix-community/home-manager) for declarative user environment management.

# Installation

## New Installation (Recommended - Nix-based)
```bash
curl -sL https://raw.githubusercontent.com/vikdotdev/dotfiles/master/bin/setup-nix-fedora | bash
```

## Legacy Installation (Ansible-only)
```bash
curl -o- https://raw.githubusercontent.com/vikdotdev/dotfiles/master/bin/dot-setup | sh
```

# Home Manager Usage

Home Manager lets you declaratively manage your user environment (dotfiles, packages, services). Here's what you need to know:

## Basic Commands

```bash
# Apply changes after editing configs
home-manager switch

# Switch to a specific profile (umbra, reddwarf, redgiant)
home-manager switch --flake ~/.config/home-manager#vik@umbra

# See what packages are installed
home-manager packages

# Remove old generations to save space
home-manager expire-generations "-7 days"
```

## Adding New Packages

Edit `home-manager/modules/common.nix` and add packages to the `home.packages` list:

```nix
home.packages = with pkgs; [
  ripgrep
  fd
  bat
  # Add your new package here
  htop
  tree
];
```

Then run `home-manager switch` to install.

## Profiles

This setup supports multiple machine profiles:
- **umbra** (profile 1): Desktop with NVIDIA drivers
- **reddwarf** (profile 2): Laptop  
- **redgiant** (profile 3): Laptop with KMonad

Your current profile is automatically detected by hostname.

## Configuration Files

- `flake.nix` - Main Home Manager flake (at repo root)
- `home-manager/modules/common.nix` - Shared settings across all profiles
- `home-manager/profiles/*.nix` - Profile-specific settings  
- `home-manager/scripts/*.sh` - External scripts (like bash prompt)
- `~/.config/home-manager/flake.nix` - Importing flake (points to this repo)

## Daily Workflow

```bash
# Apply dotfiles changes (reads directly from this repo)
home-manager switch

# Update system packages/configs (non-Nix stuff)
bin/dot install
```

## Development Environments

Use `nix develop` for project-specific environments instead of global installs:

```bash
# Enter a shell with Node.js 18
nix develop nixpkgs#nodejs_18

# Enter a shell with Python and specific packages  
nix develop nixpkgs#python3.withPackages(ps: [ps.requests ps.flask])

# Use .envrc for automatic activation
echo "use flake" > .envrc
```

## Troubleshooting

```bash
# Check what's wrong
home-manager switch --show-trace

# Rollback to previous generation
home-manager generations  # List generations
home-manager switch --switch-generation 42  # Switch to generation 42

# Clean up
nix-collect-garbage -d  # Remove old packages
home-manager expire-generations "-7 days"  # Remove old configs
```
