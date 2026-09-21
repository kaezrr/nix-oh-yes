{ pkgs, ... }:

{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 3 --keep-since 3d";
    flake = "/home/kaezr/.config/nixos";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  # LSP and formatter for working with nix
  environment.systemPackages = with pkgs; [
    nixfmt
    nixd
  ];

}
