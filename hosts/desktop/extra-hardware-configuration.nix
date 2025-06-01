{ config, lib, pkgs, ... }:

{
  #enable KVM for amd
  boot.kernelModules = [ "kvm-amd" ];

  #enable LACT for AMD GPU
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];
}
