# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in

{
  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  #sound.enable = false;
  #  systemd.services = {
  #   background = {
  #     wantedBy = [ "multi-user.target" ]; 
  #     after = [ "network.target" ];
  #     description = "Background changer.";
  #     enable = true;
  #     serviceConfig = {
  #       Type = "simple";
  #       User = "hirschy";
  #       ExecStartPost= "/run/current-system/sw/bin/sleep 15";
  #       ExecStart = ''/home/hirschy/.scripts/background/cron.sh /home/hirschy/Pictures/Sci-Fi'';         
  #       ExecStop = ''ps aux |rg "[b]ackground" | awk \'{ print $2 }\' | xargs kill '';
  #     };
  #   };
  #   remaps = {
  #     wantedBy = [ "multi-user.target" ]; 
  #     after = [ "network.target" ];
  #     description = "Keyboard remaps.";
  #     enable = true;
  #     serviceConfig = {
  #       Type = "simple";
  #       User = "hirschy";
  #       # ExecStartPost= "/run/current-system/sw/bin/sleep 15";
  #       ExecStart = ''/run/current-system/sw/bin/bash /home/hirschy/.local/bin/remaps'';         
  #       # ExecStop = ''ps aux |rg "[r]emaps" | awk \'{ print $2 }\' | xargs kill'';
  #     };
  #   };
  #   displaysetup = {
  #     wantedBy = [ "multi-user.target" ]; 
  #     after = [ "network.target" ];
  #     before = [ "getty.target" ];
  #     description = "Sets correct screen settings";
  #     enable = true;
  #     serviceConfig = {
  #       Type = "simple";
  #       User = "hirschy";
  #       ExecStart = ''/run/current-system/sw/bin/nvidia-settings --assign CurrentMetaMode="DP-2: nvidia-auto-select @2560x1080 +0+0 {ForceCompositionPipeline=On}, DP-0: nvidia-auto-select @2560x1080 +0+1080 {ForceCompositionPipeline=On}"; /run/current-system/sw/bin/xrandr --output DP-2 --mode 2560x1080 --rate 200 --pos 0x1080 --output DP-0 --mode 2560x1080 --rate 200 --pos 0x0'';         
  #       # ExecStop = ''ps aux |rg "[s]xhkd" | awk \'{ print $2 }\' | xargs kill '';
  #     };
  #   };
  # };


  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  imports =
    [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        <home-manager/nixos>
        ./8bitdo.nix
    ];

  environment.pathsToLink = [ "/libexec"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "yoitsu"; # Define your hostname.
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
  # services.xserver.windowManager.i3.package = pkgs.i3-gaps;
  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    
    desktopManager = {
     xterm.enable = false;
     };
    displayManager = {
      defaultSession = "none+i3";
      lightdm = {
        enable = true;
        background = /home/hirschy/Pictures/nier.jpg;
        };
      };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
        polybar
      ];
    };
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hirschy = {
    isNormalUser = true;
    description = "Hirschy";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.hirschy = import ./home.nix;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    brave
    git
    home-manager
    sublime4
    traceroute
    python311
    python311Packages.pip
    pavucontrol
    autojump
    discord
    spotify
    steam
    picom
    sweet
    mpv
    yt-dlp
    chromium
    ripgrep
    cmake
    lm_sensors
    zip
    lutris
    wineWowPackages.full
    gimp
    rtorrent
    ffmpeg
    aria
    p7zip
    pciutils
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
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
      ];
      groups = [ "wheel" ];
    }];
  };
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
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;

}
