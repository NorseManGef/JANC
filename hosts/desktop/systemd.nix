{ ... }:

{
  systemd.user.services.disablePimax = {
    description = "disable pimax";
    script = ''
      echo '1-3.2.7' | tee /sys/bus/usb/drivers/usb/unbind
    '';
    wantedBy = [ "multi-user.target" ];
  };
}
