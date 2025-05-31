{ inputs, config, pkgs, pkgs-unstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.sops-nix.nixosModules.sops
      inputs.hyprland.nixosModules.default
      ./bootloader.nix
      ./greetd.nix
      ./nvf-configuration.nix
    ];

  #enable KVM
  boot.kernelModules = [ "kvm-amd" ];
  
  #use the latest linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  #Themes!

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

  
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };

  # XDG Portals
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };

  # Security
  security = {
    rtkit.enable = true;
    pam.services.hyprlock = {};
    #sudo-rs.enable = true;
  };

  # Services
  services = {
    xserver = {
      enable = true;
      xkb = {
	layout = "us";
	variant = "";
      };
      excludePackages = [ pkgs.xterm pkgs.x11_ssh_askpass ];
      #displayManager.gdm = {
      # enable = true;
      # wayland = true;
      #};
    };
    libinput.enable = true;
    dbus.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    hardware = {
      openrgb = {
        enable = true;
        package = pkgs.openrgb-with-all-plugins;
      };
    };
    flatpak.enable = true;
    qemuGuest.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    devmon.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  boot.kernelParams = [ "acpi_enforce_resources=lax" ]; # for openrgb

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      xwayland.enable = true;
    };
    waybar = {
      enable = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    ssh.startAgent = true;
    adb.enable = true;
    steam = {
      enable = true;
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    alvr = {
      enable = true;
      openFirewall = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    nix-ld.enable = true;
    virt-manager.enable = true;
    dconf.enable = true;
    nm-applet.enable = true;
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
    };
  };

  fonts.packages = with pkgs; [
    ipafont
    migu
    vistafonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    garamond-libre
    corefonts
  ];

  fonts.fontDir.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.norsemangef = {
    isNormalUser = true;
    description = "norsemangef";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "libvirtd" ];
    packages = with pkgs; [
      sidequest
      heroic
      superTuxKart
      prismlauncher
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs pkgs-unstable; };
    users = {
      "norsemangef" = import ./home.nix;
    };
    sharedModules = [{
      stylix.targets.waybar.enable = false;
      stylix.targets.hyprland.enable = false;
      stylix.targets.vscode.enable = false;
      stylix.targets.mako.enable = false;
    }];
    backupFileExtension = "backup";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  home-manager.useGlobalPkgs = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
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
    nvtopPackages.amd
  ])
  ++( with pkgs-unstable; [
    floorp
    proton-pass
    vkquake
  ]);

  #enable LACT for AMD GPU
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  nix.gc = {
    dates = "daily";
    options = "--delete-older-than 7d";
    automatic = true;
  };

  nix.optimise = {
    dates = ["daily"];
    automatic = true;
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
