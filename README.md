it's my dotfiles
but im in a vm
LMAOO
it's a throwaway nixos lab for testing basically

vibecoded ahh OS

might call this repo
**SIGMA-NIXOS-GAMING-RTX5060-CONFIG-V7**

## How to install
if you somehow want to install this, add this to your existing config if not there already:
```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```
then run:
```sh
sudo nixos-rebuild switch
```
then clone the project:
```sh
git clone https://github.com/ProRagerXx/my-nixos-dotfiles.git
cd my-nixos-dotfiles/
```
then switch to it
```sh
sudo nixos-rebuild switch --flake .#nixos
```
have fun