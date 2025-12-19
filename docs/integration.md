# Integration

This document shows how to integrate waybar-auto-hide into your NixOS or home-manager configurations.

## Flake Input

First, add waybar-auto-hide to your flake inputs:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    waybar-auto-hide.url = "github:bashfulrobot/nixpkg-waybar-auto-hide";
  };
}
```

## home-manager Integration

### Standalone home-manager

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    waybar-auto-hide.url = "github:bashfulrobot/nixpkg-waybar-auto-hide";
  };

  outputs = { self, nixpkgs, home-manager, waybar-auto-hide, ... }: {
    homeConfigurations.youruser = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        {
          home.packages = [
            waybar-auto-hide.packages.x86_64-linux.default
          ];

          wayland.windowManager.hyprland = {
            enable = true;
            settings = {
              exec-once = [
                "waybar-auto_hide &"
              ];
            };
          };
        }
      ];
    };
  };
}
```

### home-manager as NixOS Module

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    waybar-auto-hide.url = "github:bashfulrobot/nixpkg-waybar-auto-hide";
  };

  outputs = { self, nixpkgs, home-manager, waybar-auto-hide, ... }: {
    nixosConfigurations.yourhostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.users.youruser = {
            home.packages = [
              waybar-auto-hide.packages.x86_64-linux.default
            ];

            wayland.windowManager.hyprland = {
              enable = true;
              settings = {
                exec-once = [
                  "waybar-auto_hide &"
                ];
              };
            };
          };
        }
      ];
    };
  };
}
```

## NixOS System-Wide Installation

Install for all users:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    waybar-auto-hide.url = "github:bashfulrobot/nixpkg-waybar-auto-hide";
  };

  outputs = { self, nixpkgs, waybar-auto-hide, ... }: {
    nixosConfigurations.yourhostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
          environment.systemPackages = [
            waybar-auto-hide.packages.x86_64-linux.default
          ];
        }
      ];
    };
  };
}
```

Then users can configure it in their Hyprland config manually.

## Updating the Package

Update to the latest version from this flake:

```bash
# Update just waybar-auto-hide
nix flake update waybar-auto-hide

# Update all flake inputs
nix flake update

# Apply changes (home-manager)
home-manager switch

# Apply changes (NixOS)
sudo nixos-rebuild switch
```

## Using Specific Package Versions

You can pin to a specific commit of this flake:

```nix
{
  inputs = {
    waybar-auto-hide.url = "github:bashfulrobot/nixpkg-waybar-auto-hide/COMMIT_HASH";
  };
}
```

## Future Enhancement: NixOS Module

A declarative NixOS/home-manager module could be added to simplify configuration. Example of what it might look like:

```nix
{
  services.waybar-auto-hide = {
    enable = true;
  };
}
```

This is not currently implemented but could be added in the future.
