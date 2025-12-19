# Next Steps for waybar-auto-hide Nix Package

## Current Status

The Nix flake has been created with:
- ✅ Complete `flake.nix` with correct source and cargo hashes
- ✅ README.md with usage instructions
- ✅ .gitignore for Nix artifacts
- ✅ justfile for common commands
- ✅ Git repository initialized with initial commit
- ✅ flake.lock generated

## Immediate Next Steps

### 1. Test the Build
```bash
just build
# or
nix build .#waybar-auto-hide
```

This will verify that the package builds successfully with the correct hashes.

### 2. Test the Package
```bash
just run
# or
nix run .#waybar-auto-hide -- --help
```

Test that the built binary works as expected.

### 3. Commit Changes
The flake.nix has been updated with correct hashes. Commit these changes:
```bash
git add flake.nix flake.lock justfile
git commit -m "Add correct Nix hashes and justfile"
```

### 4. Create GitHub Repository
Once you're ready to publish, create the GitHub repository:

```bash
# Replace YOUR_USERNAME and REPO_NAME with your values
just gh-create YOUR_USERNAME/waybar-auto-hide-nix

# Then update the README with the actual repo URL
just update-readme YOUR_USERNAME waybar-auto-hide-nix
```

Or manually:
```bash
gh repo create waybar-auto-hide-nix --public --source=. --remote=origin
git push -u origin main
```

### 5. Update README
After creating the GitHub repo, update all instances of `YOUR_USERNAME` in README.md with your actual GitHub username.

## Future Enhancements

### Optional Improvements
- Add a development shell with Rust toolchain in `flake.nix`
- Add overlay for easier integration
- Consider pinning to a specific git tag instead of `master` branch
- Add NixOS module for declarative configuration
- Add tests to verify the package works in different environments

### NixOS Module Example
Create a `module.nix` for easier integration:
```nix
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

## Integration Examples

### In home-manager flake
```nix
{
  inputs = {
    waybar-auto-hide.url = "github:YOUR_USERNAME/waybar-auto-hide-nix";
  };

  outputs = { self, nixpkgs, home-manager, waybar-auto-hide, ... }: {
    homeConfigurations.youruser = home-manager.lib.homeManagerConfiguration {
      modules = [
        {
          home.packages = [
            waybar-auto-hide.packages.x86_64-linux.default
          ];
        }
      ];
    };
  };
}
```

### Direct in NixOS configuration
```nix
{
  inputs.waybar-auto-hide.url = "github:YOUR_USERNAME/waybar-auto-hide-nix";
}

# In your system configuration:
environment.systemPackages = [
  inputs.waybar-auto-hide.packages.${pkgs.system}.default
];
```

## Maintenance

### Updating to New Versions
When the upstream repository updates:

1. Update the `rev` in flake.nix to the new commit/tag
2. Run `nix build` to get the new source hash
3. Update the `hash` field
4. Run `nix build` again to get the new cargoHash
5. Update the `cargoHash` field
6. Test and commit

### Useful Commands
```bash
just update     # Update flake inputs
just check      # Check flake for issues
just show       # Show flake outputs
just fmt        # Format Nix files
just clean      # Remove build artifacts
```
