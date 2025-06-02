{ pkgs, ... }:

{
  hardware.nvidia.open = true;

  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";

    offload.enable = true;
    offload.enableOffloadCmd = true;
  };
  
  environment.systemPackages = [ pkgs.nvtopPackages.full ];
}
