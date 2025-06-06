{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hello
    zoxide
	  fzf
    atuin
    dunst
    btop
    onlyoffice-bin
    kdePackages.kdenlive
    heroic
    superTuxKart
    prismlauncher
    vintagestory
  ];
}
