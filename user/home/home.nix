{ config, pkgs, inputs, ... }:

{
 home.username = "norsemangef";
 home.homeDirectory = "/home/norsemangef";
 home.enableNixpkgsReleaseCheck = false;

  #imports = [ inputs.hyprland.homeManagerModules.default ];

  home.packages = [
    pkgs.hello
    pkgs.zoxide
	  pkgs.fzf
    pkgs.atuin
    pkgs.dunst
    pkgs.btop
    pkgs.onlyoffice-bin
    pkgs.kdePackages.kdenlive
    pkgs.heroic
    pkgs.superTuxKart
    pkgs.prismlauncher
  ];

  services = {
    dunst = {
      enable = true;
      waylandDisplay = "1";
      settings = {
        global = {
          width = 300;
          height = 300;
          offset = "30x50";
          origin = "top-right";
          #font = "HeavyData Nerd Font";
          corner_radius = 300;
          corners = "all";
        };
      };
    };
  };
   
  programs = {
    vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        sainnhe.gruvbox-material
        mkhl.direnv
        xaver.clang-format
        ms-vscode.cpptools
        ms-vscode.cpptools-extension-pack
      ];
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        nswitch = "sudo nixos-rebuild switch --flake ~/nixos/#nixos";
        nswitch-upgrade = "cd ~/nixos && sudo nix flake update && sudo nixos-rebuild switch --upgrade --flake ~/nixos/#nixos";
		    ntest = "sudo nixos-rebuild test --flake ~/nixos/#nixos";
		    nboot = "sudo nixos-rebuild boot --flake ~/nixos/#nixos";
		    nshutdown = "sudo nixos-rebuild boot --flake ~/nixos/#nixos && shutdown now";
		    fetch = "fastfetch";
		    edhome = "cd ~/nixos/ && nvim home.nix";
		    edconf = "cd ~/nixos/ && nvim configuration.nix";
        edflake = "cd ~/nixos/ && nvim flake.nix";
        svim = "sudo -E -s nvim";
        winboot = "grub-reboot 3";
      };
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
    atuin = {
      enable = true;
      enableBashIntegration = true;
      settings = {
          enter_accept = false;
      };
    };
    hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 0;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = [
        {
         monitor = "";
           path = "~/Pictures/walls/Animated-retro-city.png";
           blur_passes = 0;
           blur_size = 0;
         }
        ];
      };
    };
    alacritty.enable = true;

    waybar = {
      enable = true;
      settings = [
        {
          layer = "top";
          position = "top";
          height = 41;
          output = [
            "DP-3"
            "HDMI-A-1"
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

  wayland.windowManager.hyprland = {
    enable = true;
    
    #systemd.enable = false;
    
    package = pkgs.hyprland;

    settings = { 

      monitor = [ 
        "DP-3, 2560x1440@165, 0x0, 1" 
		"HDMI-A-1, 1920x1080@60, 2560x500, 1"
      ];
      
      exec-once = "swww init ; dunst";

      exec = "${pkgs.protonvpn-gui}/bin/protonvpn-app";

      env = "XCURSOR_SIZE,24";
      input = {
        follow_mouse = "1";

	    sensitivity = "-0.5";
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

      "$mainMod" = "SUPER";

      bind = [
        # App binds
		"$mainMod, Q, exec, alacritty"
		"$mainMod, F, exec, floorp"
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
        "$mainMod, J, togglesplit,"
        "$mainMod, F12, exec, hyprshot -m output --clipboard-only"
        "$mainMod SHIFT, F12, exec, hyprshot -m window --clipboard-only"
        "$mainMod, F11, fullscreen,"

		# Focus binds
		"$mainMod, left, movefocus, l"
		"$mainMod, right, movefocus, r"
		"$mainMod, up, movefocus, u"
		"$mainMod, down, movefocus, d"

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
		"$mainMod, W, togglespecialworkspace, magic"
		"$mainMod SHIFT, W, movetoworkspace, special:magic"

		# Scroll through workspaces
		"$mainMod, mouse_down, workspace, e+1"
		"$mainMod, mouse_up, workspace, e-1"
      ];

      binde = [
		"$mainMod, F3, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
		"$mainMod, F2, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
      ];

      bindm = [
		"$mainMod, mouse:272, movewindow"
		"$mainMod, mouse:273, resizewindow"
      ];

      workspace = [
        "1,monitor:DP-3"
        "2,monitor:HDMI-A-1"
        "3,monitor:DP-3"
        "4,monitor:HDMI-A-1"
        "5,monitor:DP-3"
        "6,monitor:HDMI-A-1"
        "7,monitor:DP-3"
        "8,monitor:HDMI-A-1"
        "9,monitor:DP-3"
        "10,monitor:HDMI-A-1"
      ];

      misc = {
        vrr = "1";
      };

      experimental = {
        xx_color_management_v4 = "true";
      };
    };
  };

  gtk = {
    enable = true;
  };

  # external dots
  home.file = {
    
  };

  home.sessionVariables = {
    EDITOR = "neovim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "23.11"; # Do not change!!!
}
