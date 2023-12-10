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
	imports = [ ./configs/firefox.nix ./configs/zsh.nix ./configs/hypr.nix ./configs/kitty.nix ./configs/starship.nix ];
	# imports = [./configs/zsh.nix ./configs/i3.nix ./configs/kitty.nix ./configs/sxhkd.nix ./configs/polybar.nix ./configs/starship.nix ]; #X Orgd
	home.username = "hirschy";
	home.homeDirectory = "/home/hirschy";
	home.stateVersion = "23.05";
	programs.home-manager.enable = true;
	home.packages = with pkgs; [
		btop
		starship
		fzf
		fd
        bat
        youtube-music
		axel
		# exa # Stable Channel
		eza # Unstable Channel
		playerctl
		xfce.thunar
		xfce.tumbler
		nerdfonts
        xwaylandvideobridge
		unzip
		rnnoise-plugin
		sxiv
		swaynotificationcenter# dunst# mako
        swaylock-effects
		swayidle
        jq
        betterdiscordctl
		nmap
		grc
		neofetch
		obsidian
		zathura
		sweet
		aria
        html-tidy
		ani-cli
		zip
        yuzu-mainline
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
		discord
		mpv
		wf-recorder
		eww-wayland
        mpvScripts.sponsorblock
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
    iconTheme = {
    	name = "candy-icons";
    	package = themes.candy-icons;
    	};
		# iconTheme = {
		# 	package = pkgs.catppuccin-papirus-folders.override {
		# 		flavor = "mocha";
		# 	 	accent = "mauve";
		# 	};
		# 	name = "Papirus-Dark";
		# };
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
 #            { id = "amaaokahonnfjjemodnpmeenfpnnbkco";} # Grepper
	# 		{ id = "gebbhagfogifgggkldgodflihgfeippi";} # Return YouTube Dislike Button
	# 		{ id = "mnjggcdmjocbbbhaepdhchncahnbgone";} # Sponsorblock
	# 	];
	# };
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
			{ id = "mnjggcdmjocbbbhaepdhchncahnbgone";} # Sponsorblock
		];
	};
	services.swayidle =
    let
      lockCommand = "timeout 600 ' $(${pkgs.swaylock-effects}/bin/swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color bb00cc --key-hl-color 880033 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --grace 2 --fade-in 0.2) '";
    in
    {
      enable = true;
      systemdTarget = "hyprland-session.target";
      timeouts =
        let
          dpmsCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms";
        in
        [
          {
            # timeout = 300;
            timeout = 5;
            command = lockCommand;
          }
          {
            # timeout = 600;
            timeout = 10;
            command = "${dpmsCommand} off";
            resumeCommand = "${dpmsCommand} on";
          }
        ];
      events = [
        {
          event = "before-sleep";
          command = lockCommand;
        }
        {
          event = "lock";
          command = lockCommand;
        }
        {
          event = "after-resume";
          command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms";
        }
      ];
    };
}

