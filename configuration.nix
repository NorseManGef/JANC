{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.hyprland.nixosModules.default
    ];
  
  #use the latest linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  networking.hostName = "nixos-desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  #hardware agnostic graphics configurations
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
