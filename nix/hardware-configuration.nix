# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
        (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelParams = [ "mem_sleep_default=deep" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/4678bd33-996c-40b1-a579-775642652aaa";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-35ec205b-f247-4448-bfd0-d76c81849adf".device = "/dev/disk/by-uuid/35ec205b-f247-4448-bfd0-d76c81849adf";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/BE31-E21A";
      fsType = "vfat";
    };

  swapDevices = [ ];

  sound.enable = true;

  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand";
  };

  hardware.video.hidpi.enable = lib.mkDefault true;
  # throttling
  #services.throttled.enable = lib.mkDefault true;
  # other
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;

  # CPU
  #hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.opengl.extraPackages = with pkgs; [
    mesa_drivers
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
    intel-media-driver
  ];
}
