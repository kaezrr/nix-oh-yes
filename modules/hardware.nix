{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.vulkan-tools ];

  hardware.bluetooth.enable = true;
  hardware.keyboard.qmk.enable = true;

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
