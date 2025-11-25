{
  description = "YutaGoto NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable }: {
    nixosConfigurations = {
      yutagoto = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          # Pass flake inputs to modules
          unstablePkgs = import nixpkgs-unstable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [
          # 既存のdefault.nixをインポートして設定の中核とします
          ./default.nix

          # overlays/cursor.nix をオーバーレイとして適用します
          {
            nixpkgs.overlays = [
              (import ./overlays/cursor.nix)
            ];
          }
        ];
      };
    };
  };
}
