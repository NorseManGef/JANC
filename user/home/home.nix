{ config, pkgs, inputs, ... }: 

{
  home.username = "norsemangef";
  home.homeDirectory = "/home/norsemangef";
  home.enableNixpkgsReleaseCheck = false;

  imports = [
    ./../userPackages.nix
    ./dunst.nix
    ./shell-settings.nix
    ./umbriel.nix
    ./waybar.nix
    ./textfox.nix
  ];

  gtk = {
    enable = true;
    #gtk4.theme = null;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "23.11"; # Do not change!!!
}
