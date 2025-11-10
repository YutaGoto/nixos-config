{ config, lib, pkgs, ... }:

let
  unstable = import <nixpkgs-unstable> { };
in
{
  nixpkgs.overlays = [
    (import ./overlays/cursor.nix)
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "1password-gui"
    "1password"
    "1password-cli"
    "vscode"
    "cursor"
    "postman"
    "slack"
    "google-chrome"
    "ngrok"
  ];

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
    gcc
    appimage-run
    lsof

    # --- rust tools
    bat
    eza

    # --- Web開発 ---
    nodejs_22
    pnpm
    bun
    deno

    # --- Python ---
    uv

    # --- Rust ---
    rustup

    # --- アプリケーション ---
    vscode
    cursor
    unstable.zed-editor
    (pass.withExtensions (exts: [ exts.pass-otp ])) # 1Password CLI連携用
    postman
    slack
    google-chrome
    ngrok
  ];

  # Install firefox.
  programs.firefox.enable = true;

  # Enable the Nix LDFLAGS wrapper for better compatibility with C programs
  programs.nix-ld.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Dockerの有効化
  virtualisation.docker.enable = true;

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
