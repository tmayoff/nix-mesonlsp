{
  description = "A flake for building mesonlsp";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    # flake-utils.lib.eachDefaultSystem (
    #   system: let
    #     pkgs = import nixpkgs {
    #       inherit system;
    #     };
    #   in {
    #     packages = rec {
    #       mesonlsp = pkgs.callPackage ./package.nix {};
    #       default = mesonlsp;
    #     };
    #   }
    # )
    # //
     {
      overlay.default = final: prev: {
        mesonlsp = import ./package.nix {};
      };
    };
}
