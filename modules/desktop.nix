{ pkgs, inputs, ... }:

{
  programs.niri = {
    enable = true;
  };

  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
    systemd = {
      enable = true;
      target = "niri.service";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  xdg.mime.defaultApplications = {
    "application/pdf" = "zen-beta.desktop";
  };

  environment.systemPackages = with pkgs; [
    ripdrag
    xwayland-satellite
    wl-clipboard
    kitty
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
    MANPAGER = "nvim +Man!";
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

  services = {
    displayManager.ly = {
      enable = true;
      settings.session_log = ".local/state/ly-session.log";
    };

    udisks2.enable = true;
    gvfs.enable = true;
  };
}
