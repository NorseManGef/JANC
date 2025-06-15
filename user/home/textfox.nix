{ inputs, pkgs, ... }:

{
  imports = [ inputs.textfox.homeManagerModules.default ];

  firefox.enable = true;
  firefox.extensions = with inputs.firefox-addons.packages.${pkgs.system}; [ ublock-origin ];

  textfox = {
    enable = true;
    profile = "textfox";
    config = {
      background.color = "#1d2021";
      displayHorizontalTabs = true;
    };
  };
}
