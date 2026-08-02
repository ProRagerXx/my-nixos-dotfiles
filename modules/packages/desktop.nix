{ pkgs, ... }:

{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    ptyxis
    gnome-software
    htop
    kitty
    file
    unrar
    flatpak
    appimage-run
    nitrogen
  ];
}
