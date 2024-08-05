{ pkgs, lib, config, inputs, ... }:

let
  pkgs-unstable = inputs.unstable.legacyPackages.${pkgs.system};
  pkgs-zathura = inputs.zathura.legacyPackages.${pkgs.system};
in 
{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot = {
    kernelParams = [ "video=1920x1080@60" "quiet" ];
    initrd.kernelModules = [ "nvidia" ];
    loader.efi.canTouchEfiVariables = true;
    extraModprobeConfig = ''
      blacklist nouveau
      options snd-hda-intel model=asus-zenbook
      options nvidia-drm modeset=1
    '';

    loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      configurationLimit = 10;
    };
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  console.keyMap = "fr";

  sound.enable = true;
  security.rtkit.enable = true;

  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [vaapiVdpau];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
	      enable = true;
        enableOffloadCmd =  true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.xserver = {
    enable = true;
    libinput.enable = true;
    videoDrivers = [ "nvidia" ];
    desktopManager.gnome.enable = true;
    excludePackages = [ pkgs.xterm ];
    xkb = {
      layout = "fr";
      variant = "azerty";
    };
  };

  services.xserver.displayManager.sddm = {
    enable = true;
    settings = {
      Theme = {
        CursorTheme = "capitaine-cursors";
        CursorSize = 32;
      };
    };
    sugarCandyNix = {
      enable = true;
      settings = {
        Background = lib.cleanSource ./assets/background.png;
        FormPosition = "left";
        MainColor = "#99d2e8";
        AccentColor = "#9169B0";
        BackgroundColor = "#99d2e8";
      };
    };
  };

  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1080 --rate 60
  '';

  services.asusd.enable = true;
  services.auto-cpufreq.enable = true;
  services.blueman.enable = true;

  services.gnome.core-utilities.enable = false;
  services.gnome.rygel.enable = false;

  services.ollama.enable = true;
  services.ollama.acceleration = "cuda";

  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ brlaser ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  
  services.pcscd.enable = true;

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="uucp"
  ''; # ledger read+write permissions for uucp group

  users.users.astrogoat = {
    isNormalUser = true;
    description = "AstroGoat";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "libvirtd" "uucp" "docker" ];
    shell = pkgs.fish;
  };

  environment.variables = {
    XCURSOR_SIZE = "32";
    EDITOR = "nvim";
    # PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = (with pkgs; [
    aria
    asusctl
    auto-cpufreq
    bat
    blueman
    capitaine-cursors
    chromium
    docker
    docker-compose
    dunst
    emacs
    espeak
    exegol
    eza
    fastfetch
    ffmpeg
    fish
    gcc
    gimp
    git
    gnupg
    grim slurp # screenshot tools
    home-manager
    hyprland
    imagemagick
    imv
    jdk8 jdk17 jdk21
    ledger-live-desktop
    libnotify
    libreoffice
    librewolf
    light
    lutris
    mangal
    mpd mpc-cli ncmpcpp
    mpv
    ncdu
    neovim
    nodejs
    ollama
    # openssl
    p7zip
    pavucontrol
    pcmanfm
    pinentry pinentry-gtk2
    # pkg-config
    prismlauncher
    pywal # themes from wallpapers
    qutebrowser
    rofi-wayland
    rustup rust-analyzer
    starship
    steam
    swww
    sxiv
    thunderbird
    vimv
    virt-manager virtiofsd
    waybar
    wine
    wl-clipboard
    wlr-randr
    yt-dlp

    (pass.withExtensions (ext: with ext; [pass-otp]))
    (python3.withPackages (ps: with ps; [numpy python-lsp-server]))

    (callPackage ./pkgs/bpytop.nix {})
  ])

  ++

  (with pkgs-zathura; [ zathura ]) # zathura 5.2 (fix cbz being cropped)

  ++

  (with pkgs-unstable; [ alacritty nh ]);

  fonts.packages = (with pkgs-unstable; [
    (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ])

  ++

  (with pkgs; [ noto-fonts noto-fonts-cjk noto-fonts-emoji ]);

  fonts.fontconfig.defaultFonts = {
    serif = [ "Noto Serif" ];
    sansSerif = [ "Noto Sans" ];
    monospace = [ "FantasqueSansM Nerd Font" ];
  };

  programs = {
    command-not-found.enable = false;
    fish.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gtk2;
      enableSSHSupport = true;
    };
    hyprland.enable = true;
    light.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    virt-manager.enable = true;
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.docker.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05";
}
