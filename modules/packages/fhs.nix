{ pkgs, ... }:

{
  environment.systemPackages = [

    (let
      base = pkgs.appimageTools.defaultFhsEnvArgs;
    in
      pkgs.buildFHSEnv (base // {
        name = "fhs";

        targetPkgs = pkgs:
          (base.targetPkgs pkgs) ++ (with pkgs; [
            pkg-config
            ncurses
          ]);

        profile = "export FHS=1";
        runScript = "bash";
        extraOutputsToInstall = [ "dev" ];
      }))

    (pkgs.buildFHSEnv {
      name = "etterna-fhs";

      targetPkgs = pkgs: with pkgs; [
        stdenv.cc.cc
        glibc
        glibc.bin
        glibc.dev
        zlib
        SDL2
        freetype
        fontconfig
        libpng
        libjpeg
        libpulseaudio
        alsa-lib
        libGL
        libGLU

        xorg.libX11
        xorg.libXext
        xorg.libXrandr
        xorg.libXrender
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXxf86vm
        xorg.libXfixes
        xorg.libXcomposite
        xorg.libXdamage
        xorg.libXScrnSaver

        vulkan-loader
        ffmpeg
      ];

      extraMounts = [
        {
          source = "${pkgs.glibc}/lib/ld-linux-x86-64.so.2";
          target = "/lib64/ld-linux-x86-64.so.2";
          recursive = false;
        }
      ];

      runScript = "bash";
    })
  ];
}
