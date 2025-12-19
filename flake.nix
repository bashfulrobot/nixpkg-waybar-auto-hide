{
  description = "A lightweight utility that automatically shows/hides Waybar in Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          waybar-auto-hide = pkgs.rustPlatform.buildRustPackage {
            pname = "waybar-auto-hide";
            version = "0.1.0";

            src = pkgs.fetchFromGitHub {
              owner = "Zephirus2";
              repo = "waybar_auto_hide";
              rev = "master";
              hash = "sha256-o8pCV6xkSkQs1XKGTP3RyN1JTHLrcSSDDCnvGMjJ0Xc=";
            };

            cargoHash = "sha256-jo5qapLIb5BlttxKtF3sIziZVBb52Uju+6G8A9Bv8Io=";

            meta = with pkgs.lib; {
              description = "Lightweight utility that automatically shows/hides Waybar in Hyprland based on cursor position and window state";
              homepage = "https://github.com/Zephirus2/waybar_auto_hide";
              license = licenses.mit;
              maintainers = [ ];
              mainProgram = "waybar-auto_hide";
              platforms = platforms.linux;
            };
          };

          default = self.packages.${system}.waybar-auto-hide;
        };

        apps = {
          waybar-auto-hide = flake-utils.lib.mkApp {
            drv = self.packages.${system}.waybar-auto-hide;
          };
          default = self.apps.${system}.waybar-auto-hide;
        };
      }
    );
}
