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
        c = mkWelcomeText {
          path = ./c;
          name = "C Template";
          description = ''
            A basic C application template with a package build.
            To link libraries, put 'exe.linkSystemLibrary("lib")' in the build.zi.
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
