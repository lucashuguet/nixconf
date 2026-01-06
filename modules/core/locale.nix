let
  layout = "fr";
  variant = "azerty";
  locale = "en_US.UTF-8";
  extraLocale = "fr_FR.UTF-8";
in {
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = extraLocale;
    LC_IDENTIFICATION = extraLocale;
    LC_MEASUREMENT = extraLocale;
    LC_MONETARY = extraLocale;
    LC_NAME = extraLocale;
    LC_NUMERIC = extraLocale;
    LC_PAPER = extraLocale;
    LC_TELEPHONE = extraLocale;
    LC_TIME = extraLocale;
  };

  console.keyMap = layout;

  services.xserver.xkb = {
    inherit layout variant;
  };

  environment.variables = {
    XKB_DEFAULT_LAYOUT = layout;
    XKB_DEFAULT_VARIANT = variant;
  };
}
