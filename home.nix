{ pkgs, inputs, ... }:

{
  home.username = "fetxd";
  home.homeDirectory = "/home/fetxd";

  home.stateVersion = "25.11";

  home.packages = [
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-stable
  ];
}
