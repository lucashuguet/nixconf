{ pkgs, username, ...}:
{
  users.users.${username} = {
    extraGroups = [ "libvirtd" ];
  };
  
  environment.systemPackages = with pkgs; [
    virt-manager virtiofsd
  ];

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
