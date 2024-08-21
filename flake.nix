{
  description = "marsh's lovely little nix flake";

  inputs = {
    nixos-hardware = {
      type = "github";
      owner = "nixos";
      repo = "nixos-hardware";
    };
    nixpkgs = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };
    lix = {
      type = "git";
      url = "https://git.lix.systems/lix-project/nixos-module";
      ref = "release-2.91"; # TODO: 2.92 (main) currently doesn't build
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall = {
      type = "github";
      owner = "snowfallorg";
      repo = "lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs:
    let
      lib = inputs.snowfall.mkLib {
        inherit inputs;
        src = ./.;
        snowfall = {
          namespace = "habitat";
        };
      };
    in
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;
      };
      overlays = with inputs; [ lix.overlays.default ];
      systems.modules.nixos = with inputs; [ ];
      homes.modules = with inputs; [ ];
      outputs-builder = channels: { formatter = channels.nixpkgs.nixfmt-rfc-style; };
    };
}
