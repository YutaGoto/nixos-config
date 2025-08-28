{ config, pkgs, ... }:

{
  users.users.yutagoto = {
    isNormalUser = true;
    description = "YutaGoto";
    # `wheel`グループで管理者権限, `docker`グループでDockerコマンドの実行権限
    extraGroups = [ "wheel" "docker" "networkmanager" ];
  };
}
