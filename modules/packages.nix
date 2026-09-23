{ pkgs, ... }:

{
  programs.moonlight-qt.enable = true;

  environment.systemPackages = with pkgs; [
    iputils
    wget
    fastfetch
    mangohud
    imv
    mpv
    obs-studio
    just
    dua
    duf
  ];
}
