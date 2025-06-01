{ ... }:

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
        nswitch = "sudo nixos-rebuild switch --flake ~/nixos/#nixos";
        nswitch-upgrade = "cd ~/nixos && sudo nix flake update && sudo nixos-rebuild switch --upgrade --flake ~/nixos/#nixos";
		    ntest = "sudo nixos-rebuild test --flake ~/nixos/#nixos";
		    nboot = "sudo nixos-rebuild boot --flake ~/nixos/#nixos";
		    fetch = "fastfetch";
        edflake = "cd ~/nixos/ && nvim flake.nix";
        svim = "sudo -E -s nvim";
        winboot = "grub-reboot \"Windows Boot Manager (on /dev/nvme1n1p1)\"";
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
