# allow our nixpkgs import to be overridden if desired
{ pkgs, ... }:

# let's write an actual basic derivation
# this uses the standard nixpkgs mkDerivation function
pkgs.stdenv.mkDerivation {

  # name of our derivation
  name = "sddm-theme";

  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    hash = "sha256-flOspjpYezPvGZ6b4R/Mr18N7N3JdytCSwwu6mf4owQ=";
  };

  # src = pkgs.fetchurl {
  #   url = "https://framagit.org/MarianArlt/sddm-sugar-candy/-/archive/v.1.1/sddm-sugar-candy-v.1.1.zip";
  #   hash = "sha256-8WRBWDtihswTHz2DZI0X0JE30hDJH0cg09CGo8EOaTQ=";
  # };

  dontUnpack = true;

  # see https://nixos.org/nixpkgs/manual/#ssec-install-phase
  # $src is defined as the location of our `src` attribute above
  installPhase = ''
    # $out is an automatically generated filepath by nix,
    # but it's up to you to make it what you need. We'll create a directory at
    # that filepath, then copy our sources into it.
    mkdir $out
    cp -R $src/* $out
    rm $out/Background.jpg
    cp ${./sddm-tron.png} $out/Background.jpg
  '';
}
