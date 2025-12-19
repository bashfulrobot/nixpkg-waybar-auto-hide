# Build the package
build:
    nix build .#waybar-auto-hide

# Run the package without installing
run:
    nix run .#waybar-auto-hide

# Update flake lock
update:
    nix flake update

# Check flake
check:
    nix flake check

# Show flake metadata
show:
    nix flake show

# Enter development shell
dev:
    nix develop

# Format Nix files
fmt:
    nix fmt

# Clean build artifacts
clean:
    rm -rf result result-*

# Create GitHub repository and push
gh-create REPO_NAME:
    gh repo create {{REPO_NAME}} --public --source=. --remote=origin
    git push -u origin main

# Update README with actual repo URL after creating GitHub repo
update-readme GITHUB_USERNAME REPO_NAME:
    sed -i 's|github:YOUR_USERNAME/waybar_auto_hide|github:{{GITHUB_USERNAME}}/{{REPO_NAME}}|g' README.md
    git add README.md
    git commit -m "Update README with actual GitHub repository URL"
    git push
