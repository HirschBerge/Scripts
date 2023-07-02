{config, pkgs, ...}:

{
	imports = [ ./configs/zsh.nix ./configs/starship.nix];
	home.username = "hirschy";
	home.homeDirectory = "/home/hirschy";
	home.stateVersion = "23.05";
	home.packages = with pkgs; [
		zsh
		htop
		i3
		rofi
		kitty
		starship
		fzf
	];
	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
	};
}

