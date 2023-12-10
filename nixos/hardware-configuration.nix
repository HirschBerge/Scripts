# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  
# NVIDIA Drivers are Unfree
  #nixpkgs.config.allowUnfree = pkgs.lib.mkForce true;
   nixpkgs.config.allowUnfreePredicate = pkg:
   builtins.elem (lib.getName pkg) [
     "nvidia-x11"
   ];

  services.xserver.videoDrivers = [ "nvidia" ];

# boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];


fileSystems."/mnt/storage" =
  { device = "/dev/disk/by-uuid/ef223ecb-2d19-40a7-a458-9ec536d9a9a2";
    fsType = "btrfs";
  };
fileSystems."/mnt/NAS" = {
    device = "srv-prod-nas.home.hirschykiss.net:/mnt/Main Storage/Hirschy/hirschy";
    fsType = "nfs";
  };
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/4b58a53c-d9bb-457b-992f-c7310b282c2e";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/C286-40B4";
      fsType = "vfat";
    };
  hardware = {
    opengl.enable = true;
    opengl.driSupport = true;
    opengl.driSupport32Bit = true;
    nvidia = {
      modesetting.enable = true;
      # open = false;
      # powerManagement.enabled = true;
      open = true;
      nvidiaSettings = true;
      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp6s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp5s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
