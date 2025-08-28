{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    ipafont
    source-han-sans
    source-han-serif
  ];

  fonts.fontconfig.enable = true;
}
