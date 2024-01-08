{
  description = "My Favorite NixOS flake!";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    firefox-addons = { url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: 
    let 
      system = "x86_64-linux"; 
      pkgs = import nixpkgs { 
        system = "x86_64-linux"; 
        config.allowUnfree = true; 
      };
    in
    {
    nixosConfigurations = {
      yoitsu = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;
          # inherit inputs;
        };
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.hirschy = import ./nixos/home.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs; 
              inherit system;
            };
          }
        ];
      };
    };
  };
}

