{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-nvf.url = "github:nixos/nixpkgs/cad22e7d996aea55ecab064e84834289143e44a0";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "git+https://github.com/NotAShelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs-nvf";
    
    textfox.url = "github:adriankarlen/textfox";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix  = { 
      url = "github:musnix/musnix"; 
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-nvf, nvf, ... }@inputs: 
  let
    system = "x86_64-linux";
  in {
    packages.x86_64-linux.shittynvim = 
        (nvf.lib.neovimConfiguration {
          pkgs = nixpkgs-nvf.legacyPackages.x86_64-linux;
          modules = [
            ./system/nvf-configuration.nix
          ];
        }
      ).neovim;

    nixosConfigurations = {
      nixos-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit system;
          isDesktop = true;
        };
        modules = [
	        ({pkgs, ...}: {
	          environment.systemPackages = [self.packages.${pkgs.stdenv.system}.shittynvim];
	        })

          ./hosts/desktop/hardware-configuration.nix
          ./configuration.nix

          ./system/bootloader.nix
          ./system/greetd.nix
          ./system/locale.nix
          ./system/packages.nix
          ./system/stylix.nix

          ./system/audio/musnix.nix

          ./user/users.nix

          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
          inputs.musnix.nixosModules.musnix
        ];
      };

      nixos-laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit system;
          isDesktop = false;
        };
        modules = [
          ({pkgs, ...}: {
	          environment.systemPackages = [self.packages.${pkgs.stdenv.system}.shittynvim];
	        })

          ./hosts/laptop/hardware-configuration.nix
          ./configuration.nix

          ./system/bootloader.nix
          ./system/greetd.nix
          ./system/locale.nix
          ./system/packages.nix
          ./system/stylix.nix

          ./system/audio/musnix.nix

          ./user/users.nix

          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
          inputs.musnix.nixosModules.musnix
        ];
      };
    };
  };
}
