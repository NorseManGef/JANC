{
  description = "Nixos config flake";

  inputs = rec {
    nixpkg.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    stylix.url = "github:danth/stylix/release-24.05";

    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, ... }@inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      nixos-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit system;
          isDesktop = true;
        };
        modules = [
          ./hosts/desktop/hardware-configuration.nix
          ./configuration.nix

          ./system/bootloader.nix
          ./system/greetd.nix
          ./system/locale.nix
          ./system/nvf-configuration.nix
          ./system/packages.nix
          ./system/stylix.nix

          ./user/users.nix

          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
          inputs.nvf.nixosModules.default
        ];
      };
    };

    nixos-laptop = nixpkgs.lib.nixosSystem {
      specialArgs = {
          inherit inputs;
          inherit system;
          isLaptop = true;
      };
      modules = [
        ./hosts/laptop/hardware-configuration.nix
        ./configuration.nix

        ./system/bootloader.nix
        ./system/greetd.nix
        ./system/locale.nix
        ./system/nvf-configuration.nix
        ./system/packages.nix
        ./system/stylix.nix

        ./user/users.nix

        inputs.home-manager.nixosModules.default
        inputs.stylix.nixosModules.stylix
        inputs.nvf.nixosModules.default
      ];
    };
  };
}
