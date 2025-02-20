{
  description = "empty template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { system = system; };

        name = "template";

        buildInputs = [ ];
      in
      {
        devShells.default = pkgs.mkShell { inherit name buildInputs; };
      }
    );
}
