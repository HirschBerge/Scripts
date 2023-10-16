# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  themes = pkgs.callPackage  ./configs/sddm-theme.nix {};
in

{
  imports =
    [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        <home-manager/nixos>
        ./8bitdo.nix
        ./wayland.nix
        ./configs/gaming.nix 
    ];
    nixpkgs.config.permittedInsecurePackages = [
      "openssl-1.1.1w"
    ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  systemd.services.remaps = {
    description = "...";
    # serviceConfig.PassEnvironment = "DISPLAY";
    script = ''
      /run/wrappers/bin/sudo /home/hirschy/.local/bin/xremap --watch /home/hirschy/my-dotfiles/xremap_config.yml
    '';
    wantedBy = [ "multi-user.target" ]; # starts after login
  };
  security.sudo = {
    enable = true;
    extraRules = [{
      commands = [
        {
          command = "${pkgs.systemd}/bin/systemctl suspend";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/reboot";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/poweroff";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.sublime4}/bin/subl";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.neovim}/bin/nvim";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/systemctl";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/nix-channel";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/home/hirschy/.local/bin/xremap";
          options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }];
  };
  networking.hostName = "hyprtest"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
   services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
   services.xserver.displayManager.sddm = {
      enable = true;
      enableHidpi = true;
      theme = "abstractguts-sddm-theme";
    };
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.hirschy = import ./home.nix;
  };
  programs.zsh.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hirschy = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Hirschy";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];
  environment.systemPackages = with pkgs; [
      kitty
      neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      gcc
      wget
      git
      home-manager
      sublime4
      traceroute
      python311
      python311Packages.pip
      chromium
      ripgrep
      cmake
      lm_sensors
      ffmpeg
      pciutils
      themes.abstractguts-sddm-theme
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # XDG portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";    
    };
  };
  # List services that you want to enable:
  services.dbus.packages = [
    pkgs.dbus.out
    config.system.path
  ];
  services.cron = {
    enable = true;
    systemCronJobs = [
      "* * * * *         hirschy    date >> /home/hirschy/.cache/test.log"
      "*/30 * * * *      hirschy    /home/hirschy/.scripts/.venv/bin/python3 /home/hirschy/.scripts/manga_update.py"
    ];
  };
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
  system.stateVersion = "23.05"; # Did you read the comment?

}
