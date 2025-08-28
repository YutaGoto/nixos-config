{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # CapsLockキーをEscキーとして機能させる (タッチバーのEscの代替)
  services.xserver.xkb.options = "caps:escape";
  services.xserver.exportConfiguration = true;

  services.printing.enable = true;
  services.openssh.enable = true;

  # Nix Flakesと新しいnix-commandを有効化 (推奨)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.bash.shellAliases = {
    wifix = "sudo iwconfig wlp3s0 txpower 10dBm";
  };

  systemd.tmpfiles.rules = [
    "L /bin/bash - - - - /run/current-system/sw/bin/bash"
  ];

  system.stateVersion = "25.05";
}
