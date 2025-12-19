# waybar-auto-hide Nix Package

A Nix flake for [waybar_auto_hide](https://github.com/Zephirus2/waybar_auto_hide) - a lightweight utility that automatically shows/hides Waybar in Hyprland based on cursor position and window state.

## Quick Start

```bash
# Try it out
nix run github:bashfulrobot/nixpkg-waybar-auto-hide

# Install to your profile
nix profile install github:bashfulrobot/nixpkg-waybar-auto-hide
```

Or add to your flake:

```nix
{
  inputs.waybar-auto-hide.url = "github:bashfulrobot/nixpkg-waybar-auto-hide";
}
```

## Features

- Automatically hides Waybar when workspace is empty
- Shows Waybar when cursor moves to screen top
- Built from source, pinned to v0.1
- Rust-based for performance and reliability

## Documentation

- **[Installation](docs/installation.md)** - How to install using various methods
- **[Usage](docs/usage.md)** - Configuring Hyprland and troubleshooting
- **[Integration](docs/integration.md)** - NixOS and home-manager examples
- **[Versioning](docs/versioning.md)** - Understanding when builds happen and version pinning
- **[Maintenance](docs/maintenance.md)** - Guide for package maintainers

## Support

- **Upstream Project**: [Zephirus2/waybar_auto_hide](https://github.com/Zephirus2/waybar_auto_hide)
- **This Package**: [bashfulrobot/nixpkg-waybar-auto-hide](https://github.com/bashfulrobot/nixpkg-waybar-auto-hide)
- **Issues**: Report issues with the package (not the tool itself) in this repository

## License

This Nix package follows the license of the upstream project (MIT).
