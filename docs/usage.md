# Usage

This document explains how to configure and use waybar-auto-hide with Hyprland.

## What Does waybar-auto-hide Do?

waybar-auto-hide is a lightweight utility that:
- Automatically hides Waybar when the workspace is empty
- Temporarily displays Waybar when the cursor moves to the top of the screen
- Improves your Hyprland workflow by keeping the bar out of the way

## Hyprland Configuration

### Basic Setup

Add to your Hyprland configuration (`~/.config/hypr/hyprland.conf`):

```
exec-once = waybar-auto_hide &
```

This starts waybar-auto-hide automatically when Hyprland launches.

### Declarative Configuration (home-manager)

If you're using home-manager with Hyprland module:

```nix
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "waybar-auto_hide &"
      ];
    };
  };
}
```

## Behavior

Once running, waybar-auto-hide will:
1. Monitor your workspace for active windows
2. Hide Waybar when the workspace is empty
3. Show Waybar when you move your cursor to the top of the screen
4. Automatically manage Waybar visibility based on your activity

## Troubleshooting

### waybar-auto-hide doesn't start

Check if it's running:
```bash
ps aux | grep waybar-auto_hide
```

Check Hyprland logs:
```bash
cat ~/.config/hypr/hyprland.log | grep waybar
```

### Waybar doesn't hide/show as expected

Ensure Waybar is running:
```bash
ps aux | grep waybar
```

Restart waybar-auto-hide:
```bash
killall waybar-auto_hide
waybar-auto_hide &
```

## Upstream Documentation

For more details about waybar-auto-hide features and behavior, see the [upstream repository](https://github.com/Zephirus2/waybar_auto_hide).
