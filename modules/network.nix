{ pkgs, ... }:

{
  networking.networkmanager.enable = true;
  services.cloudflare-warp.enable = true;

  environment.systemPackages = [ pkgs.cloudflare-warp ];
}
