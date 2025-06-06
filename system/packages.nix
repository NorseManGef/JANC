{ pkgs, ... }:

{
    # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    polkit
    polkit_gnome
    gparted
    neovim
    alacritty
    dunst
    wlr-randr
    wl-clipboard
    hyprpicker
    swww
    wofi
    firefox-wayland
    qt5.qtwayland
    qt6.qmake
    qt6.qtwayland
    adwaita-qt
    adwaita-qt6
    pavucontrol
    git
    hyprlock
    fastfetch
    wine
    wine-wayland
    hyprshot
    protontricks
    lutris
    vesktop
    unzip
    qemu
    quickemu
    gimp
    i2c-tools
    sops
    bottles
    usbutils
    udiskie
    musikcube
    nicotine-plus
    protonvpn-gui
    networkmanagerapplet
    jdk17
    signal-desktop-bin
    mov-cli
    mpv
    sidequest
    ungoogled-chromium
    wordgrinder
    libreoffice
    xdg-utils
    wget
    mangohud
    brave
    git-credential-manager
    sidequest
    lact
    floorp
    proton-pass
    vkquake
    grub2
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-7.0.20"
  ];
}
