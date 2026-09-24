{
  config,
  inputs,
  pkgs,
  ...
}:

{
  users.users.kaezr = {
    isNormalUser = true;
    description = "kaezr";
    shell = pkgs.fish;
    home = "/home/kaezr";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  hjem.extraModules = [
    inputs.hjem-impure.hjemModules.default
  ];

  hjem.users.kaezr = {
    clobberFiles = true;
    user = "kaezr";

    impure = {
      enable = true;
      dotsDir = "${../dotfiles}";
      dotsDirImpure = "/home/kaezr/.config/nixos/dotfiles";
    };

    xdg.config.files =
      let
        dots = config.hjem.users.kaezr.impure.dotsDir;
      in
      {
        "kitty".source = dots + "/kitty";
        "fastfetch".source = dots + "/fastfetch";
        "noctalia".source = dots + "/noctalia";
        "niri".source = dots + "/niri";
      };

    files."Pictures/wallpapers".source = ../wallpapers;
  };
}
