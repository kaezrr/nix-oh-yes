{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
  };

  outputs = {self, nixpkgs}: {
  	nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
	modules = [ ./configuration.nix ];
	};
  };
}
