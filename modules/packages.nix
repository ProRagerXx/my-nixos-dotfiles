{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    flatpak
    gnome-software
    htop
    ptyxis
    protonup-qt
    appimage-run
    fastfetch
    unrar
    bottles
    file
    binutils
    kitty
    git
    gnumake
    nitrogen
    curl
    jq
    gum

    # FHS env
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

    # Etterna env
    (pkgs.buildFHSEnv {
      name = "etterna-fhs";

      targetPkgs = pkgs: with pkgs; [
        SDL2
        freetype
        fontconfig
        ffmpeg
        vulkan-loader
      ];

      runScript = "bash";
    })
  ];
}
