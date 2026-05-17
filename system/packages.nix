{ pkgs, ... }:

{
    # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    polkit
    gparted
    dunst
    wlr-randr
    wl-clipboard
    hyprpicker
    swww
    wofi
    firefox
    tor-browser
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
    vesktop
    unzip
    qemu
    quickemu
    gimp
    i2c-tools
    usbutils
    udiskie
    musikcube
    nicotine-plus
    proton-vpn
    proton-authenticator
    networkmanagerapplet
    jdk17
    signal-desktop
    mpv
    sidequest
    wordgrinder
    libreoffice
    xdg-utils
    wget
    mangohud
    lact
    proton-pass
    vkquake
    grub2
    protonplus
    gh
    lmstudio
    llama-cpp-rocm
    rocmPackages.rocminfo

    sshfs

    brave


    ardour
    renoise
    decent-sampler
    lsp-plugins
    vital
    cardinal
    alsa-scarlett-gui
    alsa-utils
    pulseaudio
    crosspipe
  ];
}
