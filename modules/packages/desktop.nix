{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ptyxis
    gnome-software
    htop
    kitty
    file
    unrar
    flatpak
    appimage-run
  ];
}
