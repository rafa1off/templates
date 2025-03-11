{
  description = "go template";

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

        name = "template";

        nativeBuildInputs = with pkgs; [
          go
          gopls
        ];

        buildInputs = [ ];
      in
      {
        devShells.default = pkgs.mkShell {
          inherit
            name
            buildInputs
            nativeBuildInputs
            ;
        };

        packages.default = pkgs.buildGoModule {
          pname = name;
          src = ./.;

          inherit buildInputs;

          vendorHash = null;
        };

      }
    );
}
