{ pkgs, lib, isDesktop, inputs, ... }:

{
  imports = [ inputs.umbriel.homeModules.default ];

  programs.umbriel = {
    enable = true;
    settings = {

      general = {
        mod_key = "Super";
        autostart = ["awww-daemon" "dunst"];
      };

      keybinds = {
        "Mod+Q" = "spawn:alacritty";
        "Mod+F" = "spawn:firefox";
        "Mod+D" = "spawn:vesktop";
        "Mod+E" = "spawn:thunar";
        "Mod+S" = "spawn:steam";

        "Mod+R" = "spawn:wofi --show drun";
        "Mod+C" = "window-close";
        "Mod+M" = "session-quit";
        "Mod+Space" = "window-toggle-floating";
        "Mod+F12" = "spawn:hyprshot -m output --clipboard-only";
        "Mod+Shift+F12" = "spawn:hyprshot -m window --clipboard-only";
        "Mod+F11" = "window-toggle-fullscreen";
        "Mod+O" = "overview-toggle";

        "Mod+H" = "window-focus-or-output-left";
        "Mod+L" = "window-focus-or-output-right";
        "Mod+K" = "window-focus-or-output-up";
        "Mod+J" = "window-focus-or-output-down";

        "Mod+Shift+H" = "window-move-or-output-left";
        "Mod+Shift+L" = "window-move-or-output-right";
        "Mod+Shift+K" = "window-move-or-output-up";
        "Mod+Shift+J" = "window-move-or-output-down";

        "Mod+Alt+H" = "window-consume-or-expel-left";
        "Mod+Alt+L" = "window-consume-or-expel-right";

        "Ctrl+Shift+H" = "window-modify-width-left:.1";
        "Ctrl+Shift+L" = "window-modify-width-right:.1";
        "Ctrl+Shift+K" = "window-modify-height-up:.1";
        "Ctrl+Shift+J" = "window-modify-height-down:.1";
        "Ctrl+Alt+H" = "window-modify-width-right:-.1";
        "Ctrl+Alt+L" = "window-modify-width-left:-.1";
        "Ctrl+Alt+K" = "window-modify-height-down:-.1";
        "Ctrl+Alt+J" = "window-modify-height-up:-.1";

        "Mod+1" = "workspace-switch:1/DP-2";
        "Mod+2" = "workspace-switch:1/HDMI-A-2";
        "Mod+3" = "workspace-switch:2/DP-2";
        "Mod+4" = "workspace-switch:2/HDMI-A-2";
        "Mod+5" = "workspace-switch:3/DP-2";
        "Mod+6" = "workspace-switch:3/HDMI-A-2";

        "Mod+Shift+Tab" = "window-move-to-scratchpad";
        "Alt+Tab" = "scratchpad-toggle";
        "Ctrl+Alt+Tab" = "window-restore-from-scratchpad";
        "Ctrl+Tab" = "scratchpad-focus-next";
      };

      input.keyboard.layout = "us"; 
      input.mouse.sensitivity = -0.25;
      input.focus.follows_mouse = true;

      output = {
        "DP-2" = {
          mode = "2560x1440@165";
          position = [0 0];
          scale = 1;
          workspaces = 3;
          vrr = "fullscreen";
        };

        "DP-3" = {
          mode = "3840x2160@60";
          position = [0 (-1440)];
          scale = 1.5;
          workspaces = ["TV"];
          hdr = "auto";
        };

        "HDMI-A-1" = {
          mode = "1920x1080@74.97";
          position = [(-1920) 400];
          scale = 1;
          workspaces = ["DOCS"];
        };

        "HDMI-A-2" = {
          mode = "1920x1080@60";
          position = [2560 400];
          scale = 1;
          workspaces = 3;
        };
      };

      layout = {
        mode = "dwindle";
        gap = 10;

        scrolling = {
          default_extent_fraction = .5;
          center_underfull_strip = false;
        };
      };

      workspace = [
        {
          output = "DP-2";
          index = 3;
          layout.mode = "scrolling";
        }
        {
          output = "DP-3";
          name = "TV";
          layout = {
            mode = "scrolling";
          };
        }
        {
          output = "HDMI-A-2";
          index = 3;
          layout.mode = "scrolling";
        }
      ];

      appearance = {
        prefer_no_csd = true;
        corner_radius = 0;
      };

      colors = {
        background = "#282828";
        text_primary = "#fbf1c7";
        text_muted = "#504945";
        accent_primary = "#d3869b";
        accent_secondary = "#83a59b";
        warning = "#fabd2f";
        error = "#fb4934";
        insert_hint = "#8ec07c";
        backdrop = "#1d2021";
        shadow = "#1d2021";

        border = {
          focused = "#d3869b";
          unfocused = "#504945";
        };
      };
    };
  };
}
