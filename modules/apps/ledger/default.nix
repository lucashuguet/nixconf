{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [ unstable.ledger-live-desktop ];
  };

  # fix read+write permissions for ledger
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="uucp"
  '';

  users.users.${username} = {
    extraGroups = [ "uucp" ];
  };
}
