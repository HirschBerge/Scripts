{ pkgs, colors, ... }:
with colors; {
  programs.kitty = {
    enable = true;
    # settings = {
    # 	font_family = "Fira Code Regular Nerd Font Complete Mono";
    # 	italic_font = "auto";
    # 	bold_font = "auto";
    # 	bold_italic_font = "auto";
    # 	font_size = "10";
	  #   " enable_audio_bell" = "no";
	  #   background_opaciy = "0.75";
	  #   " background_tint" = "0.7";
	  #   " dim_opacity" = "0.75";
    # 	shell = "zsh";
    # };
    extraConfig=''
						font_family      Fira Code Regular Nerd Font Complete Mono
						bold_font        Fira Code Bold Nerd Font Complete
						italic_font      Fira Code Retina Nerd Font Complete
						bold_italic_font Fira Code SemiBold Nerd Font Complete
						symbol_map U+1F980 Noto Color Emoji
						 enable_audio_bell no
						background_opacity 0.75
						 background_tint 0.7
						 dim_opacity 0.75
						shell zsh
						map ctrl+shift+enter	launch	--cwd=current --type=os-window
    '';#I honestly have no clue why, but passing these options as settings {}; 
    	 #breaks opacity in my setup.... Could it be formatting?
	};
}