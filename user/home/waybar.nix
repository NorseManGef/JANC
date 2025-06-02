{ pkgs, isDesktop, ... }:

{
  programs = {
    waybar = {
      enable = true;
      settings = [
        {
          layer = "top";
          position = "top";
          height = 41;
          output = if isDesktop == true then [
            "DP-3"
            "HDMI-A-1"
          ] else [
              "eDP-1"
          ];
          modules-left = [ "tray" "hyprland/window" ];
          modules-center = [ "custom/hello-from-waybar" "hyprland/workspaces" ];
          modules-right = [ "memory" "cpu" "pulseaudio" "clock" ];

          "custom/hello-from-waybar" = {
            format = "<span font_family='BlexMono Nerd Font'>{}</span>";
            max-length = 40;
            interval = "once";
            exec = pkgs.writeShellScript "hello-from-waybar" ''
            echo " N i x OS "
            '';
          };

          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              default = " ";
              active = " ";
              urgent = " ";
            };
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
            on-click = "activate";
          };

          "memory" = {
            interval = 5;
            format = "   {}󰏰 ";
          };

          "cpu" = {
            format = "󰍛 {}󰏰 ";
          };

          "clock" = {
            format = "󰺗 {:%H:%M  󰃭 %a %d󰿟%m󰿟%Y} ";
          };

          "tray" ={
            icon-size = 20;
            spacing = 9;
          };

          "hyprland/window" = {
            format = "  {}  ";
            max-length = 70;
          };
        }
      ];

      style = '' 
      * {
          border: none;
          border-radius: 0;
          min-height: 0;
          font-family: "BlexMono Nerd Font";
          font-size: 14px;
          padding: 0;
        }

        window#waybar {
          background: #1d2021;
          border: 2px solid #3c3836;
          color: #ddc7a1;
        }

        #window {
          background-color: #1d2021;
          border: 2px solid #7c6f64;
          margin: 6px 6px 6px 0px;
          padding: 2px 8px;
        }

        #custom-hello-from-waybar {
          background-color: #1d2021;
          border: 2px solid #7c6f64;
          margin: 6px 6px 6px 0px;
          padding: 2px 8px;
        }

        #clock,
        #tray,
        #cpu,
        #memory,
        #battery,
        #network,
        #pulseaudio {
          margin: 6px 6px 6px 0px;
          padding: 2px 8px;
        }

        #workspaces {
          background-color: #303536;
          margin: 6px 0px 6px 6px;
          border: 2px solid #434a4c;
        }

        #workspaces button {
          all: initial;
          min-width: 0;
          box-shadow: inset 0 -3px transparent;
          padding: 2px 4px;
          color: #c7ab7a;
        }

        #workspaces button.focused {
          color: #ddc7a1;
        }

        #workspaces button.urgent {
          background-color: #e78a4e;
        }

        #clock {
          background-color: #303536;
          border: 2px solid #434a4c;
          color: #d4be98;
        }

        #tray {
          background-color: #d4be98;
          border: 2px solid #c7ab7a;
        }

        #cpu,
        #memory,
        #network,
        #pulseaudio {
          background-color: #ddc7a1;
          border: 2px solid #c7ab7a;
          color: #1d2021;
        }

        #cpu.critical,
        #memory.critical {
          background-color: #ddc7a1;
          border: 2px solid #c7ab7a;
          color: #c14a4a;
        }
      '';
    };
  };
}
