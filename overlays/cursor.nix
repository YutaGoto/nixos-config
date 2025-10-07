final: prev: {
  cursor = final.stdenv.mkDerivation rec {
    pname = "cursor";
    version = "1.7.33";

    src = final.fetchurl {
      url = "https://downloads.cursor.com/production/a84f941711ad680a635c8a3456002833186c484f/linux/x64/Cursor-${version}-x86_64.AppImage";
      sha256 = "0vllqj9g99wk9gwnpwcv64p35jxmvd27fpd6ms8izjcwb8szyx3d";
    };

    phases = [ "installPhase" ];

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/cursor
      chmod +x $out/bin/cursor

      mkdir -p $out/share/applications
      cat > $out/share/applications/cursor.desktop <<EOF
[Desktop Entry]
Name=Cursor
Comment=AI code editor
Exec=$out/bin/cursor %F
Icon=utilities-terminal
Type=Application
Terminal=false
Categories=Development;IDE;
EOF
    '';

    nativeBuildInputs = [ final.makeWrapper ];

    meta = with final.lib; {
      description = "Cursor AI code editor ${version} (AppImage wrapped)";
      homepage = "https://cursor.com";
      license = licenses.unfree;
      platforms = [ "x86_64-linux" ];
    };
  };
}
