{config, pkgs, ...}:

{
	imports = [ ./configs/zsh.nix ./configs/i3.nix ./configs/kitty.nix ./configs/sxhkd.nix ./configs/polybar.nix ./configs/starship.nix];
	home.username = "hirschy";
	home.homeDirectory = "/home/hirschy";
	home.stateVersion = "23.05";
	home.packages = with pkgs; [
		zsh
		btop
		i3-gaps
		rofi
		kitty
		starship
		fzf
        sxhkd
	    bat
	    xclip
	    axel
		ranger
    	xwallpaper
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
	    dunst
	    obsidian
	    zathura
	];
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

