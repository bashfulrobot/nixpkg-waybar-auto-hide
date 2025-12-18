# waybar-auto-hide Nix Package

A Nix flake for [waybar_auto_hide](https://github.com/Zephirus2/waybar_auto_hide) - a lightweight utility that automatically shows/hides Waybar in Hyprland based on cursor position and window state.

## Features

- Automatically hides Waybar when the workspace is empty
- Temporarily displays Waybar when cursor moves to the top of the screen
- Written in Rust for performance and reliability

## Usage

### With Nix Flakes

Add this flake to your `flake.nix` inputs:

```nix
{
  inputs = {
    waybar-auto-hide.url = "github:YOUR_USERNAME/waybar_auto_hide";
  };
}
```

Then include it in your system packages or home-manager configuration:

```nix
environment.systemPackages = [
  inputs.waybar-auto-hide.packages.${pkgs.system}.default
];
```

### Direct Installation

```bash
nix profile install github:YOUR_USERNAME/waybar_auto_hide
```

### Run Without Installing

```bash
nix run github:YOUR_USERNAME/waybar_auto_hide
```

## Configuration

Add to your Hyprland configuration (`~/.config/hypr/hyprland.conf`):

```
exec-once = waybar-auto_hide &
```

## Building Locally

```bash
nix build
```

## Development

Enter development shell:

```bash
nix develop
```

## License

This package follows the license of the upstream project (MIT).

## Upstream

Original project: https://github.com/Zephirus2/waybar_auto_hide
