{ pkgs, ... }:
{
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
        gfxmodeEfi = "2560x1440";
        theme = pkgs.stdenvNoCC.mkDerivation {
          pname = "distro-grub-themes-nixos";
          version = "3.2";
          src = pkgs.fetchurl {
            url = "https://github.com/AdisonCavani/distro-grub-themes/releases/download/v3.2/nixos.tar";
            hash = "sha256-oW5DxujStieO0JsFI0BBl+4Xk9xe+8eNclkq6IGlIBY";
          };
          unpackPhase = "mkdir $out && tar -xvf $src -C $out";
        };
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
