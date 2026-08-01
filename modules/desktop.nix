{ pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;

  services.desktopManager.plasma6.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  services.xserver.desktopManager.lxqt.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.windowManager.openbox.enable = true;

  programs.hyprland.enable = true;

  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  console.keyMap = "fr";

  programs.firefox.enable = true;
}
