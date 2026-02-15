{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [ unstable.ledger-live-desktop ];
  };

  hardware.ledger.enable = true;
}
