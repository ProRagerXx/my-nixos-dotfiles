{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gnumake
    curl
    jq
    gum
    binutils
  ];
}
