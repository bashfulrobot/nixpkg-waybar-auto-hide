# Version Management

This document explains how versioning works for this Nix package and when builds occur.

## Current Version

**waybar-auto-hide v0.1** (commit `c7ad29a9f9d8b7acd0644b742b5be13bfa118631`)

This is pinned in the flake and will not change unless the maintainer explicitly updates it.

## When Does the Package Build?

The package builds from source **when you activate your system configuration**:

- **NixOS**: When you run `sudo nixos-rebuild switch`
- **home-manager**: When you run `home-manager switch`
- **nix profile**: When you run `nix profile install`

### Build Process

1. Nix fetches the source from the upstream repository
2. Verifies it matches the expected hash
3. Downloads Rust dependencies
4. Compiles from source using `cargo`
5. Installs the resulting binary

**Note**: There is no binary cache for custom packages like this, so it always builds from source. This takes a few minutes the first time, but Nix caches the result.

## What Version Gets Built?

### Version Pinning

The package is pinned to a specific commit in `flake.nix`:

```nix
src = pkgs.fetchFromGitHub {
  owner = "Zephirus2";
  repo = "waybar_auto_hide";
  rev = "c7ad29a9f9d8b7acd0644b742b5be13bfa118631"; # v0.1 release
  hash = "sha256-o8pCV6xkSkQs1XKGTP3RyN1JTHLrcSSDDCnvGMjJ0Xc=";
};
```

This ensures:
- ✅ **Reproducible builds** - Everyone gets the exact same version
- ✅ **Hash verification** - Build fails if source doesn't match
- ✅ **No surprises** - Version doesn't change unexpectedly

### How Users Get the Version

When you add this flake to your configuration:

```nix
inputs.waybar-auto-hide.url = "github:bashfulrobot/nixpkg-waybar-auto-hide";
```

You get whatever version is in this flake's `main` branch at the time you run `nix flake update`.

### Flake Lock File

Your `flake.lock` records the exact commit of this flake you're using:

```json
{
  "waybar-auto-hide": {
    "locked": {
      "lastModified": 1234567890,
      "narHash": "sha256-...",
      "owner": "bashfulrobot",
      "repo": "nixpkg-waybar-auto-hide",
      "rev": "abc123...",
      "type": "github"
    }
  }
}
```

This means you get the same version every time until you explicitly update.

## Getting Updates

### Update This Flake

When the maintainer updates this flake to a newer waybar-auto-hide version:

```bash
# Update just this input
nix flake update waybar-auto-hide

# Then rebuild
home-manager switch
# or
sudo nixos-rebuild switch
```

### Update All Inputs

```bash
nix flake update
home-manager switch
```

## Checking Your Version

After installation:

```bash
# Check the binary version
waybar-auto_hide --version

# Check which Nix store path you're using
which waybar-auto_hide
readlink -f $(which waybar-auto_hide)
```

## Version History

This flake's version history:
- **v0.1** (initial release) - commit `c7ad29a9f9`

Check the [upstream repository](https://github.com/Zephirus2/waybar_auto_hide) for waybar-auto-hide's version history.
