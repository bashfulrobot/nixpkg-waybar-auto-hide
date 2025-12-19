# Maintenance Guide

This document is for maintainers of this Nix package.

## Development Commands

This repository includes a `justfile` for common tasks:

```bash
just build      # Build the package
just run        # Run without installing
just update     # Update flake inputs
just check      # Check flake for issues
just show       # Show flake outputs
just fmt        # Format Nix files
just clean      # Remove build artifacts
```

## Updating to New Upstream Versions

When waybar_auto_hide releases a new version, follow these steps:

### 1. Find the New Commit Hash

Visit the [upstream repository](https://github.com/Zephirus2/waybar_auto_hide) and find the commit hash for the new release.

### 2. Update flake.nix

Edit `flake.nix` and update these fields:

```nix
{
  version = "X.Y.Z";  # Line 18

  src = pkgs.fetchFromGitHub {
    rev = "NEW_COMMIT_HASH";  # Line 23
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";  # Line 24
  };

  cargoHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";  # Line 27
}
```

### 3. Get the Source Hash

Build to get the correct source hash:

```bash
nix build .#waybar-auto-hide 2>&1 | grep "got:"
```

Copy the hash from the output and update the `hash` field in `flake.nix`.

### 4. Get the Cargo Hash

Build again to get the correct cargo hash:

```bash
nix build .#waybar-auto-hide 2>&1 | grep "got:"
```

Copy the hash from the output and update the `cargoHash` field in `flake.nix`.

### 5. Test the Build

Verify the package builds successfully:

```bash
nix build .#waybar-auto-hide
./result/bin/waybar-auto_hide --version
```

### 6. Update Documentation

Update `docs/versioning.md` with the new version in the version history section.

### 7. Commit and Push

```bash
git add flake.nix docs/versioning.md
git commit -m "Update to waybar-auto-hide vX.Y.Z"
git push
```

## Testing Changes

### Local Testing

Build and test locally:

```bash
nix build
nix run .#waybar-auto-hide
```

### Test in a Configuration

Create a test flake or update your personal configuration:

```nix
{
  inputs = {
    waybar-auto-hide.url = "path:/path/to/local/repo";
  };
}
```

Then rebuild and test.

## Flake Maintenance

### Update Nixpkgs

Update the nixpkgs input to get newer Rust toolchain or dependencies:

```bash
nix flake update nixpkgs
```

Test that the build still works after updating.

### Check for Issues

Run flake checks:

```bash
nix flake check
```

## Repository Structure

```
.
├── flake.nix           # Main package definition
├── flake.lock          # Locked dependencies
├── justfile            # Development commands
├── README.md           # User-facing documentation
├── .gitignore          # Git ignore rules
└── docs/
    ├── installation.md # Installation guide
    ├── usage.md        # Usage guide
    ├── integration.md  # Integration examples
    ├── versioning.md   # Version management
    └── maintenance.md  # This file
```

## Future Enhancements

### Add NixOS Module

Create a module for declarative configuration:

```nix
# module.nix
{ config, lib, pkgs, ... }:
{
  options.services.waybar-auto-hide = {
    enable = lib.mkEnableOption "waybar-auto-hide service";
  };

  config = lib.mkIf config.services.waybar-auto-hide.enable {
    home.packages = [ pkgs.waybar-auto-hide ];
    wayland.windowManager.hyprland.settings = {
      exec-once = [ "waybar-auto_hide &" ];
    };
  };
}
```

### Add Development Shell

Add a dev shell to `flake.nix`:

```nix
devShells.default = pkgs.mkShell {
  buildInputs = with pkgs; [
    rustc
    cargo
    rustfmt
    clippy
  ];
};
```

### Add Overlay

Create an overlay for easier nixpkgs integration:

```nix
overlays.default = final: prev: {
  waybar-auto-hide = self.packages.${final.system}.waybar-auto-hide;
};
```

## Release Process

1. Update to new upstream version (steps above)
2. Test the build and functionality
3. Update version documentation
4. Commit with semantic message
5. Tag the release (optional)
6. Push to GitHub

Users will get the update when they run `nix flake update waybar-auto-hide`.
