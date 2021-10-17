# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub.configurationLimit = 3;
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
     firefox
     sublime4
     fractal
     neochat
     renderdoc
     alacritty
     git
     file
     steam-run-native
     kwallet-pam
     plasma5Packages.kwallet
     plasma5Packages.kmail
  ];

  security.pam.services.sddm.enableKwallet = true;

  networking.hostName = "Theseus";
  # networking.wireless.enable = true;
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";
  time.hardwareClockInLocalTime = true; # needed for Windows compat

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # SERVICES

  services.thermald.enable = true;
  services.tlp = {
    enable = false;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC="performance";
      CPU_SCALING_GOVERNOR_ON_BAT="powersave";
      START_CHARGE_THRESH_BAT1=75;
      STOP_CHARGE_THRESH_BAT1=80;
    };
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    #videoDrivers = [ "intel" ]; # causes windows to jump around
    libinput.enable = true;
    displayManager = {
      sddm.enable = true; # default is lightDM
      autoLogin.enable = true;
      autoLogin.user = "kvark";
    };
    desktopManager.plasma5.enable = true;
    #useGlamor = true;
    #layout = "us";
    #xkbOptions = "eurosign:e";
  };
  
  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  # Enable fingerprint support
  services.fprintd.enable = true;

  # Limit journal size
  services.journald.extraConfig = ''
    SystemMaxUse=50M
  '';

  # USER

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kvark = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

