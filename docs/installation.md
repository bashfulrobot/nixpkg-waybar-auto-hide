# Installation

This document covers different ways to install waybar-auto-hide using this Nix flake.

## Prerequisites

- Nix with flakes enabled
- Hyprland window manager (this is a Hyprland-specific utility)

## Installation Methods

### Direct Installation with nix profile

Install directly to your user profile:

```bash
nix profile install github:bashfulrobot/nixpkg-waybar-auto-hide
```

### Run Without Installing

Try it out without installing:

```bash
nix run github:bashfulrobot/nixpkg-waybar-auto-hide
```

### In Flake-based Configurations

Add to your `flake.nix` inputs:

```nix
{
  inputs = {
    waybar-auto-hide.url = "github:bashfulrobot/nixpkg-waybar-auto-hide";
  };
}
```

Then include in your packages. See [Integration](integration.md) for detailed examples.

## Building Locally

If you've cloned this repository:

```bash
nix build
# or
just build
```

## Verifying Installation

After installation, verify the binary is available:

```bash
which waybar-auto_hide
waybar-auto_hide --version
```

## Next Steps

- [Configure Hyprland to run waybar-auto-hide](usage.md)
- [Integrate with NixOS or home-manager](integration.md)
