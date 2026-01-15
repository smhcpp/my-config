{ ... }: {
  services.kanata = {
    enable = true;
    keyboards.main-keyboard = {
      devices = [ "/dev/input/by-path/pci-0000:01:00.0-usb-0:10:1.0-event-kbd" ];
      configFile = /home/mortimertz/.config/kanata/config.kbd;
    };
  };
  
  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
  '';
}
