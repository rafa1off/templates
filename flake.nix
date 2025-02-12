{
  description = "my flake templates";

  outputs =
    { self }:
    let
      mkWelcomeText =
        {
          name,
          description,
          path,
          buildTools ? null,
          additionalSetupInfo ? null,
        }:
        {
          inherit path;

          description = name;

          welcomeText = ''
            # ${name}
            ${description}

            ${
              if buildTools != null then
                ''
                  Comes bundled with:
                  ${builtins.concatStringsSep ", " buildTools}
                ''
              else
                ""
            }
            ${
              if additionalSetupInfo != null then
                ''
                  ## Additional Setup
                  To set up the project run:
                  ```sh
                  flutter create .
                  ```
                ''
              else
                ""
            }
          '';
        };
    in
    {
      templates = {
        empty = mkWelcomeText {
          name = "Empty Template";
          description = ''
            A simple flake that provides a devshell
          '';
          path = ./empty;
        };
        rust = mkWelcomeText {
          path = ./rust;
          name = "Rust Template";
          description = ''
            A basic rust application template with a package build.
          '';
          buildTools = [
            "rust-analyzer"
          ];
        };
        zig = mkWelcomeText {
          path = ./zig;
          name = "Zig Template";
          description = ''
            A basic Zig application template with a package build.
          '';
          buildTools = [
            "zig"
            "zls"
          ];
        };
        go = mkWelcomeText {
          path = ./go;
          name = "Go template";
          description = "A basic go project";
          buildTools = [
            "go"
            "gopls"
          ];
        };
        python = mkWelcomeText {
          path = ./python;
          name = "Python Template";
          description = ''
            A basic python project
          '';
          buildTools = [
            "python313"
          ];
        };
        haskell = mkWelcomeText {
          path = ./haskell;
          name = "Haskell Template";
          description = ''
            A basic haskell project with cabal
          '';
          buildTools = [
            "ghc"
            "haskell-language-server"
          ];
        };
        c = mkWelcomeText {
          path = ./c;
          name = "C Template";
          description = ''
            A basic C application template with a package build.
            Lots of comments to help you configure it to your liking.
          '';
          buildTools = [
            "zig"
            "clang-tools"
            "pkg-config"
          ];
        };
      };
    };
}
