{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];

  # Bootloader
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };

  # Latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Locale / timezone
  time.timeZone = "America/Martinique";
  i18n.defaultLocale = "en_US.UTF-8";

  # Printing
  services.printing.enable = true;

  # Allow proprietary packages
  nixpkgs.config.allowUnfree = true;

  # Nix features
  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # State version
  system.stateVersion = "25.11";
}
