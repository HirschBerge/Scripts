{pkgs, lib, ... }:
{
	home.packages = with pkgs; [
		wl-clipboard
		grim
		slurp
    	swww
    	rofi-wayland
	    waybar
	];
  programs.hyprland = {
    enable = true;
    # No longer exists as it is not necessary.
    # enableNvidiaPatches = true;
    xwayland.enable = true;
    home.file."${config.xdg.configHome}/hypr/" = {
      source = ../hypr;
      recursive = true;
    };
  };
}
