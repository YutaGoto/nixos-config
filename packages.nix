{ config, lib, pkgs, ... }:

{
  # システム全体にインストールするパッケージ
  environment.systemPackages = with pkgs; [
    # --- 基本ツール ---
    git
    wget
    curl
    vim
    wirelesstools
    home-manager
    gnumake

    # --- rust tools
    bat
    eza
 
    # --- Web開発 ---
    nodejs_22
    pnpm

    # --- Ruby ---
    rbenv

    # --- Python ---
    uv

    # --- Rust ---
    rustup

    # --- アプリケーション ---
    vscode
    (pass.withExtensions (exts: [ exts.pass-otp ])) # 1Password CLI連携用
    postman
    slack
    google-chrome
  ];

  # Install firefox.
  programs.firefox.enable = true;

  # Dockerの有効化
  virtualisation.docker.enable = true;

  # 1Password (GUI) とブラウザ連携の有効化
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "1password-gui"
    "1password"
    "1password-cli"
    "vscode"
    "postman"
    "slack"
    "google-chrome"
  ];

  # Alternatively, you could also just allow all unfree packages
  # nixpkgs.config.allowUnfree = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "yourUsernameHere" ];
  };
}
