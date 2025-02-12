{
  description = "python template";

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

        python = pkgs.python313;

        buildInputs = [
          (python.withPackages (
            pypkgs: with pypkgs; [
            ]
          ))
        ];
      in
      {
        devShells.default = pkgs.mkShell { inherit name buildInputs; };
      }
    );
}
