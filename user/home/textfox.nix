{ inputs, pkgs, ... }:

{
  imports = [ inputs.textfox.homeManagerModules.default ];

  programs.firefox.enable = true;
  programs.firefox.profiles.textfox.extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [ 
    ublock-origin
    #sidebery
    sponsorblock
    multi-account-containers
    proton-pass
    vimium
  ];

  textfox = {
    enable = true;
    profile = "textfox";
    config = {
      background.color = "#282828";
    };
  };
}
