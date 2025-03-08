{
  description = "python template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      flake-utils,
      nixpkgs,
      self,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        name = "python-template";

        python = pkgs.python313;

        buildInputs = with pkgs; [
          (python.withPackages (
            pypkgs: with pypkgs; [
            ]
          ))
          pyright
        ];
      in
      {
        devShells.default = pkgs.mkShell { inherit name buildInputs; };
      }
    );
}
