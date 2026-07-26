{ pkgs, ... }:

{
  users.users.fetxd = {
    isNormalUser = true;
    description = "fetXd";

    extraGroups = [
      "wheel"
      "networkmanager"
    ];

    packages = with pkgs; [
      kdePackages.kate

      (discord.override {
        withVencord = true;
      })
    ];
  };

  users.users.ffffff = {
    isNormalUser = true;
    description = "poop";

    extraGroups = [
      "wheel"
      "networkmanager"
    ];

    packages = with pkgs; [
      #kdePackages.kate

      (discord.override {
        withVencord = true;
      })
    ];
  };
}
