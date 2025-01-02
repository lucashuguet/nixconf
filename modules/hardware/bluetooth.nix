{
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  hardware.bluetooth.settings = {
    General = {
      Name = "Computer";
      ControllerMode = "dual";
      FastConnectable = "true";
      Experimental = "true";
      Enable = "Source,Sink,Media,Socket";
    };
    Policy = {
      AutoEnable = "true";
    };
  };
}
