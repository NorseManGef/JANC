{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hello
    zoxide
	  fzf
    atuin
    dunst
    btop
    onlyoffice-desktopeditors
    kdePackages.kdenlive
    heroic
    superTuxKart
    prismlauncher
    vintagestory
    lmstudio
    rpcs3
    aseprite
    krita
  ];
}
