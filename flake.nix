{
  description = "Home Manager configuration of vik";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
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
