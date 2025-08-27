{ ... }:

{
  systemd.services.disablePimax = {
    enable = true;
    description = "disable pimax";
    serviceConfig.Type = "oneshot";
    script = ''
      sleep 2
      echo '1-3.2.7' | tee /sys/bus/usb/drivers/usb/unbind
    '';
    wantedBy = [ "graphical.target" "multi-user.target" "default.target" ];
  };
}
