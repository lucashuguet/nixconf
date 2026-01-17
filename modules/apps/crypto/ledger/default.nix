{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [ unstable.ledger-live-desktop ];
  };

  # fix read+write permissions for ledger
  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", TAG+="uaccess", TAG+="udev-acl"
    KERNEL=="hidraw*", ATTRS{idVendor}=="2c97", MODE="0666"
  '';

  # KERNEL=="hidraw*", ATTRS{idVendor}=="2c97", MODE="0660", GROUP="uucp"
  users.users.${username} = {
    extraGroups = [ "uucp" ];
  };
}
