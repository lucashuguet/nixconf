{ pkgs, ... }:
let
  vendorId = "1038";
  productId = "1836";
  topColor = "blue";
  middleColor = "white";
  bottomColor = "red";
  reactiveColor = "red";
  mappings = "button5=1; button4=6";
  cmd = "${pkgs.rivalcfg}/bin/rivalcfg -d off --top ${topColor} --middle ${middleColor} --bottom ${bottomColor} -a ${reactiveColor} -b 'buttons(${mappings})";
in {
  environment.systemPackages = with pkgs; [ rivalcfg ];
  services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="${vendorId}", ATTRS{idProduct}=="${productId}", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="${vendorId}", ATTRS{idProduct}=="${productId}", MODE="0666"
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="${vendorId}", ATTR{idProduct}=="${productId}", RUN+="${cmd}"
  '';
}
