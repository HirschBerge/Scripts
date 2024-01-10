{config, pkgs, ...}:
let 
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  	themes = pkgs.callPackage  ./configs/themes.nix {};
in
{
	imports = [ 
    ./configs/firefox.nix 
    ./configs/zsh.nix 
    ./configs/hypr.nix 
    ./configs/kitty.nix
    ./configs/starship.nix 
    ./configs/wlogout.nix
    ];
	home.username = "hirschy";
	home.homeDirectory = "/home/hirschy";
	home.stateVersion = "23.05";
	programs.home-manager.enable = true;
	home.packages = with pkgs; [
		btop
        brightnessctl
		starship
		fzf
		bat
		axel
        jq
        fd
        lazygit
		xfce.thunar
		xfce.tumbler
		eza
		nerdfonts
		eww-wayland
		unzip
        rnnoise-plugin
		sxiv
        swaynotificationcenter# dunst# mako
        swaylock-effects
        swayidle
        wlogout
		betterdiscordctl
		nmap
		grc
		neofetch
        satty
		mangohud
		obsidian
		zathura
        xwaylandvideobridge
		sweet
		# libsForQt5.qtstyleplugin-kvantum
        aria
		ani-cli
	    zip
	    rtorrent
	    lutris
	    wineWowPackages.full
	    libnotify
        yt-dlp
	    ranger
	    gimp
	    p7zip
	    pavucontrol
	    autojump
	    youtube-music
	    steam
	    mpv
	    playerctl
	    discord
        pywal
	    wf-recorder
	];
	gtk = {
		enable = true;
		# theme.package = pkgs.sweet;
		# theme.name = "Sweet-Dark";
	    theme = {
	      name = "Catppuccin-Mocha-Compact-Pink-Dark";
	      package = pkgs.catppuccin-gtk.override {
	        accents = [ "pink" ];
	        size = "compact";
	        tweaks = [ "rimless" ];
	        variant = "mocha";
	      };
	    };
		# iconTheme = {
		# 	package = pkgs.catppuccin-papirus-folders.override {
		# 	  	flavor = "mocha";
		# 	   	accent = "mauve";
		# 	};
		# 	name = "Papirus-Dark";
		# };
    iconTheme = {
    	name = "candy-icons";
    	package = themes.candy-icons;
    	};
		cursorTheme = {
			package = pkgs.catppuccin-cursors.mochaMauve;
			name = "Catppuccin-Mocha-Mauve-Cursors";
		};
	};

	xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
		[General]
		theme=Sweet-Dark
	'';
  home.sessionVariables = {
    # QT_STYLE_OVERRIDE = "kvantum";
    GTK_USE_PORTAL = 1;
		eEDITOR = "nvim";    
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
	# programs.chromium = {
	# 	enable = true;
	# 	extensions = [
	# 		{ id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
	# 		{ id = "aapbdbdomjkkjkaonfhkkikfgjllcleb";} # Google Translate
	# 		{ id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # Dark Reader
	# 		{ id = "bmnlcjabgnpnenekpadlanbbkooimhnj";} # Honey
	# 		{ id = "hdokiejnpimakedhajhdlcegeplioahd";} # Last Pass
	# 		{ id = "ponfpcnoihfmfllpaingbgckeeldkhle";} # Enhancer for Youtube
	# 		{ id = "kbfnbcaeplbcioakkpcpgfkobkghlhen";} # Grammarly
	# 		{ id = "gebbhagfogifgggkldgodflihgfeippi";} # Return YouTube Dislike Button
 #            { id = "amaaokahonnfjjemodnpmeenfpnnbkco";} # Grepper
 #            { id = "mnjggcdmjocbbbhaepdhchncahnbgone";} # Sponsorblock
	# 	];
	# };
	# programs.brave = {
	# 	enable = true;
	# 	extensions = [
	# 		{ id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
	# 		{ id = "aapbdbdomjkkjkaonfhkkikfgjllcleb";} # Google Translate
	# 		{ id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # Dark Reader
	# 		{ id = "bmnlcjabgnpnenekpadlanbbkooimhnj";} # Honey
	# 		{ id = "hdokiejnpimakedhajhdlcegeplioahd";} # Last Pass
	# 		{ id = "ponfpcnoihfmfllpaingbgckeeldkhle";} # Enhancer for Youtube
	# 		{ id = "kbfnbcaeplbcioakkpcpgfkobkghlhen";} # Grammarly
	# 		{ id = "gebbhagfogifgggkldgodflihgfeippi";} # Return YouTube Dislike Button
 #            { id = "amaaokahonnfjjemodnpmeenfpnnbkco";} # Grepper
 #            { id = "mnjggcdmjocbbbhaepdhchncahnbgone";} # Sponsorblock
	# 	];
	# };
	
}

