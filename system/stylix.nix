{ pkgs, ... }:

{
  stylix = {
    override = {
      base00 = "#1d2021"; # ----
      base01 = "#3c3836"; # ---
      base02 = "#504945"; # --
      base03 = "#665c54"; # -
      base04 = "#bdae93"; # +
      base05 = "#d5c4a1"; # ++
      base06 = "#ebdbb2"; # +++
      base07 = "#fbf1c7"; # ++++
      base08 = "#fb4934"; # red
      base09 = "#fe8019"; # orange
      base0A = "#fabd2f"; # yellow
      base0B = "#b8bb26"; # green
      base0C = "#8ec07c"; # aqua/cyan
      base0D = "#83a598"; # blue
      base0E = "#d3869b"; # purple
      base0F = "#d65d0e"; # brown
    };
    image = ./pbmam94nqapc1.png;
    enable = true;
    autoEnable = true;

    targets = {
      grub.enable = false;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.blex-mono;
        name = "BlexMono Nerd Font Mono";
      };

      sizes = {
	    applications = 12;
	    terminal = 15;
	    popups = 10;
      };
    };

    opacity = {
      applications = 1.0;
      terminal = 1.0;
      popups = 1.0;
    };

    polarity = "dark";
  };

  home-manager.sharedModules = [{
      stylix.targets.waybar.enable = false;
      stylix.targets.hyprland.enable = false;
      stylix.targets.vscode.enable = false;
      stylix.targets.mako.enable = false;
    }];
}
