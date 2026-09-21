{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  boot.loader.limine = {
    enable = true;
    efiSupport = true;
    extraEntries = ''
      /Windows 11
      protocol: efi
      path: uuid(d0dd6fba-cd26-4b6f-a98c-9dcc4ab034e3):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };

  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users."kaezr" = {
    isNormalUser = true;
    description = "kaezr";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  users.extraUsers."kaezr".shell = pkgs.fish;

  nixpkgs.config.allowUnfree = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
  };

  programs.noctalia.enable = true;

  environment.systemPackages = with pkgs; [
    iputils
    wget
    kitty
    chezmoi
    fastfetch
    git
    zoxide
    yazi
    eza
    firefox
    wl-clipboard
    nixd
    nixfmt
    fzf
    bat
    gcc
    tree-sitter
    lazygit
    xwayland-satellite
  ];

  programs.niri.enable = true;
  programs.fish.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 3 --keep-since 3d";
    flake = "/home/kaezr/.config/nixos";
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

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "26.05";

}
