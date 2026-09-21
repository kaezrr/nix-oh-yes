{ pkgs, ... }:

{
  # Limine bootloader with shitdows dualboot.
  # That uuid path is hardware dependent, don't use it blindly.
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

  # Use the latest linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
