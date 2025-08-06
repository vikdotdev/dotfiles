{
  description = "NixOS and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # NixOS configurations
    nixosConfigurations = {
      umbra = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix
          ./nixos/profiles/umbra.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.vik = {
              imports = [
                ./home-manager/modules/common.nix
                ./home-manager/profiles/umbra.nix
              ];
            };
          }
        ];
      };
      
      reddwarf = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix
          ./nixos/profiles/reddwarf.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.vik = {
              imports = [
                ./home-manager/modules/common.nix
                ./home-manager/profiles/reddwarf.nix
              ];
            };
          }
        ];
      };
      
      redgiant = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix
          ./nixos/profiles/redgiant.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.vik = {
              imports = [
                ./home-manager/modules/common.nix
                ./home-manager/profiles/redgiant.nix
              ];
            };
          }
        ];
      };
    };

    # Standalone Home Manager configurations (for non-NixOS systems like Fedora)
    homeConfigurations = {
      # Default profile (umbra - desktop)
      "vik@umbra" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home-manager/profiles/umbra.nix
          ./home-manager/modules/common.nix
        ];
      };
      
      # Laptop profiles
      "vik@reddwarf" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home-manager/profiles/reddwarf.nix
          ./home-manager/modules/common.nix
        ];
      };
      
      "vik@redgiant" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home-manager/profiles/redgiant.nix
          ./home-manager/modules/common.nix
        ];
      };
      
      # Default fallback
      "vik" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home-manager/profiles/umbra.nix  # Default to umbra config
          ./home-manager/modules/common.nix
        ];
      };
    };
  };
}
