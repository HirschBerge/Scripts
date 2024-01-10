{
  description = "My Favorite NixOS flake!";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
         url = "github:nix-community/home-manager";
         inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/nur";
  };


  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    stateVersion = "23.05";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        inputs.nur.overlay
      ];
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
    username = "hirschy";
    hostname = "yoitsu";
    l_hostname = "shirahebi";
    system = "x86_64-linux";
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      ${hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs username self stateVersion hostname;};
        # > Our main nixos configuration file <
        modules = [./nixos/desktop/configuration.nix];
      };
      ${l_hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs username self stateVersion l_hostname;};
        # > Our main nixos configuration file <
        modules = [./nixos/desktop/configuration.nix];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;# > Our main home-manager configuration file <
        modules = [./nixos/desktop/home.nix];
        extraSpecialArgs = {inherit username self stateVersion inputs;};
      };
       "${username}@${l_hostname}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;# > Our main home-manager configuration file <
        modules = [./nixos/desktop/home.nix];
        extraSpecialArgs = {inherit username self l_hostname stateVersion inputs;};
      };
    };
  };
}

