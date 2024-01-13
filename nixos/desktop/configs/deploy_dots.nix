{pkgs, lib, config, ... }:
{  
  home.file."${config.home.homeDirectory}/.scripts" = {
    source = ../../../desktop/.scripts;
    recursive = true;
  };
  
  home.file."${config.home.homeDirectory}/.local/bin" = {
    source = ../../../desktop/bin;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/nvim" = {
    source = ../../../desktop/nvim;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/swaync" = {
    source = ../../../desktop/swaync;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/zsh" = {
    source = ../../../desktop/zsh;
    recursive = false;
  };
  home.file."${config.xdg.configHome}/rofi" = {
    source = ../../../desktop/rofi;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/eww" = {
    source = ../../../desktop/eww;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/ranger" = {
    source = ../../../desktop/ranger;
    recursive = true;
  };
  # home.file."${config.xdg.configHome}/" = {
  #   source = ../../../desktop/;
  #   recursive = true;
  # };
}
