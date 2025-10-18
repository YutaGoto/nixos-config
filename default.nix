{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./base.nix
    ./locale.nix
    ./fonts.nix
    ./network.nix
    ./users.nix
    ./packages.nix
    ./services.nix
  ];
}
