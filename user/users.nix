{ inputs, isDesktop, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.norsemangef = {
    isNormalUser = true;
    description = "norsemangef";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "libvirtd" ];
  };

  home-manager = {
    extraSpecialArgs = { 
      inherit inputs; 
      inherit isDesktop; 
    };
    users = {
      "norsemangef" = import ./home/home.nix;
    };
    backupFileExtension = "backup";
    useGlobalPkgs = true;
  };
}
