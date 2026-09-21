{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    iputils
    wget
    fastfetch
    mangohud
  ];
}
