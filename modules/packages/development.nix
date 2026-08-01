{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gnumake
    fastfetch
    curl
    jq
    gum
    binutils
  ];
}
