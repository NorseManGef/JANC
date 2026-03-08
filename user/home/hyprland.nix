{ pkgs, lib, isDesktop, ...}: 

{
  wayland.windowManager.hyprland = {
    enable = true;

    #systemd.enable = false;

    package = pkgs.hyprland;

    settings = {
      monitor = if isDesktop then [
        "DP-1, 2560x1440@165, 0x0, 1, bitdepth, 8"
        "HDMI-A-1, 1920x1080@74.97, -1920x400, 1"
        "HDMI-A-2, 1920x1080@60, 2560x400, 1"
      ] else [
        "eDP-1, 1920x1080@144, 0x0, 1"
        "HDMI-A-1, 1920x1080@60, 1920x0, 1"
      ];

      exec-once = "swww-daemon ; dunst";

      exec = "${pkgs.protonvpn-gui}/bin/protonvpn-app";

      env = if isDesktop then "XCURSOR_SIZE,24" else [ "XCURSOR_SIZE,24" "LIBVA_DRIVER_NAME,nvidia" "LIBVA_DRIVER_NAME,nvidia" ];

      input = {
        follow_mouse = "1";
        sensitivity = "-0.5";
      };

      device = if isDesktop then {} else {
        name = "cust0001:00-06cb:cda1-touchpad";
        sensitivity = "-0.25";
      };

      general = {
        gaps_in = "5";
        gaps_out = "20";
        border_size = "2";
        "col.active_border" = "rgb(D3869B) rgb(D3869B) 0deg"; #00ff99ee
        "col.inactive_border" = "rgb(323232)";
        layout = "dwindle";
      };


      decoration = {
        rounding = "0";

        blur = {
          enabled = "true";
          size = "3";
          passes = "1";
        };

        shadow = {
          enabled = "true";
          range = "4";
          render_power = "3";
        };
      };

      animations = {
        enabled = "yes";

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, myBezier"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_status = "master";
      };

      "$mainMod" = if isDesktop then "SUPER" else "ALT";

      bind = ([
        # App binds
        "$mainMod, Q, exec, alacritty"
        "$mainMod, F, exec, firefox"
        "$mainMod, D, exec, vesktop"
        "$mainMod, E, exec, thunar"
        "$mainMod, S, exec, steam"
        "$mainMod SHIFT, S, exec, alvr"
        "$mainMod SHIFT, X, exec, hyprlock"

        # Hypr binds
        "$mainMod, R, exec, wofi --show drun"
        "$mainMod, C, killactive,"
        "$mainMod SHIFT, M, exit,"
        "$mainMod, SPACE, togglefloating,"
        "$mainMod, P, pseudo,"
        "$mainMod, G, togglesplit,"
        "$mainMod, F12, exec, hyprshot -m output --clipboard-only"
        "$mainMod SHIFT, F12, exec, hyprshot -m window --clipboard-only"
        "$mainMod, F11, fullscreen,"

        # Focus binds
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Move binds
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"

        # Workspace binds
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Special workspace
        "$mainMod, Tab, togglespecialworkspace, magic"
        "$mainMod SHIFT, Tab, movetoworkspace, special:magic"

        # Scroll through workspaces
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ]) 
        ++(if isDesktop then [] else [
        "$mainMod, F9, exec, brightnessctl --class=backlight set +10%"
        "$mainMod, F8, exec, brightnessctl --class=backlight set 10%-"
      ]);

      binde = [
        "$mainMod, F3, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
        "$mainMod, F2, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      workspace = if isDesktop then [
        "1,monitor:DP-1"
        "2,monitor:HDMI-A-2"
        "3,monitor:DP-1"
        "4,monitor:HDMI-A-2"
        "5,monitor:DP-1"
        "6,monitor:HDMI-A-2"
        "7,monitor:DP-1"
        "8,monitor:HDMI-A-2"
        "9,monitor:DP-1"
        "10,monitor:HDMI-A-2"
      ] else [];

      gestures = if isDesktop == false then {
        workspace_swipe = "true";
        workspace_swipe_distance = "150";
      } else {}; 

      misc = {
        vrr = "3";
      };

      experimental = {
      };
    };
  };

  programs = {
    hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 0;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = lib.mkForce [
          {
            monitor = "";
            path = "~/Pictures/walls/Animated-retro-city.png";
            blur_passes = 0;
            blur_size = 0;
          }
        ];
      };
    };
  };
}
