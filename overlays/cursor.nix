final: prev: {
  cursor = final.stdenv.mkDerivation rec {
    pname = "cursor";
    version = "2.0.54";

    src = final.fetchurl {
      url = "https://downloads.cursor.com/production/7a31bffd467aa2d9adfda69076eb924e9062cb27/linux/x64/Cursor-${version}-x86_64.AppImage";
      sha256 = "1ysgzxqg5gwmp1sy8m5bc3457rwvm9hkv9x2ccw4s7l0wgb2rnwx";
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
