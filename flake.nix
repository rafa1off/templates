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
          '';
        };
    in
    {
      templates = {
        empty = mkWelcomeText {
          path = ./empty;
          name = "Empty Template";
          description = ''
            Empty template for custom package building.
          '';
          buildTools = null;
        };
        c = mkWelcomeText {
          path = ./c;
          name = "C Template";
          description = ''
            A basic C application template with a package build.
            To link libraries, put 'exe.linkSystemLibrary("lib")' in the build.zig.
          '';
          buildTools = [
            "clang-tools"
            "pkg-config"
            "zig"
          ];
        };
        python = mkWelcomeText {
          path = ./python;
          name = "Python Template";
          description = ''
            A basic Python project
          '';
          buildTools = [
            "pyright"
            "python3"
          ];
        };
        rust = mkWelcomeText {
          path = ./rust;
          name = "Rust Template";
          description = ''
            A basic Rust project with rust-toolchain.toml for toolchain choice
          '';
          buildTools = [
            "pkg-config"
            "rust-analyzer"
            "rustup"
          ];
        };
      };
    };
}
