{ config, pkgs, ... }:
{
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
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;
}