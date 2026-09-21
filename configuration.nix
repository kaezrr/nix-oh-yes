{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
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
    yazi
    wl-clipboard
    nixd
    nixfmt
    fzf
    gcc
    tree-sitter
    xwayland-satellite
    mangohud
    cloudflare-warp
    vulkan-tools
    nautilus

    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default

    fishPlugins.pure
    fishPlugins.fzf-fish
    fishPlugins.autopair
    fishPlugins.bang-bang
  ];

  programs.git.enable = true;
  programs.lazygit.enable = true;
  programs.zoxide = {
    enable = true;
    flags = [ "--cmd cd" ];
  };

  programs.niri = {
    enable = true;
    useNautilus = true;
  };

  programs.fish = {
    enable = true;

    shellAliases =
      let
        eza = "${pkgs.eza}/bin/eza";
        bat = "${pkgs.bat}/bin/bat";
      in
      {
        ll = "${eza} -l --icons=auto --group-directories-first";
        la = "${eza} -lA --icons=auto --group-directories-first";
        cat = "${bat}";
      };

    interactiveShellInit = ''
      function fish_user_key_bindings
        bind \ey forward-word
        bind \cy forward-char
      end

      fish_config theme choose catppuccin-mocha

      set -g fish_greeting
      set -g fish_key_bindings fish_default_key_bindings
    '';
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 3 --keep-since 3d";
    flake = "/home/kaezr/.config/nixos";
  };

  services.cloudflare-warp.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    branch = "latest";

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      amdgpuBusId = "PCI:5@0:0:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

}
