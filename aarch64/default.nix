let
  pkgs = import <nixpkgs> { };
  pkgsCross = pkgs.pkgsCross.aarch64-multiplatform.pkgsStatic;
in
pkgsCross.vim.overrideAttrs {
  version = "v9.1.0898";
  src = pkgs.fetchFromGitHub {
    owner = "vim";
    repo = "vim";
    rev = "v9.1.0898";
    hash = "sha256-pZ1zB+c9ZQ3e1H8m5jJ4WeqWmeaHMUENpzd5DNaKtjo=";
  };
}
