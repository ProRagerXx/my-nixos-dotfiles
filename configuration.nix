# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Martinique";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fetxd = {
    isNormalUser = true;
    description = "fetXd";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
      (discord.override {
        # withOpenASAR = true; # can do this here too
        withVencord = true;
      })
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  programs.steam = {
    enable = true; # Master switch, already covered in installation
    remotePlay.openFirewall = true;  # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports for Source Dedicated Server hosting
    # Other general flags if available can be set here.
  };
  # Tip: For improved gaming performance, you can also enable GameMode:
  # programs.gamemode.enable = true;

  # Enable Flatpak support
  #programs.flatpak.enable = true; #nope

  # KDE integration for Flatpak
  #services.xserver.desktopManager.plasma5.enable = true;  # already have Plasma 6

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  /*nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
  ];*/

  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];

  programs.hyprland.enable = true;

  services.xserver.desktopManager.cinnamon.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    #steam
    #discord
    flatpak
    gnome-software
    htop
    ptyxis
    protonup-qt
    appimage-run
    unrar
    bottles
    file
    binutils
    pkgs.kitty
    #pkgs.fhs-userenv
    git
    gnumake
    curl
    jq
    gum
    (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
      pkgs.buildFHSEnv (base // {
      name = "fhs";
      targetPkgs = pkgs:
        # pkgs.buildFHSEnv provides only a minimal FHS environment,
        # lacking many basic packages needed by most software.
        # Therefore, we need to add them manually.
        #
        # pkgs.appimageTools provides basic packages required by most software.
        (base.targetPkgs pkgs) ++ (with pkgs; [
          pkg-config
          ncurses
          # Feel free to add more packages here if needed.
        ]
      );
      profile = "export FHS=1";
      runScript = "bash";
      extraOutputsToInstall = ["dev"];
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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # enables 32-bit OpenGL
    extraPackages = with pkgs; [
      mesa
      vulkan-loader
      vulkan-tools
    ];
  };

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  /*environment.sessionVariables = {
    STEAM_FORCE_DESKTOPUI_SCALING = "1";
    STEAM_USE_XDG_OPEN = "1";
    STEAM_DISABLE_WAYLAND = "1";
  };*/

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
