{ isDesktop, ... }:

{
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        nswitch = if isDesktop then "sudo nixos-rebuild switch --flake ~/nixos/#nixos-desktop" else "sudo nixos-rebuild switch --flake ~/nixos/#nixos-laptop";
        nswitch-upgrade = if isDesktop then "cd ~/nixos && sudo nix flake update && sudo nixos-rebuild switch --flake ~/nixos/#nixos-desktop" else "cd ~/nixos && sudo nix flake update && sudo nixos-rebuild switch --flake ~/nixos/#nixos-laptop";
		    ntest = if isDesktop then "sudo nixos-rebuild test --flake ~/nixos/#nixos-desktop" else "sudo nixos-rebuild test --flake ~/nixos/#nixos-laptop";
		    nboot = if isDesktop then "sudo nixos-rebuild boot --flake ~/nixos/#nixos-desktop" else "sudo nixos-rebuild boot --flake ~/nixos/#nixos-laptop";
		    fetch = "fastfetch";
        edflake = "cd ~/nixos/ && nvim flake.nix";
        svim = "sudo -E -s nvim";
        winboot = if isDesktop then "sudo grub-reboot \"Windows Boot Manager (on /dev/nvme1n1p1)\" && reboot" else "echo \"You're on your laptop silly, there's now winblows here\"";
      };
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
    atuin = {
      enable = true;
      enableBashIntegration = true;
      settings = {
          enter_accept = false;
      };
    };
    alacritty.enable = true;
  };
}
