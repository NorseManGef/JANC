{ config, pkgs, inputs, ... }: 

{
  home.username = "norsemangef";
  home.homeDirectory = "/home/norsemangef";
  home.enableNixpkgsReleaseCheck = false;

  imports = [
    ./../userPackages.nix
    ./dunst.nix
    ./shell-settings.nix
    ./waybar.nix
    ./hyprland.nix
    ./textfox.nix
  ];

  gtk = {
    enable = true;
  };

  programs.iamb = {
    enable = true;
    settings = {
      profiles.user.user_id = "@norsemangef:excd.com";
      profiles.user.url = "https://matrix.excd.com";
      notifications.enabled = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "neovim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "23.11"; # Do not change!!!
}
