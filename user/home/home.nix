{ config, pkgs, inputs, ... }: 

{
  home.username = "norsemangef";
  home.homeDirectory = "/home/norsemangef";
  home.enableNixpkgsReleaseCheck = false;

  imports = [
    ./../userPackages.nix
    ./dunst.nix
    ./shell-settings.nix
  ];

  gtk = {
    enable = true;
  };

  home.sessionVariables = {
    EDITOR = "neovim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "23.11"; # Do not change!!!
}
