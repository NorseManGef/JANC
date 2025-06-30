{ pkgs, ... }:

{
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting = true;

  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";

    sync.enable = true; 
  };
  
  environment.systemPackages = [ pkgs.nvtopPackages.full pkgs.brightnessctl ];
}
