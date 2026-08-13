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
    heroic
    prismlauncher
    vintagestory
    rpcs3
    aseprite
    krita
    lutris

    bisq2
    eigenwallet
    monero-gui
    electrum
  ];
}
