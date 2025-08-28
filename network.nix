{ config, pkgs, ... }:

{
  # networking.hostName = "myhostname"; # ←環境に合わせて変更
  networking.networkmanager.enable = true;
}
