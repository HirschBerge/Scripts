{config, pkgs, ...}:

{
	imports = [ ./configs/zsh.nix ./configs/i3.nix ./configs/kitty.nix ./configs/sxhkd.nix ./configs/polybar.nix ./configs/starship.nix ];
	home.username = "hirschy";
	home.homeDirectory = "/home/hirschy";
	home.stateVersion = "23.05";
	programs.home-manager.enable =true;
	home.sessionVariables = {
		EDITOR = "nvim";
	};
	home.packages = with pkgs; [
		zsh
		btop
		starship
		fzf
    	sxhkd
	  	bat
	  	wl-clipboard
	  	axel
		sxhkd
    	exa
	    nerdfonts
	  	unzip
	  	sxiv
	 	maim
	  	betterdiscordctl
	  	xcape
	  	xorg.xmodmap
	  	xdotool
	  	nmap
	  	grc
	  	i3lock-fancy-rapid
	  	neofetch
	  	mangohud
	  	obsidian
	  	zathura
	  	grim
    	slurp
		sweet
		libsForQt5.qtstyleplugin-kvantum
	];
	gtk.enable = true;
	gtk.iconTheme.package = pkgs.papirus-icon-theme;
	gtk.iconTheme.name = "Papirus-Dark";

	gtk.theme.package = pkgs.sweet;
	gtk.theme.name = "Sweet-Dark";

	xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
		[General]
		theme=MateriaDark
	'';

  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "kvantum";
    GTK_USE_PORTAL = 1;
  };
	programs.git = {
		enable = true;
		userName = "HirschBerge";
		userEmail = "hskirkwo@geneva.edu";
	};
	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
	};
	programs.chromium = {
		enable = true;
		extensions = [
			{ id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
			{ id = "aapbdbdomjkkjkaonfhkkikfgjllcleb";} # Google Translate
			{ id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # Dark Reader
			{ id = "bmnlcjabgnpnenekpadlanbbkooimhnj";} # Honey
			{ id = "hdokiejnpimakedhajhdlcegeplioahd";} # Last Pass
			{ id = "ponfpcnoihfmfllpaingbgckeeldkhle";} # Enhancer for Youtube
			{ id = "kbfnbcaeplbcioakkpcpgfkobkghlhen";} # Grammarly
			{ id = "gebbhagfogifgggkldgodflihgfeippi";} # Return YouTube Dislike Button
            { id = "amaaokahonnfjjemodnpmeenfpnnbkco";} # Grepper
		];
	};
	programs.brave = {
		enable = true;
		extensions = [
			{ id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
			{ id = "aapbdbdomjkkjkaonfhkkikfgjllcleb";} # Google Translate
			{ id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # Dark Reader
			{ id = "bmnlcjabgnpnenekpadlanbbkooimhnj";} # Honey
			{ id = "hdokiejnpimakedhajhdlcegeplioahd";} # Last Pass
			{ id = "ponfpcnoihfmfllpaingbgckeeldkhle";} # Enhancer for Youtube
			{ id = "kbfnbcaeplbcioakkpcpgfkobkghlhen";} # Grammarly
			{ id = "gebbhagfogifgggkldgodflihgfeippi";} # Return YouTube Dislike Button
            { id = "amaaokahonnfjjemodnpmeenfpnnbkco";} # Grepper
		];
	};
	
}

