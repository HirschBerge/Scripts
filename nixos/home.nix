{config, pkgs, ...}:
       
let 
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
in
{
	imports = [ ./configs/zsh.nix ./configs/hypr.nix ./configs/kitty.nix ./configs/starship.nix ];
	# imports = [./configs/zsh.nix ./configs/i3.nix ./configs/kitty.nix ./configs/sxhkd.nix ./configs/polybar.nix ./configs/starship.nix ]; #X Orgd
	home.username = "hirschy";
	home.homeDirectory = "/home/hirschy";
	home.stateVersion = "23.05";
	programs.home-manager.enable = true;
	home.packages = with pkgs; [
		btop
		starship
		fzf
		bat
		axel
		# exa # Stable Channel
		eza # Unstable Channel
		playerctl
		xfce.thunar
		nerdfonts
		unzip
		rnnoise-plugin
		sxiv
		swaynotificationcenter# dunst# mako
		betterdiscordctl
		nmap
		grc
		neofetch
		obsidian
		zathura
		sweet
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
		discord
		spotify
		mpv
		wf-recorder
		eww-wayland
	];
	gtk = {
		enable = true;
		# theme.package = pkgs.sweet;
		# theme.name = "Sweet-Dark";
    theme = {
      name = "Catppuccin-Macchiato-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = "macchiato";
      };
    };
		iconTheme = {
				package = pkgs.catppuccin-papirus-folders.override {
			    flavor = "macchiato";
			    accent = "mauve";
			  };
				name = "Papirus-Dark";
		};
			cursorTheme = {
				package = pkgs.catppuccin-cursors.macchiatoMauve;
				name = "Catppuccin-Macchiato-Mauve";
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

