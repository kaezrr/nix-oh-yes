{ pkgs, inputs, ... }:

{
  programs.niri = {
    enable = true;
    useNautilus = true;
  };

  programs.noctalia.enable = true;

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  environment.systemPackages = with pkgs; [
    nautilus
    xwayland-satellite
    wl-clipboard
    kitty
    yazi
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default

    # Themeing
    nwg-look
    kdePackages.qt6ct
    dracula-icon-theme
    dracula-theme
    bibata-cursors
  ];

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk3";
    GSK_RENDERER = "gl";
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.iosevka
      ibm-plex
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Iosevka Nerd Font" ];
        sansSerif = [ "IBM Plex Sans" ];
        serif = [ "IBM Plex Serif" ];
      };
    };
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "greeter";
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
