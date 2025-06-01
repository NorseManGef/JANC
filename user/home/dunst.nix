{ ... }:

{
  services = {
    dunst = {
      enable = true;
      waylandDisplay = "1";
      settings = {
        global = {
          width = 300;
          height = 300;
          offset = "30x50";
          origin = "top-right";
          #font = "HeavyData Nerd Font";
          corner_radius = 300;
          corners = "all";
        };
      };
    };
  };
}
