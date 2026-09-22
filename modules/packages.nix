{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    iputils
    wget
    fastfetch
    mangohud
    imv
    mpv
    obs-studio
    just
  ];
}
